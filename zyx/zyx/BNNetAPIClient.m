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
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block{
    
    if (!aPath || aPath.length <= 0) {
        return;
    }
    //log请求数据
    DebugLog(@"\n===========request===========\n%@\n%@:\n%@", kNetworkMethodName[method], aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    switch (method) {
        case Get:{
            [self GET:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];}
            break;
        case Post:{
            [self POST:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                block(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                block(nil,error);
            }];}
            break;
            default:
            break;
    }
}
@end
