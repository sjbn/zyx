//
//  BNRootTabController.m
//  zyx
//
//  Created by gusijian on 16/4/2.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import "BNRootTabController.h"
#import "BNHome_RootViewController.h"
#import "BNOrder_RootViewController.h"
#import "BNTask_RootViewController.h"
#import "BNMe_RootViewController.h"


@interface BNRootTabController ()<UITabBarControllerDelegate>

@end

@implementation BNRootTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Private_M
- (void)setupViewControllers {
    
    BNHome_RootViewController *home=[[BNHome_RootViewController alloc]init];
    UINavigationController *nav_home=[[BNBaseNavigationController alloc]initWithRootViewController:home];
    
    
    BNOrder_RootViewController *order=[[BNOrder_RootViewController alloc]init];
    UINavigationController *nav_order=[[BNBaseNavigationController alloc]initWithRootViewController:order];
    
    BNTask_RootViewController *task=[[BNTask_RootViewController alloc]init];
    UINavigationController *nav_task=[[BNBaseNavigationController alloc]initWithRootViewController:task];
    
    BNMe_RootViewController *me=[[BNMe_RootViewController alloc]init];
    UINavigationController *nav_me=[[BNBaseNavigationController alloc]initWithRootViewController:me];
    
    self.viewControllers=@[nav_home,nav_task,nav_order,nav_me];
    self.delegate=self;
    
//    Project_RootViewController *project = [[Project_RootViewController alloc] init];
//    RAC(project, rdv_tabBarItem.badgeValue) = [RACSignal combineLatest:@[RACObserve([UnReadManager shareManager], project_update_count)]
//                                                                reduce:^id(NSNumber *project_update_count){
//                                                                    return project_update_count.integerValue > 0? kBadgeTipStr : @"";
//                                                                }];
//    UINavigationController *nav_project = [[BNBaseNavigationController alloc] initWithRootViewController:project];
//    
//    MyTask_RootViewController *mytask = [[MyTask_RootViewController alloc] init];
//    UINavigationController *nav_mytask = [[BaseNavigationController alloc] initWithRootViewController:mytask];
//    
//    RKSwipeBetweenViewControllers *nav_tweet = [RKSwipeBetweenViewControllers newSwipeBetweenViewControllers];
//    [nav_tweet.viewControllerArray addObjectsFromArray:@[[Tweet_RootViewController newTweetVCWithType:Tweet_RootViewControllerTypeAll],
//                                                         [Tweet_RootViewController newTweetVCWithType:Tweet_RootViewControllerTypeFriend],
//                                                         [Tweet_RootViewController newTweetVCWithType:Tweet_RootViewControllerTypeHot]]];
//    nav_tweet.buttonText = @[@"冒泡广场", @"朋友圈", @"热门冒泡"];
//    
//    Message_RootViewController *message = [[Message_RootViewController alloc] init];
//    RAC(message, rdv_tabBarItem.badgeValue) = [RACSignal combineLatest:@[RACObserve([UnReadManager shareManager], messages),
//                                                                         RACObserve([UnReadManager shareManager], notifications)]
//                                                                reduce:^id(NSNumber *messages, NSNumber *notifications){
//                                                                    NSString *badgeTip = @"";
//                                                                    NSNumber *unreadCount = [NSNumber numberWithInteger:messages.integerValue +notifications.integerValue];
//                                                                    if (unreadCount.integerValue > 0) {
//                                                                        if (unreadCount.integerValue > 99) {
//                                                                            badgeTip = @"99+";
//                                                                        }else{
//                                                                            badgeTip = unreadCount.stringValue;
//                                                                        }
//                                                                    }
//                                                                    return badgeTip;
//                                                                }];
//    UINavigationController *nav_message = [[BaseNavigationController alloc] initWithRootViewController:message];
//    
//    Me_RootViewController *me = [[Me_RootViewController alloc] init];
//    me.isRoot = YES;
//    UINavigationController *nav_me = [[BaseNavigationController alloc] initWithRootViewController:me];
//    
//    [self setViewControllers:@[nav_project, nav_mytask, nav_tweet, nav_message, nav_me]];
    
    [self customizeTabBarForController];
    self.delegate = self;
}

- (void)customizeTabBarForController {
    
    NSArray *tabBarItemImages = @[@"tweet",@"project", @"task", @"me"];
    NSArray *tabBarItemTitles = @[@"主页",@"项目", @"任务",  @"我"];
    
    NSInteger index = 0;
    for (UITabBarItem *item in [[self tabBar] items]) {
        
        [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                            [tabBarItemImages objectAtIndex:index]]]];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        index++;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
//    if ([nav isKindOfClass:[RKSwipeBetweenViewControllers class]]) {
//        RKSwipeBetweenViewControllers *swipeVC = (RKSwipeBetweenViewControllers *)nav;
//        if ([[swipeVC curViewController] isKindOfClass:[BaseViewController class]]) {
//            BaseViewController *rootVC = (BaseViewController *)[swipeVC curViewController];
//            [rootVC tabBarItemClicked];
//        }
//    }else{
//        if ([nav.topViewController isKindOfClass:[BaseViewController class]]) {
//            BaseViewController *rootVC = (BaseViewController *)nav.topViewController;
//            [rootVC tabBarItemClicked];
//        }
//    }
    return YES;
}
@end
