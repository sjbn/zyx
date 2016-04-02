//
//  BNNetAPIClient.h
//  zyx
//
//  Created by gusijian on 16/4/2.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"



typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

@interface BNNetAPIClient:AFHTTPSessionManager
+(instancetype)sharedHTTPClient;
+ (id)sharedJsonClient;
+ (id)changeJsonClient;

-(void)request_Captcha:(NSString *)number andBlock:(void (^)(id data, NSError *error))block;
- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                           file:(NSDictionary *)file
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                       andBlock:(void (^)(id data, NSError *error))block;
//
//
//- (void)reportIllegalContentWithType:(IllegalContentType)type
//                          withParams:(NSDictionary*)params;
//
//- (void)uploadImage:(UIImage *)image path:(NSString *)path name:(NSString *)name
//       successBlock:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//       failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//      progerssBlock:(void (^)(CGFloat progressValue))progress;
//
//- (void)uploadVoice:(NSString *)file
//           withPath:(NSString *)path
//         withParams:(NSDictionary*)params
//           andBlock:(void (^)(id data, NSError *error))block;
@end
