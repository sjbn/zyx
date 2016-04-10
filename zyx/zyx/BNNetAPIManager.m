//
//  BNNetAPIManager.m
//  zyx
//
//  Created by gusijian on 16/4/2.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#define kUrl_User_Login @"user/Login"
#define kUrl_User_Register @"user/Register"
#define kUrl_User_Register @"user/Logout"


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
    NSString * path=@"user/CaptchaCode";
    
    NSMutableDictionary*parameters =[NSMutableDictionary dictionary];
    parameters[@"phoneNumber"] = number;
    [[BNNetAPIClient sharedHTTPClient] requestJsonDataWithPath:path withParams:parameters withMethodType:Get andBlock:block];
}

#pragma mark login
-(void)request_Login_WithParams:(id)params andBlock:(void (^)(id, NSError *))block
{
    [[BNNetAPIClient sharedHTTPClient] requestJsonDataWithPath:kUrl_User_Login withParams:params withMethodType:Post andBlock:block];
}
-(void)request_Register_WithParams:(id)params andBlock:(void (^)(id, NSError *))block
{
    [[BNNetAPIClient sharedHTTPClient] requestJsonDataWithPath:kUrl_User_Register withParams:params withMethodType:Post andBlock:block];
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
