//
//  AppDelegate.h
//  funnyplay
//
//  Created by cash on 15-3-16.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMS_SDK/SMS_SDK.h>

@class LocationBaseViewController;
@class NearbyBaseViewController;
@class PlayCardBaseViewController;
@class PersonInfoBaseViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UITabBarController *tabBarController;

@property (nonatomic, strong) LocationBaseViewController *locBase;
@property (nonatomic, strong) NearbyBaseViewController *nearBase;
@property (nonatomic, strong) PlayCardBaseViewController *playCardBase;
@property (nonatomic, strong) PersonInfoBaseViewController *personInfoBase;



@end

