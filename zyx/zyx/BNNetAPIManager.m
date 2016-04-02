//
//  BNNetAPIManager.m
//  zyx
//
//  Created by gusijian on 16/4/2.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import "BNNetAPIManager.h"

@implementation BNNetAPIManager
+ (instancetype)sharedManager {
    static BNNetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}
@end
