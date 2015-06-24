//
//  Tool.h
//  funnyplay
//
//  Created by cash on 15-3-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Location;
@class Nearby;

@class MBProgressHUD;

@interface Tool : NSObject


+ (void)noticeLogin:(UIView *)view andDelegate:(id)delegate andTitle:(NSString *)title;

+ (void)pushLocationDetail:(Location *)loc andNavController:(UINavigationController *)navController;
+ (void)pushNearbyDetail:(Nearby *)nearby andNavController:(UINavigationController *)navController;
+ (void)pushAreaPlay:(id)sender andNavController:(UINavigationController *)navController;
+ (void)pushLogin:(id)sender andNavController:(UINavigationController *)navController;
+ (void)pushRegUser:(id)sender andNavController:(UINavigationController *)navController;
+ (void)pushforgetPwd:(id)sender andNavController:(UINavigationController *)navController;
+ (void)pushResetPwd:(id)sender andNavController:(UINavigationController *)navController;


+ (MBProgressHUD *)createHUD:(NSString *)text;

@end
