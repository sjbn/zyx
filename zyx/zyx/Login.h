//
//  Login.h
//  zyx
//
//  Created by gusijian on 16/4/3.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "BNApiResult.h"

@interface Login : NSObject
//请求
@property (readwrite, nonatomic, strong) NSString *phoneNumber, *password, *j_captcha;
@property (readwrite, nonatomic, strong) NSNumber *remember_me;
/** token*/
@property(nonatomic,strong) NSString * token;


- (void) loginWithBlock:(void (^)(BNApiResult*))block;


+ (BOOL) isLogin;
+ (void) Logout;
+ (User *)curLoginUser;
+ (void)setAccountWithCurUser;

@end
