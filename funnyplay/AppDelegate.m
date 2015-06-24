//
//  AppDelegate.m
//  funnyplay
//
//  Created by cash on 15-3-16.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "AppDelegate.h"
#import "LocationBaseViewController.h"
#import "RecommendBaseViewController.h"
#import "NearbyBaseViewController.h"
#import "PlayCardBaseViewController.h"
#import "PersonInfoBaseViewController.h"
#import "FlowgroundBaseViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //添加百度地图
    _mapManager = [[BMKMapManager alloc] init];
    
    BOOL ret = [_mapManager start:@"jk4KaC75i3hBre6ila3K7YaM" generalDelegate:nil]; //如果要关注网络及授权验证事件，设定gDelegate
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //设置 状态栏_网络指示器
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    //本地
    self.locBase = [[LocationBaseViewController alloc] initWithNibName:@"LocationBase" bundle:nil];
    UINavigationController *locNav = [[UINavigationController alloc] initWithRootViewController:self.locBase];
    
    //附近
//    self.nearBase = [[NearbyBaseViewController alloc] initWithNibName:@"NearbyBase" bundle:nil];
//    UINavigationController *nearbyNav = [[UINavigationController alloc] initWithRootViewController:self.nearBase];
    //推荐
    self.recoBase = [[RecommendBaseViewController alloc] initWithNibName:@"RecommendBase" bundle:nil];
    UINavigationController *recoNav = [[UINavigationController alloc] initWithRootViewController:self.recoBase];
    
    //流动墙
    self.flowgroundBase = [[FlowgroundBaseViewController alloc] initWithNibName:@"FlowgroundBase" bundle:nil];
    UINavigationController *flowgroundNav = [[UINavigationController alloc] initWithRootViewController:self.flowgroundBase];
    
    //玩略
    self.playCardBase = [[PlayCardBaseViewController alloc] initWithNibName:@"PlayCardBase" bundle:nil];
    UINavigationController *playCardNav = [[UINavigationController alloc] initWithRootViewController:self.playCardBase];
    
    //个人信息
    self.personInfoBase = [[PersonInfoBaseViewController alloc] initWithNibName:@"PersonInfoBase" bundle:nil];
    UINavigationController *personInfoNav = [[UINavigationController alloc] initWithRootViewController:self.personInfoBase];
    
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:locNav, recoNav, flowgroundNav, playCardNav, personInfoNav,nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.tabBarController;
    
    [self.window makeKeyAndVisible];
    
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
