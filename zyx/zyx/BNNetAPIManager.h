//
//  BNNetAPIManager.h
//  zyx
//
//  Created by gusijian on 16/4/2.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNNetAPIManager : NSObject

+ (instancetype)sharedManager;

#pragma mark login

-(void)request_Captcha:(NSString *)number andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Register_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;
- (void)request_Login_WithPath:(id)params andBlock:(void (^)(id data, NSError *error))block;

- (void)request_UserInfo_WithPath:(id)params andBlock:(void (^)(id data, NSError *error))block;
    
@end
