//
//  BNBaseViewController.h
//  zyx
//
//  Created by gusijian on 16/4/2.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNBaseViewController : UIViewController
- (void)tabBarItemClicked;
- (void)loginOutToLoginVC;


+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState;
+ (UIViewController *)analyseVCFromLinkStr:(NSString *)linkStr;
+ (void)presentLinkStr:(NSString *)linkStr;
+ (UIViewController *)presentingVC;
+ (void)presentVC:(UIViewController *)viewController;
@end
