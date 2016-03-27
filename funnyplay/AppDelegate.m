//
//  AppDelegate.m
//  funnyplay
//
//  Created by cash on 15-3-16.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "AppDelegate.h"
#import "Tool.h"
#import "FPTabBarController.h"

#import <SMS_SDK/SMS_SDK.h>
#import <AFNetworkActivityIndicatorManager.h>

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置 状态栏_网络指示器
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    
    FPTabBarController *fpTabBarC = [FPTabBarController new];
    fpTabBarC.delegate = self;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = fpTabBarC;
    [self.window makeKeyAndVisible];
    
    
    /************ 控件外观设置 **************/
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //这个就是bar的颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor blueTintColor]];
    //这个是title的颜色
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    //这个是左右按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    [[UITabBar appearance] setTintColor:[UIColor blueTintColor]];  //按钮
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithHex:0xE1E1E1]]; //bar
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueTintColor]} forState:UIControlStateSelected];
    
    /*
    [UISearchBar appearance].tintColor = [UIColor colorWithHex:0x15A230];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setCornerRadius:14.0];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setAlpha:0.6];
    
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor colorWithHex:0xDCDCDC];
    pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    
    [[UITextField appearance] setTintColor:[UIColor nameColor]];
    [[UITextView appearance]  setTintColor:[UIColor nameColor]];
    
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    [menuController setMenuVisible:YES animated:YES];
    [menuController setMenuItems:@[
                                   [[UIMenuItem alloc] initWithTitle:@"复制" action:NSSelectorFromString(@"copyText:")],
                                   [[UIMenuItem alloc] initWithTitle:@"删除" action:NSSelectorFromString(@"deleteObject:")]
                                   ]];
    
    */
    
    //短信
    [SMS_SDK registerApp:@"6744f573b3c1" withSecret:@"7bee88e4f7e0e982078aaef10264e6ed"];

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
    
    //检查网络连接
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
