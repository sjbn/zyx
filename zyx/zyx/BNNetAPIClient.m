//
//  BNNetAPIClient.m
//  zyx
//
//  Created by gusijian on 16/4/2.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#define kNetworkMethodName @[@"Get", @"Post", @"Put", @"Delete"]
#import "BNNetAPIClient.h"

@implementation BNNetAPIClient
+ (BNNetAPIClient *)sharedHTTPClient {
    static BNNetAPIClient *_sharedHTTPClient =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:KBaseUrlStr]];
    });
    return _sharedHTTPClient;
}
- (instancetype)initWithBaseURL:(NSURL*)url{
    self =[super initWithBaseURL:url];
    if(self){
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (void)request_Captcha:(NSString *)number andBlock:(void (^)(id data, NSError *error))block{
    NSMutableDictionary*parameters =[NSMutableDictionary dictionary];
    parameters[@"phoneNumber"] = number;
    [self GET:@"user/CaptchaCode" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
}
@end
