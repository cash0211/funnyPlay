//
//  UIView+ActivityIndicator.h
//  funnyplay
//
//  Created by cash on 16/3/28.
//  Copyright © 2016年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHUDViewTag                     0x98751235


@class MBProgressHUD;

@interface UIView (ActivityIndicator)

- (void)showHUDIndicatorViewAtCenterWithTitle:(NSString *)indicatorTitle;
- (void)showHUDIndicatorViewAtCenterWithTitle:(NSString *)indicatorTitle yOffset:(CGFloat)y;

- (void)hideDelayHUDViewAtCenter;
- (void)hideHUDViewAtCenter;

- (void)showHUDTextViewAtCenterWithTitle:(NSString *)textTitle;
- (void)showHUDTextViewAtCenterWithTitle:(NSString *)textTitle yOffSet:(CGFloat)y;


- (MBProgressHUD *)createHUDIndicatorViewAtCenterWithTitle:(NSString *)indicatorTitle yOffset:(CGFloat)y;
- (MBProgressHUD *)getHUDViewAtCenter;

- (UIView *)viewWithTagFromSubViews:(NSInteger)tag;



@end
