//
//  ResetPwdViewController.m
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "ResetPwdViewController.h"

@interface ResetPwdViewController ()

@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"重置密码";
    
    CGFloat statusBarHeight = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight = 20;
    }
    
    //密码_1
    UITextField* passwordField = [[UITextField alloc] init];
    passwordField.frame = CGRectMake(10, 60+statusBarHeight, (self.view.frame.size.width - 20), 40+statusBarHeight/4);
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.placeholder = [NSString stringWithFormat:@"～密码～"];
    passwordField.font = [UIFont fontWithName:@"Helvetica" size:15];
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    
    //密码_2
    UITextField* passwordField2 = [[UITextField alloc] init];
    passwordField2.frame = CGRectMake(passwordField.frame.origin.x, passwordField.frame.origin.y + passwordField.frame.size.height + 5, passwordField.frame.size.width, passwordField.frame.size.height);
    passwordField2.borderStyle = UITextBorderStyleRoundedRect;
    passwordField2.placeholder = [NSString stringWithFormat:@"～再次输入～"];
    passwordField2.font = [UIFont fontWithName:@"Helvetica" size:15];
    passwordField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField2.secureTextEntry = YES;
    [self.view addSubview:passwordField2];
    
    //提交按钮
    UIButton* submitBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [submitBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
    NSString *icon2 = [NSString stringWithFormat:@"smssdk.bundle/loginbtn.png"];
    [submitBtn setBackgroundImage:[UIImage imageNamed:icon2] forState:UIControlStateNormal];
    submitBtn.frame=CGRectMake(passwordField.frame.origin.x, passwordField2.frame.origin.y + passwordField2.frame.size.height + 10, passwordField.frame.size.width, passwordField.frame.size.height - 5);
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    _pwdTextField1 = passwordField;
    _pwdTextField2 = passwordField2;
    _submitBtn = submitBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submit {
    
    [self.view endEditing:YES];
}

- (IBAction)backgrondTouch:(id)sender
{
    [self.pwdTextField1 resignFirstResponder];
    [self.pwdTextField2 resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
