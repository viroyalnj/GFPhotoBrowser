//
//  AppDelegate.m
//  GFPhotoBrowser
//
//  Created by guofengld on 11/04/2016.
//  Copyright (c) 2016 guofengld. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PhotoSelectViewController.h"

@implementation AppDelegate

+ (instancetype)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UIViewController *vc1 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithType:PHAssetCollectionTypeAlbum]];
    
    UIViewController *vc2 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithType:PHAssetCollectionTypeSmartAlbum]];
    
    UIViewController *vc3 = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithType:PHAssetCollectionTypeMoment]];
    
    UIViewController *vc4 = [[UINavigationController alloc] initWithRootViewController:[[PhotoSelectViewController alloc] init]];
    
    vc1.tabBarItem.image = [UIImage imageNamed:@"ic_heart"];
    vc2.tabBarItem.image = [UIImage imageNamed:@"ic_heart"];
    vc3.tabBarItem.image = [UIImage imageNamed:@"ic_heart"];
    vc4.tabBarItem.image = [UIImage imageNamed:@"ic_heart"];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    [tab setViewControllers:@[vc1, vc2, vc3, vc4]];
    
    self.window.rootViewController = tab;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
