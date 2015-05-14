//
//  ResetPwdViewController.h
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPwdViewController : UIViewController

@property (nonatomic, strong) UITextField *pwdTextField1;
@property (nonatomic, strong) UITextField *pwdTextField2;
@property (nonatomic, strong) UIButton *submitBtn;

- (IBAction)backgrondTouch:(id)sender;

@end
