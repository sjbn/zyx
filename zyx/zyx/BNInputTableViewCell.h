//
//  BNInputTableViewCell.h
//  zyx
//
//  Created by gusijian on 16/4/9.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNInputTableViewCell : UITableViewCell
/** text feild*/
@property(nonatomic,strong) UITextField * textField;

/** verify button*/
@property(nonatomic,strong) UIButton * verifybtn;



@property (nonatomic,copy) void(^textValueChangedBlock)(NSString *);
@property (nonatomic,copy) void(^editDidBeginBlock)(NSString *);
@property (nonatomic,copy) void(^editDidEndBlock)(NSString *);
@end
