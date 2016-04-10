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
#import "BNNetAPIManager.h"
#import "BNApiResult.h"


static User *curLoginUser;

@implementation Login
- (instancetype)init
{
    self = [super init];
    if (self) {
        //self.remember_me = [NSNumber numberWithBool:YES];
        self.phoneNumber = @"";
        self.password = @"";
    }
    return self;
}
-(void)loginWithBlock:(void (^)(BNApiResult*))block{
    
    BNApiResult *result=[[BNApiResult alloc]init];
    result.IsSuccess=YES;
    if(!self.phoneNumber||[self.phoneNumber isEqual:@""])
    {
        result.IsSuccess=false;
        result.Error=@"请输入手机号";
    }
    if(!self.password||[self.password isEqual:@""])
    {
        result.IsSuccess=false;
        result.Error=[NSString stringWithFormat:@"%@ 请输入密码",result.Error] ;
    }
    if(!result.IsSuccess)
    {
        if(block){
            block(result);
        }
            return;
    }
    
    
    [[BNNetAPIManager sharedManager] request_Login_WithParams:[self mj_keyValues] andBlock:^(id data, NSError *error) {
    
        BNApiResult *result=[BNApiResult mj_objectWithKeyValues:data];
        DebugLog(@"%@",result);
        if(result.IsSuccess)
        {
            //save token
            curLoginUser=[[User alloc]init];
            curLoginUser.password=self.password;
            curLoginUser.phoneNumber=self.phoneNumber;
            curLoginUser.status=@1;
            curLoginUser.token=result.Data;
            curLoginUser.loginAt=[NSDate date];

        }
        else{
            curLoginUser=nil;
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:[curLoginUser mj_keyValues] forKey:kLoginUserDict];
        [defaults synchronize];
        
        [Login setAccountWithCurUser];
        if (block) {
            block(result);
        }
    }];    
}
+(void)Logout{
    curLoginUser=nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[curLoginUser mj_keyValues] forKey:kLoginUserDict];
    [defaults synchronize];
    //删掉 coding 的 cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.domain hasSuffix:kDomain]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:obj];
        }
    }];
    [Login setAccountWithCurUser];
    
}
//todo
+ (void)setAccountWithCurUser{
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


+ (User *)curLoginUser{
    if (!curLoginUser) {
                NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
                curLoginUser = loginData? [User mj_objectWithKeyValues:loginData]: nil;
        //curLoginUser=[[NSUserDefaults standardUserDefaults] objectForKey:kLoginUserDict];
    }
    return curLoginUser;
}

+(BOOL)isLogin
{
  
    return curLoginUser&&[curLoginUser.status isEqual:@1];
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

@end
