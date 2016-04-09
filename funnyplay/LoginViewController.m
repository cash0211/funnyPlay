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
#import "FlatButton.h"
#import "PasswordStrengthIndicatorView.h"

#import <ReactiveCocoa.h>
#import <POP.h>

@interface LoginViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITextField                   *phoneNumTextField;
@property (nonatomic, strong) UITextField                   *passwordTextField;
@property (nonatomic, strong) PasswordStrengthIndicatorView *passwordStrengthIndicatorView;
@property (nonatomic, strong) FlatButton                    *loginBtn;
@property (nonatomic, strong) UILabel                       *errorLabel;
@property (nonatomic, strong) UIActivityIndicatorView       *activityIndicatorView;
@property (nonatomic, strong) UIButton                      *phoneNumRegBtn;
@property (nonatomic, strong) UIButton                      *forgetPasswordBtn;

@end

@implementation LoginViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _initSubviews];
    
    //NSUserDefaults获取保存的__用户名和密码__
    NSArray *usernameAndPassword = [Config getOwnAccountAndPassword];
    self.phoneNumTextField.text = usernameAndPassword? usernameAndPassword[0] : @"";
    self.passwordTextField.text = usernameAndPassword? usernameAndPassword[1] : @"";
    
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[self.phoneNumTextField.rac_textSignal, self.passwordTextField.rac_textSignal]
                                                      reduce:^(NSString *phoneNum, NSString *password) {
                                                          return @(phoneNum.length == 11 && password.length == 8);
                                                      }];
    
    RAC(self.loginBtn, enabled) = signUpActiveSignal;
    
    //登陆按钮的透明度
    RAC(self.loginBtn, alpha) = [signUpActiveSignal map:^(NSNumber *b) {
        return b.boolValue ? @1: @0.4;
    }];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self _setLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc {
    
}


#pragma mark - Event response

- (void)login:(id)sender {
    
    [self.view endEditing:YES];
    
    [self _hideLabel];
    [self.activityIndicatorView startAnimating];
    self.loginBtn.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.activityIndicatorView stopAnimating];
        //        if (self.phoneNumTextField.text.length == 11 && self.passwordTextField.text.length >= 8) {
        //
        //        } else { // 应该账号密码各种不对才显示
        [self _shakeButton];
        [self _showLabel];
        //        }
    });
}

- (void)registerUser:(id)sender {
    
    [Tool pushRegUser:nil andNavController:self.navigationController];
}

- (void)forgetPassword:(id)sender {
    
    [Tool pushforgetPwd:nil andNavController:self.navigationController];
}

- (void)textFieldDidChange:(UITextField *)sender {
    
    if (sender.text.length < 1) {
        self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusNone;
        return;
    }
    
    if (sender.text.length < 4) {
        self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusWeak;
        return;
    }
    
    if (sender.text.length < 8) {
        self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusFair;
        return;
    }
    
    self.passwordStrengthIndicatorView.status = PasswordStrengthIndicatorViewStatusStrong;
}

#pragma mark Keyboard

- (void)hidenKeyboard {
    
    [self.phoneNumTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

//键盘上Next && Done会调用
- (void)returnOnKeyboard:(UITextField *)sender {
    
    if (sender == self.passwordTextField) {
        
        [self hidenKeyboard];
        if (self.loginBtn.enabled) {
            [self login:nil];
        }
    }
}


#pragma mark - Private methods

- (void)_initSubviews {
    
    //手机号码
    UITextField *phoneNumTextField = [UITextField new];
    phoneNumTextField.placeholder = @"～手机号～";
    phoneNumTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    phoneNumTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    phoneNumTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:phoneNumTextField];
    self.phoneNumTextField = phoneNumTextField;
    
    //密码
    UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    UITextField *passwordTextField = [UITextField new];
    passwordTextField.leftView = leftPaddingView;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    passwordTextField.backgroundColor = [UIColor colorWithWhite:0 alpha:0.05];
    passwordTextField.placeholder = @"～密码～";
    passwordTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    passwordTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.enablesReturnKeyAutomatically = YES;
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:passwordTextField];
    [passwordTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [passwordTextField addTarget:self
                               action:@selector(textFieldDidChange:)
                     forControlEvents:UIControlEventEditingChanged];
    self.passwordTextField = passwordTextField;
    
    // 进度条
    PasswordStrengthIndicatorView *passwordStrengthIndicatorView = [PasswordStrengthIndicatorView new];
    [self.view addSubview:passwordStrengthIndicatorView];
    self.passwordStrengthIndicatorView = passwordStrengthIndicatorView;
    
    //登录按钮
    FlatButton *loginBtn = [FlatButton button];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    loginBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setCornerRadius:20];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    self.loginBtn = loginBtn;
    
    // 错误Label
    UILabel *errorLabel = [UILabel new];
    errorLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    errorLabel.textColor = [UIColor redColor];
    errorLabel.text = @"登陆失败";
    errorLabel.textAlignment = NSTextAlignmentCenter;
    [self.view insertSubview:errorLabel belowSubview:loginBtn];
    self.errorLabel = errorLabel;
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:activityIndicatorView];
    self.navigationItem.rightBarButtonItem = item;
    self.activityIndicatorView = activityIndicatorView;
    
    //手机注册
    UIButton *phoneNumRegBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [phoneNumRegBtn setTitle:@"手机注册" forState:UIControlStateNormal];
    [phoneNumRegBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [phoneNumRegBtn addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneNumRegBtn];
    self.phoneNumRegBtn = phoneNumRegBtn;
    
    //忘记密码
    UIButton *forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [forgetPasswordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetPasswordBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [forgetPasswordBtn addTarget:self action:@selector(forgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPasswordBtn];
    self.forgetPasswordBtn = forgetPasswordBtn;
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

- (void)_setLayout {
    
    for (UIView *view in [self.view subviews]) { view.translatesAutoresizingMaskIntoConstraints = NO;}
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_phoneNumTextField, _passwordTextField, _passwordStrengthIndicatorView, _loginBtn, _phoneNumRegBtn, _forgetPasswordBtn);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_phoneNumTextField]-30-|"     options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-125-[_phoneNumTextField(40)]-5-[_passwordTextField(40)]-[_passwordStrengthIndicatorView(10)]-20-[_loginBtn]"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_loginBtn(40)]-10-[_phoneNumRegBtn]"
                                                                      options:NSLayoutFormatAlignAllLeft
                                                                      metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_forgetPasswordBtn]-30-|"     options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.forgetPasswordBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.phoneNumRegBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.errorLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.loginBtn attribute:NSLayoutAttributeCenterX multiplier:1 constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.errorLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.loginBtn attribute:NSLayoutAttributeCenterY multiplier:1 constant:self.loginBtn.intrinsicContentSize.height]];
    
    self.errorLabel.layer.opacity = 0.0;
}

#pragma mark Animations

- (void)_shakeButton {
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnimation.velocity = @2000;
    positionAnimation.springBounciness = 20;
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.loginBtn.userInteractionEnabled = YES;
    }];
    [self.loginBtn.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
}

- (void)_showLabel {
    
    self.errorLabel.layer.opacity = 1.0;
    POPSpringAnimation *layerScaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.springBounciness = 18;
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.errorLabel.layer pop_addAnimation:layerScaleAnimation forKey:@"labelScaleAnimation"];
    
    POPSpringAnimation *layerPositionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue = @(self.loginBtn.layer.position.y + self.loginBtn.intrinsicContentSize.height);
    layerPositionAnimation.springBounciness = 12;
    [self.errorLabel.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
}

- (void)_hideLabel {
    
    POPBasicAnimation *layerScaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    [self.errorLabel.layer pop_addAnimation:layerScaleAnimation forKey:@"layerScaleAnimation"];
    
    POPBasicAnimation *layerPositionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue = @(self.loginBtn.layer.position.y);
    [self.errorLabel.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
}


#pragma mark - UIGestureRecognizerDelegate

//当 账号和密码输入框 都没有键盘的时候, 不接收GR点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (![self.phoneNumTextField isFirstResponder] && ![self.passwordTextField isFirstResponder]) {
        return NO;
    }
    return YES;
}

@end










