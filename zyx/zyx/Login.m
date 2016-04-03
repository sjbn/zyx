//
//  Login.m
//  zyx
//
//  Created by gusijian on 16/4/3.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#define kLoginStatus @"login_status"
#define kLoginPreUserEmail @"pre_user_email"
#define kLoginUserDict @"user_dict"
#define kLoginDataListPath @"login_data_list_path.plist"

#import "AppDelegate.h"
#import "Login.h"
#import <CommonCrypto/CommonDigest.h>
#import "MJExtension.h"



static User *curLoginUser;

@implementation Login
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.remember_me = [NSNumber numberWithBool:YES];
        self.phoneNumber = @"";
        self.password = @"";
    }
    return self;
}

- (NSString *)toPath{
    return @"api/v2/account/login";
}
- (NSDictionary *)toParams{
    NSMutableDictionary *params = @{@"account": self.phoneNumber,
                                    @"password" : [self sha1Str: self.password],
                                    @"remember_me" : self.remember_me? @"true" : @"false",}.mutableCopy;
    if (self.j_captcha.length > 0) {
        params[@"j_captcha"] = self.j_captcha;
    }
    return params;
}
-(NSString*) sha1Str:(NSString*) str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}


- (NSString *)goToLoginTipWithCaptcha:(BOOL)needCaptcha{
    if (!_phoneNumber || _phoneNumber.length <= 0) {
        return @"请填写「手机号码」";
    }
    if (!_password || _password.length <= 0) {
        return @"请填写密码";
    }
    if (needCaptcha && (!_j_captcha || _j_captcha.length <= 0)) {
        return @"请填写验证码";
    }
    return nil;
}

+ (BOOL)isLogin{
    NSNumber *loginStatus = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginStatus];
    if (loginStatus.boolValue && [Login curLoginUser]) {
        User *loginUser = [Login curLoginUser];
        if (loginUser.status && loginUser.status.integerValue == 0) {
            return NO;
        }
        return YES;
    }else{
        return NO;
    }
}

+ (void)doLogin:(NSDictionary *)loginData{
    
    if (loginData) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:kLoginStatus];
        [defaults setObject:loginData forKey:kLoginUserDict];
        curLoginUser =[User mj_objectWithKeyValues:loginData];
        [defaults synchronize];
        [Login setXGAccountWithCurUser];
        
        [self saveLoginData:loginData];
    }else{
        [Login doLogout];
    }
}

+ (NSMutableDictionary *)readLoginDataList{
    NSMutableDictionary *loginDataList = [NSMutableDictionary dictionaryWithContentsOfFile:[self loginDataListPath]];
    if (!loginDataList) {
        loginDataList = [NSMutableDictionary dictionary];
    }
    return loginDataList;
}

+ (BOOL)saveLoginData:(NSDictionary *)loginData{
    BOOL saved = NO;
    if (loginData) {
        NSMutableDictionary *loginDataList = [self readLoginDataList];
        User *curUser =[User mj_objectWithKeyValues:loginData];
        if (curUser.user_id.length > 0) {
            [loginDataList setObject:loginData forKey:curUser.user_id];
            saved = YES;
        }
        if (curUser.phoneNumber.length > 0) {
            [loginDataList setObject:loginData forKey:curUser.phoneNumber];
            saved = YES;
        }
        if (saved) {
            saved = [loginDataList writeToFile:[self loginDataListPath] atomically:YES];
        }
    }
    return saved;
}

+ (NSString *)loginDataListPath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentPath stringByAppendingPathComponent:kLoginDataListPath];
}

+ (User *)userWithGlobaykeyOrEmail:(NSString *)textStr{
    if (textStr.length <= 0) {
        return nil;
    }
    NSMutableDictionary *loginDataList = [self readLoginDataList];
    NSDictionary *loginData = [loginDataList objectForKey:textStr];
    return [User mj_objectWithKeyValues:loginData];
}

+ (void)setXGAccountWithCurUser{
    if ([self isLogin]) {
        User *user = [Login curLoginUser];
        if (user && user.user_id.length > 0) {
            NSString *global_key = user.user_id;
            //[XGPush setAccount:global_key];
            [(AppDelegate *)[UIApplication sharedApplication].delegate registerPush];
        }
    }else{
//        [XGPush setAccount:nil];
//        [XGPush unRegisterDevice];
    }
}

+ (void)doLogout{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:kLoginStatus];
    [defaults synchronize];
    //删掉 coding 的 cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.domain hasSuffix:kDomain]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:obj];
        }
    }];
    [Login setXGAccountWithCurUser];
}

//+ (void)setPreUserEmail:(NSString *)emailStr{
//    if (emailStr.length <= 0) {
//        return;
//    }
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:emailStr forKey:kLoginPreUserEmail];
//    [defaults synchronize];
//}
//
//+ (NSString *)preUserEmail{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    return [defaults objectForKey:kLoginPreUserEmail];
//}

+ (User *)curLoginUser{
    if (!curLoginUser) {
        NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
        curLoginUser = loginData? [User mj_objectWithKeyValues:loginData]: nil;
    }
    return curLoginUser;
}

//+(BOOL)isLoginUserGlobalKey:(NSString *)global_key{
//    if (global_key.length <= 0) {
//        return NO;
//    }
//    return [[self curLoginUser].global_key isEqualToString:global_key];
//}
@end
