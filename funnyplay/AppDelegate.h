//
//  AppDelegate.h
//  funnyplay
//
//  Created by cash on 15-3-16.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMKMapManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@end













