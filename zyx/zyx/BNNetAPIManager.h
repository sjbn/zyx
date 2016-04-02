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

#pragma mark test

-(void)request_Captcha:(NSString *)number andBlock:(void (^)(id data, NSError *error))block;
@end
