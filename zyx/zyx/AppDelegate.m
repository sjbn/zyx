//
//  AppDelegate.m
//  zyx
//
//  Created by gusijian on 16/4/1.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIImageView+WebCache.h"
#import "BNRootTabController.h"





@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //网络
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //sd加载的数据类型
    [[[SDWebImageManager sharedManager] imageDownloader] setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    
    //设置导航条样式
    [self customizeInterface];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
//    //UIWebView 的 User-Agent
//    [self registerUserAgent];
    
//    if ([Login isLogin]) {
        [self setupTabViewController];
//    }else{
//        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
//        [self setupIntroductionViewController];
//    }
    [self.window makeKeyAndVisible];
//    [FunctionIntroManager showIntroPage];
//    
//    EaseStartView *startView = [EaseStartView startView];
//    @weakify(self);
//    [startView startAnimationWithCompletionBlock:^(EaseStartView *easeStartView) {
//        @strongify(self);
//        [self completionStartAnimationWithOptions:launchOptions];
//    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)setupTabViewController{
    BNRootTabController *rootVC = [[BNRootTabController alloc] init];
    rootVC.tabBar.translucent = YES;
    
    [self.window setRootViewController:rootVC];
}
- (void)customizeInterface {
    //设置Nav的背景色和title色
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"0x3bbd79" ]] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTintColor:[UIColor whiteColor]];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                                     NSForegroundColorAttributeName: [UIColor whiteColor],
                                     };
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
    [[UITextField appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];//设置UITextField的光标颜色
    [[UITextView appearance] setTintColor:[UIColor colorWithHexString:@"0x3bbc79"]];//设置UITextView的光标颜色
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageWithColor:kColorTableSectionBg] forBarPosition:0 barMetrics:UIBarMetricsDefault];
}

#pragma mark - Core Data stack



#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
