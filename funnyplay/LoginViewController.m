//
//  LoginViewController.m
//  funnyplay
//
//  Created by cash on 15-4-14.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "LoginViewController.h"
#import "Tool.h"

@interface LoginViewController () {
    
 
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    
    CGFloat statusBarHeight = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight = 20;
    }
    
    //手机号码
    UITextField* phoneNumField = [[UITextField alloc] init];
    phoneNumField.frame = CGRectMake(10, 60+statusBarHeight, (self.view.frame.size.width - 20), 40+statusBarHeight/4);
    phoneNumField.borderStyle = UITextBorderStyleRoundedRect;
    phoneNumField.placeholder = [NSString stringWithFormat:@"手机号～"];
    phoneNumField.font = [UIFont fontWithName:@"Helvetica" size:15];
    phoneNumField.keyboardType = UIKeyboardTypePhonePad;
    phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    PhoneNumField.clearsOnBeginEditing = YES;
    [self.view addSubview:phoneNumField];
    
    //密码
    UITextField* passwordField = [[UITextField alloc] init];
    passwordField.frame = CGRectMake(phoneNumField.frame.origin.x, phoneNumField.frame.origin.y + phoneNumField.frame.size.height + 5, phoneNumField.frame.size.width, phoneNumField.frame.size.height);
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.placeholder = [NSString stringWithFormat:@"密码～"];
    passwordField.font = [UIFont fontWithName:@"Helvetica" size:15];
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.secureTextEntry = YES;
    //    PhoneNumField.clearsOnBeginEditing = YES;
    [self.view addSubview:passwordField];
    
    //登录按钮
    UIButton* loginBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [loginBtn setTitle:NSLocalizedString(@"登录", nil) forState:UIControlStateNormal];
    NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/loginbtn.png"];
    [loginBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    loginBtn.frame=CGRectMake(phoneNumField.frame.origin.x, passwordField.frame.origin.y + passwordField.frame.size.height + 10, phoneNumField.frame.size.width, phoneNumField.frame.size.height - 5);
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //忘记密码
    UIButton* forgetPwdBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [forgetPwdBtn setTitle:NSLocalizedString(@"忘记密码？", nil) forState:UIControlStateNormal];
//    NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/loginbtn.png"];
//    [LoginBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    forgetPwdBtn.frame=CGRectMake(self.view.frame.size.width - 110, 200, 100, 100);
    [forgetPwdBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [forgetPwdBtn addTarget:self action:@selector(forgetPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPwdBtn];

    //手机注册
    UIButton* regBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [regBtn setTitle:NSLocalizedString(@"手机注册", nil) forState:UIControlStateNormal];
    regBtn.frame=CGRectMake(0, 200, 100, 100);
    [regBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [regBtn addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
    
    _phoneNumTextField = phoneNumField;
    _pwdTextField = passwordField;
    _loginBtn = loginBtn;
    _forgetPwdBtn = forgetPwdBtn;
    _phoneNumRegBtn = regBtn;
    
    
    
}

- (IBAction)registerUser:(id)sender {
    
    [Tool pushRegUser:nil andNavController:self.navigationController];
}

- (void)login:(id)sender {
    
    [self.view endEditing:YES];
}

- (void)forgetPwd:(id)sender {
    
    [Tool pushforgetPwd:nil andNavController:self.navigationController];
}

- (IBAction)backgrondTouch:(id)sender
{
    [self.phoneNumTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
