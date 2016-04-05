//
//  ResetPasswordViewController.m
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "Tool.h"

#import <ReactiveCocoa.h>

@interface ResetPasswordViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *passwordConfirmTextField;
@property (nonatomic, strong) UIButton    *submitBtn;

@end

@implementation ResetPasswordViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"重置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _initSubviews];
    
    RACSignal *retrieveActiveSignal = [RACSignal combineLatest:@[self.passwordTextField.rac_textSignal, self.passwordConfirmTextField.rac_textSignal]
                                                        reduce:^(NSString *passwordTextField, NSString *passwordConfirmTextField) {
                                                            return @(passwordTextField.length >= 8 && passwordConfirmTextField.length >= 8);
                                                        }];
    
    RAC(self.submitBtn, enabled) = retrieveActiveSignal;
    
    //登陆按钮的透明度
    RAC(self.submitBtn, alpha) = [retrieveActiveSignal map:^(NSNumber *b) {
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


#pragma mark - Event response

- (void)submit {
    
    [self.view endEditing:YES];
    
}

#pragma mark Keyboard

- (void)hidenKeyboard {
    
    [self.passwordTextField        resignFirstResponder];
    [self.passwordConfirmTextField resignFirstResponder];
}

//键盘上Next && Done会调用
- (void)returnOnKeyboard:(UITextField *)sender {
    
    if (sender == self.passwordTextField) {
        //账户编辑完了, 密码框成FirstResponder
        [self.passwordConfirmTextField becomeFirstResponder];
    } else if (sender == self.passwordConfirmTextField) {
        //同样
        [self hidenKeyboard];
        if (self.submitBtn.enabled) {
            [self submit];
        }
    }
}


#pragma mark - Private methods

- (void)_initSubviews {
    
    //密码
    UITextField *passwordTextField = [UITextField new];
    passwordTextField.placeholder = @"～密码～";
    passwordTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    passwordTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.returnKeyType = UIReturnKeyNext;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.enablesReturnKeyAutomatically = YES;
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [passwordTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    //密码_2
    UITextField *passwordConfirmTextField = [UITextField new];
    passwordConfirmTextField.placeholder = @"～再次输入～";
    passwordConfirmTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    passwordConfirmTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    passwordConfirmTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordConfirmTextField.secureTextEntry = YES;
    passwordConfirmTextField.returnKeyType = UIReturnKeyDone;
    passwordConfirmTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordConfirmTextField.enablesReturnKeyAutomatically = YES;
    passwordConfirmTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:passwordConfirmTextField];
    [passwordConfirmTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    self.passwordTextField = passwordConfirmTextField;
    
    //注册按钮
    UIButton *submitBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    submitBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [submitBtn setTitle:@"重置" forState:UIControlStateNormal];
    [submitBtn setCornerRadius:20];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    self.submitBtn = submitBtn;
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

- (void)_setLayout {
    
    for (UIView *view in [self.view subviews]) { view.translatesAutoresizingMaskIntoConstraints = NO;}
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_passwordTextField, _passwordConfirmTextField, _submitBtn);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_passwordTextField]-10-|"
                                                                      options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_passwordTextField(40)]-5-[_passwordConfirmTextField(40)]-10-[_submitBtn(40)]"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil views:views]];
}


#pragma mark - UIGestureRecognizerDelegate

//当 账号和密码输入框 都没有键盘的时候, 不接收GR点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (![self.passwordTextField isFirstResponder] && ![self.passwordConfirmTextField isFirstResponder]) {
        return NO;
    }
    return YES;
}

@end







