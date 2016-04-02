//
//  BNNetAPIManager.m
//  zyx
//
//  Created by gusijian on 16/4/2.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import "BNNetAPIManager.h"
#import "BNNetAPIClient.h"

@implementation BNNetAPIManager
+ (instancetype)sharedManager {
    static BNNetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

-(void)request_Captcha:(NSString *)number andBlock:(void (^)(id data, NSError *error))block
{
    [[BNNetAPIClient sharedHTTPClient] request_Captcha:number andBlock:block];
}
//-(void)test
//{
//    NSString *path = @"api/v2/account/register";
//    [[BNNetAPIManager sharedJsonClient] requestJsonDataWithPath:path withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
//        id resultData = [data valueForKeyPath:@"data"];
//        if (resultData) {
//            [MobClick event:kUmeng_Event_Request_ActionOfServer label:@"注册_V2"];
//            
//            User *curLoginUser = [NSObject objectOfClass:@"User" fromJSON:resultData];
//            if (curLoginUser) {
//                [Login doLogin:resultData];
//            }
//            block(curLoginUser, nil);
//        }else{
//            block(nil, error);
//        }
//    }];
//}
@end
