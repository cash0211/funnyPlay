//
//  UIView+ActivityIndicator.m
//  funnyplay
//
//  Created by cash on 16/3/28.
//  Copyright © 2016年 ___CASH___. All rights reserved.
//

#import "UIView+ActivityIndicator.h"
#import <MBProgressHUD.h>

@implementation UIView (ActivityIndicator)

#pragma mark - MBProgressHUDIndicatorView

- (void)showHUDIndicatorViewAtCenterWithTitle:(NSString *)indicatorTitle {
    
    [self showHUDIndicatorViewAtCenterWithTitle:indicatorTitle yOffset:0];
}

- (void)showHUDIndicatorViewAtCenterWithTitle:(NSString *)indicatorTitle yOffset:(CGFloat)y {
    
    MBProgressHUD *hud = [self getHUDViewAtCenter];
    
    if (!hud) {
        hud = [self createHUDIndicatorViewAtCenterWithTitle:indicatorTitle yOffset:y];
        [hud show:YES];
    } else {
        hud.labelText = indicatorTitle;
    }
}

- (MBProgressHUD *)createHUDIndicatorViewAtCenterWithTitle:(NSString *)indicatorTitle yOffset:(CGFloat)y {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.layer.zPosition = 10;
    hud.yOffset = y;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = indicatorTitle;
    [self addSubview:hud];
    hud.tag = kHUDViewTag;

    return hud;
}

- (void)hideHUDViewAtCenter {
    
    MBProgressHUD *hud = [self getHUDViewAtCenter];
    [hud hide:YES];
}

- (void)hideDelayHUDViewAtCenter {
    
    MBProgressHUD *hud = [self getHUDViewAtCenter];
    [hud hide:YES afterDelay:1.5];
}

#pragma mark - MBProgressHUDTextView

- (void)showHUDTextViewAtCenterWithTitle:(NSString *)textTitle {
    
    [self showHUDTextViewAtCenterWithTitle:textTitle yOffSet:0];
}

- (void)showHUDTextViewAtCenterWithTitle:(NSString *)textTitle yOffSet:(CGFloat)y {
    
    MBProgressHUD *hud = [self getHUDViewAtCenter];
    
    if (!hud) {
        hud = [self createHUDTextViewAtCenterWithTitle:textTitle yOffset:y];
    } else {
        hud.labelText = textTitle;
    }
    
    [self hideDelayHUDViewAtCenter];
}

- (MBProgressHUD *)createHUDTextViewAtCenterWithTitle:(NSString *)textTitle yOffset:(CGFloat)y {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = textTitle;
    hud.tag = kHUDViewTag;
    hud.yOffset = y;
    
    return hud;
}

#pragma mark - private

- (MBProgressHUD *)getHUDViewAtCenter {
    
    UIView *view = [self viewWithTagFromSubViews:kHUDViewTag];
    
    if (view && [view isKindOfClass:[MBProgressHUD class]]) {
        return (MBProgressHUD *)view;
    }
    
    return nil;
}

- (UIView *)viewWithTagFromSubViews:(NSInteger)tag {
    
    for (UIView *view in self.subviews) {
        if (view.tag == tag) {
            return view;
        }
    }
    return nil;
}

@end











