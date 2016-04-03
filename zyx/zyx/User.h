//
//  User.h
//  zyx
//
//  Created by gusijian on 16/4/3.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
/** <#comments#>*/
@property(nonatomic,strong) NSString * phoneNumber,*password,*user_id;
@property (readwrite, nonatomic, strong) NSNumber *status;
@property (readwrite, nonatomic, strong) NSDate *created_at, *last_logined_at, *last_activity_at, *updated_at;

@end
