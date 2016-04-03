//
//  Login.h
//  zyx
//
//  Created by gusijian on 16/4/3.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Login : NSObject
//请求
@property (readwrite, nonatomic, strong) NSString *phoneNumber, *password, *j_captcha;
@property (readwrite, nonatomic, strong) NSNumber *remember_me;

- (NSString *)goToLoginTipWithCaptcha:(BOOL)needCaptcha;
- (NSString *)toPath;
- (NSDictionary *)toParams;

+ (BOOL) isLogin;
+ (void) doLogin:(NSDictionary *)loginData;
+ (void) doLogout;
//+ (void)setPreUserEmail:(NSString *)emailStr;
//+ (NSString *)preUserEmail;
+ (User *)curLoginUser;
+ (void)setXGAccountWithCurUser;
+ (User *)userWithGlobaykeyOrEmail:(NSString *)textStr;
+ (NSMutableDictionary *)readLoginDataList;
//+(BOOL)isLoginUserGlobalKey:(NSString *)global_key;
@end
