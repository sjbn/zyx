//
//  BNApiResult.h
//  zyx
//
//  Created by gusijian on 16/4/10.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNApiResult : NSObject
/** issuccess*/
@property(nonatomic,assign) BOOL IsSuccess;
/** Error*/
@property(nonatomic,strong) NSString * Error;
/** message*/
@property(nonatomic,strong) NSString * Message;
/** data*/
@property(nonatomic,strong) NSString * Data;
@end
