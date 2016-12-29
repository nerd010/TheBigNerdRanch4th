//
//  AppDelegate.m
//  BNRHomepwner
//
//  Created by Richard Wang on 2016/11/30.
//  Copyright © 2016年 Richard Wang. All rights reserved.
//

#import "AppDelegate.h"
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"

NSString * const BNRNextItemValuePrefsKey = @"NextItemValue";
NSString * const BNRNextItemNamePrefsKey = @"NextItemName";

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)initialize
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *factorySettings = @{BNRNextItemValuePrefsKey: @75,
                                      BNRNextItemNamePrefsKey: @"Coffee Cup"};
    [defaults registerDefaults:factorySettings];
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    //没有触发状态恢复
    if (!self.window.rootViewController)
    {
        BNRItemsViewController *itemsViewController = [[BNRItemsViewController alloc] init];
        //创建 UINavigationController 对象
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
        navController.restorationIdentifier = NSStringFromClass([navController class]);
        self.window.rootViewController = navController;
    }

    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    BOOL success = [[BNRItemStore sharedStore] saveChanges];
    if (success)
    {
        NSLog(@"Saved all of the BNRItems");
    }
    else
    {
        NSLog(@"Could not save any of the BNRItems");
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    //创建新的 UINavigationController 对象
    UIViewController *vc = [[UINavigationController alloc] init];
    vc.restorationIdentifier = [identifierComponents lastObject];
    if ([identifierComponents count] == 1)
    {
        self.window.rootViewController = vc;
    }
    
    return vc;
}

@end
