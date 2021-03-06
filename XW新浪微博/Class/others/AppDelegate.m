//
//  AppDelegate.m
//  XW新浪微博
//
//  Created by bbq on 15/7/8.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "AppDelegate.h"

#import "XWTabBarViewController.h"
#import "XWOAuthViewController.h"
#import "XWAccount.h"
#import "XWAccountTool.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"


@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.statusBarHidden=NO;
//    application.statusBarStyle=UIStatusBarStyleLightContent;
   
    self.window=[[UIWindow alloc]init];
    self.window.frame=[UIScreen mainScreen].bounds;
    XWAccount* account=[XWAccountTool getAccount];
    if (account) {
        self.window.rootViewController=[[XWTabBarViewController alloc]init];
    }else{
    self.window.rootViewController=[[XWOAuthViewController alloc]init];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIBackgroundTaskIdentifier taskID=[application beginBackgroundTaskWithExpirationHandler:^{
    [application endBackgroundTask:taskID];
    }];
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
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
