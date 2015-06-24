//
//  AppDelegate.h
//  funnyplay
//
//  Created by cash on 15-3-16.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMS_SDK/SMS_SDK.h>
#import <BaiduMapAPI/BMKMapManager.h>
#import <AFNetworkActivityIndicatorManager.h>

@class LocationBaseViewController;
@class RecommendBaseViewController;
@class NearbyBaseViewController;
@class PlayCardBaseViewController;
@class PersonInfoBaseViewController;
@class FlowgroundBaseViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> {
    
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UITabBarController *tabBarController;

@property (nonatomic, strong) LocationBaseViewController *locBase;
@property (nonatomic, strong) RecommendBaseViewController *recoBase;
//@property (nonatomic, strong) NearbyBaseViewController *nearBase;
@property (nonatomic, strong) PlayCardBaseViewController *playCardBase;
@property (nonatomic, strong) PersonInfoBaseViewController *personInfoBase;
@property (nonatomic, strong) FlowgroundBaseViewController *flowgroundBase;

@end













