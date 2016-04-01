//
//  RegisterViewController.m
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "RegisterViewController.h"
#import "Tool.h"
#import "UIView+ActivityIndicator.h"

#import <ReactiveCocoa.h>

@interface RegisterViewController () <UIGestureRecognizerDelegate> {
    
    NSString     *_defaultCode;
    NSString     *_defaultCountryName;
    
    NSDictionary *_dict;
}

@property (nonatomic, strong) UITextField *phoneNumTextField;
@property (nonatomic, strong) UIButton    *getVerCodeBtn;
@property (nonatomic, strong) UITextField *verCodeTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton    *registerBtn;

@end

@implementation RegisterViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:@"86", @"zone",
             @"^1(3|5|7|8|4)\\d{9}", @"rule",
             nil];
    
    [self _initSubviews];
    
    RACSignal *regActiveSignal = [RACSignal combineLatest:@[self.phoneNumTextField.rac_textSignal, self.verCodeTextField.rac_textSignal,self.passwordTextField.rac_textSignal]
                                                   reduce:^(NSString *phoneNum, NSString *verCode, NSString *password) {
                                                       return @(phoneNum.length == 11 && verCode.length >= 4 &&password.length >= 8);
                                                   }];
    
    RAC(self.registerBtn, enabled) = regActiveSignal;
    
    //登陆按钮的透明度
    RAC(self.registerBtn, alpha) = [regActiveSignal map:^(NSNumber *b) {
        return b.boolValue ? @1: @0.4;
    }];
    
    //设置本地区号
    [self _setTheLocalAreaCode];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self _setLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Event response

- (void)getVerCode {
    
    //    NSString* str = [_defaultCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    if (self.phoneNumTextField.text.length != 11) {
        
        [self.view showHUDTextViewAtCenterWithTitle:@"手机号码不对哦~~"];
        return;
    }
    
    NSString *rule1=_dict[@"rule"];
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule1];
    BOOL isMatch=[pred evaluateWithObject:self.phoneNumTextField.text];
    if (!isMatch) {
        
        [self.view showHUDTextViewAtCenterWithTitle:@"手机号码无效哦~~"];
        return;
    } else {
        
        [self.verCodeTextField becomeFirstResponder];
    }
}

- (void)registerUser {
    
    [self.view endEditing:YES];
    
    if (self.phoneNumTextField.text.length == 0 && self.verCodeTextField.text.length == 0 && self.passwordTextField.text.length == 0) {
        
        return;
    }
    
    
    
    //验证密码
    if (self.passwordTextField.text.length < 8 || self.passwordTextField.text.length > 12) {
        return;
    }
}

#pragma mark Keyboard

- (void)hidenKeyboard {
    
    [self.phoneNumTextField resignFirstResponder];
    [self.verCodeTextField  resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

//键盘上Next && Done会调用
- (void)returnOnKeyboard:(UITextField *)sender {
    
    if (sender == self.passwordTextField) {
        
        [self hidenKeyboard];
        if (self.registerBtn.enabled) {
            [self registerUser];
        }
    }
}


#pragma mark - Private methods

- (void)_initSubviews {
    
    //手机号
    self.phoneNumTextField = [UITextField new];
    self.phoneNumTextField.placeholder = @"～手机号～";
    self.phoneNumTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    self.phoneNumTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    self.phoneNumTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.phoneNumTextField];
    
    //获取验证码
    self.getVerCodeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    self.getVerCodeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.getVerCodeBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [self.getVerCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getVerCodeBtn setCornerRadius:10];
    [self.getVerCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getVerCodeBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getVerCodeBtn];
    
    //验证码
    self.verCodeTextField = [UITextField new];
    self.verCodeTextField.placeholder = @"～验证码～";
    self.verCodeTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    self.verCodeTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    self.verCodeTextField.keyboardType = UIKeyboardTypePhonePad;
    self.verCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.verCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.verCodeTextField];
    
    //密码
    self.passwordTextField = [UITextField new];
    self.passwordTextField.placeholder = @"～登录密码～";
    self.passwordTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    self.passwordTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.enablesReturnKeyAutomatically = YES;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordTextField];
    
    //注册按钮
    self.registerBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.registerBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn setCornerRadius:20];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    
    [self.passwordTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

- (void)_setLayout {
    
    for (UIView *view in [self.view subviews]) { view.translatesAutoresizingMaskIntoConstraints = NO;}
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_phoneNumTextField, _getVerCodeBtn, _verCodeTextField, _passwordTextField, _registerBtn);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_phoneNumTextField(140)]-10-[_getVerCodeBtn]-10-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_getVerCodeBtn(40)]"     options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.phoneNumTextField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.getVerCodeBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_phoneNumTextField(40)]"
                                                                      options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_verCodeTextField]-10-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-125-[_verCodeTextField(40)]-5-[_passwordTextField(40)]-10-[_registerBtn(40)]"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil views:views]];
}

- (void)_setTheLocalAreaCode {
    //    NSLocale *locale = [NSLocale currentLocale];
    
    _defaultCode = @"+86";
    _defaultCountryName = @"CN";
}



#pragma mark - UIGestureRecognizerDelegate

//当 账号和密码输入框 都没有键盘的时候, 不接收GR点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (![self.phoneNumTextField isFirstResponder] && ![self.passwordTextField isFirstResponder] && ![self.verCodeTextField isFirstResponder]) {
        return NO;
    }
    return YES;
}

@end





