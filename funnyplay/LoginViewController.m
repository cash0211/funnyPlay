//
//  LoginViewController.m
//  funnyplay
//
//  Created by cash on 15-4-14.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "LoginViewController.h"
#import "Tool.h"
#import "Config.h"

#import <ReactiveCocoa.h>

@interface LoginViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate> {
    
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubviews];
    [self setLayout];
    
    //NSUserDefaults获取保存的__用户名和密码__
    NSArray *usernameAndPassword = [Config getOwnAccountAndPassword];
    _phoneNumTextField.text = usernameAndPassword? usernameAndPassword[0] : @"";
    _pwdTextField.text = usernameAndPassword? usernameAndPassword[1] : @"";
    
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[_phoneNumTextField.rac_textSignal, _pwdTextField.rac_textSignal]
                                         reduce:^(NSString *phoneNum, NSString *password) {
                                             return @(phoneNum.length > 0 && password.length > 0);
                                         }];
    
    RAC(self.loginBtn, enabled) = signUpActiveSignal;
    
    //登陆按钮的透明度
    RAC(_loginBtn, alpha) = [signUpActiveSignal map:^(NSNumber *b) {
        return b.boolValue ? @1: @0.4;
    }];
}

- (void)initSubviews {
    
    //手机号码
    _phoneNumTextField = [UITextField new];
    _phoneNumTextField.placeholder = @"～手机号～";
    _phoneNumTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    _phoneNumTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    _phoneNumTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumTextField.delegate = self;
    _phoneNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_phoneNumTextField];
    
    //密码
    _pwdTextField = [UITextField new];
    _pwdTextField.placeholder = @"～密码～";
    _pwdTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    _pwdTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    _pwdTextField.secureTextEntry = YES;
    _pwdTextField.delegate = self;
    _pwdTextField.returnKeyType = UIReturnKeyDone;
    _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextField.enablesReturnKeyAutomatically = YES;
    _pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_pwdTextField];
    
    
    [_pwdTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //登录按钮
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    _loginBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setCornerRadius:20];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    //手机注册
    _phoneNumRegBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_phoneNumRegBtn setTitle:@"手机注册" forState:UIControlStateNormal];
    [_phoneNumRegBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_phoneNumRegBtn addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_phoneNumRegBtn];
    
    //忘记密码
    _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetPwdBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_forgetPwdBtn addTarget:self action:@selector(forgetPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_forgetPwdBtn];
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

//当 账号和密码输入框 都没有键盘的时候, 不接收GR点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (![_phoneNumTextField isFirstResponder] && ![_pwdTextField isFirstResponder]) {
        return NO;
    }
    return YES;
}

- (void)setLayout {
    
    for (UIView *view in [self.view subviews]) { view.translatesAutoresizingMaskIntoConstraints = NO;}
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_phoneNumTextField, _pwdTextField, _loginBtn, _phoneNumRegBtn, _forgetPwdBtn);

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_phoneNumTextField]-30-|"     options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-125-[_phoneNumTextField(40)]-5-[_pwdTextField(40)]"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil views:views]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_loginBtn(40)]-10-[_phoneNumRegBtn]"
                                                                      options:NSLayoutFormatAlignAllLeft
                                                                      metrics:nil views:views]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_forgetPwdBtn]-30-|"     options:0 metrics:nil views:views]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_loginBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_phoneNumTextField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_forgetPwdBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_phoneNumRegBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_loginBtn
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_loginBtn
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1 constant:0]];

}


#pragma mark - 键盘操作

- (void)hidenKeyboard
{
    [_phoneNumTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
}

//键盘上Next && Done会调用
- (void)returnOnKeyboard:(UITextField *)sender
{
    
    if (sender == _pwdTextField) {

        [self hidenKeyboard];
        if (_loginBtn.enabled) {
            [self login:nil];
        }
    }
}


- (IBAction)registerUser:(id)sender {
    
    [Tool pushRegUser:nil andNavController:self.navigationController];
}

- (void)login:(id)sender {
    
    [self.view endEditing:YES];
    
    NSLog(@"login");
}

- (void)forgetPwd:(id)sender {
    
    [Tool pushforgetPwd:nil andNavController:self.navigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
