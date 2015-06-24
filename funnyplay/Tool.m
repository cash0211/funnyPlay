//
//  Tool.m
//  funnyplay
//
//  Created by cash on 15-3-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "Tool.h"
#import "LocationDetail.h"
#import "NearbyDetail.h"
#import "AreaPlayViewController.h"
#import "LoginViewController.h"
#import "RegViewController.h"
#import "ForgetPwdViewController.h"
#import "ResetPwdViewController.h"

#import <MBProgressHUD.h>

@implementation Tool

+ (void)noticeLogin:(UIView *)view andDelegate:(id)delegate andTitle:(NSString *)title {
    
    UIActionSheet *loginSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"登录", nil];
    [loginSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

+ (void)pushLocationDetail:(Location *)loc andNavController:(UINavigationController *)navController {
    
    UITabBarController *tabBarCon = [[UITabBarController alloc] init];
    LocationDetail *locDetail = [[LocationDetail alloc] init];
    tabBarCon.viewControllers = [NSArray arrayWithObjects:locDetail, nil];
    tabBarCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:tabBarCon animated:YES];
}

+ (void)pushNearbyDetail:(Nearby *)nearby andNavController:(UINavigationController *)navController {
    
    UITabBarController *tabBarCon = [[UITabBarController alloc] init];
    NearbyDetail *nearbyDetail = [[NearbyDetail alloc] init];
    tabBarCon.viewControllers = [NSArray arrayWithObjects:nearbyDetail, nil];
    tabBarCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:tabBarCon animated:YES];
}

+ (void)pushAreaPlay:(id)sender andNavController:(UINavigationController *)navController {
    
//    UITabBarController *tabBarCon = [[UITabBarController alloc] init];
    AreaPlayViewController *areaPlayCon = [[AreaPlayViewController alloc] init];
    areaPlayCon.hidesBottomBarWhenPushed = YES;
//    tabBarCon.viewControllers = [NSArray arrayWithObjects:areaPlayCon, nil];
//    tabBarCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:areaPlayCon animated:YES];
    
}

+ (void)pushLogin:(id)sender andNavController:(UINavigationController *)navController {
    
    LoginViewController *loginCon = [[LoginViewController alloc] init];
    loginCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:loginCon animated:YES];
    
}

+ (void)pushRegUser:(id)sender andNavController:(UINavigationController *)navController {
    
    RegViewController *regCon = [[RegViewController alloc] init];
//    regCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:regCon animated:YES];
    
}

+(void)pushforgetPwd:(id)sender andNavController:(UINavigationController *)navController {
    
    ForgetPwdViewController *forgetCon = [[ForgetPwdViewController alloc] init];
    
    [navController pushViewController:forgetCon animated:YES];
}

+(void)pushResetPwd:(id)sender andNavController:(UINavigationController *)navController {
    
    ResetPwdViewController *resetCon = [[ResetPwdViewController alloc] init];
    
    [navController pushViewController:resetCon animated:YES];
}


//HUD
+ (MBProgressHUD *)createHUD:(NSString *)text 
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
    HUD.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    HUD.detailsLabelText = text;
    [window addSubview:HUD];
    [HUD show:YES];
    
    //[HUD addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:HUD action:@selector(hide:)]];
    
    return HUD;
}

@end








































































