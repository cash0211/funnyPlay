//
//  LocationBaseViewController.h
//  funnyplay
//
//  Created by cash on 15-3-16.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LocationViewController;

@interface LocationBaseViewController : UIViewController


@property (nonatomic, strong) LocationViewController *locationViewCon;
@property (nonatomic, retain) NSMutableArray *locationItems;

@end
