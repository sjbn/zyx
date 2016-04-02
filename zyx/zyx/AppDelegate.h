//
//  AppDelegate.h
//  zyx
//
//  Created by gusijian on 16/4/1.
//  Copyright © 2016年 gusijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property ( strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property ( strong, nonatomic) NSManagedObjectModel * managedObjectModel;
@property ( strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)setupTabViewController;
- (void)setupLoginViewController;
- (void)setupIntroductionViewController;

/**
 *  注册推送
 */
- (void)registerPush;
@end

