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
    self.passwordTextField = [UITextField new];
    self.passwordTextField.placeholder = @"～密码～";
    self.passwordTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    self.passwordTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    self.passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.returnKeyType = UIReturnKeyNext;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.enablesReturnKeyAutomatically = YES;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordTextField];
    
    //密码_2
    self.passwordConfirmTextField = [UITextField new];
    self.passwordConfirmTextField.placeholder = @"～再次输入～";
    self.passwordConfirmTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    self.passwordConfirmTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    self.passwordConfirmTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordConfirmTextField.secureTextEntry = YES;
    self.passwordConfirmTextField.returnKeyType = UIReturnKeyDone;
    self.passwordConfirmTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordConfirmTextField.enablesReturnKeyAutomatically = YES;
    self.passwordConfirmTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordConfirmTextField];
    
    [self.passwordTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.passwordConfirmTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //注册按钮
    self.submitBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.submitBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [self.submitBtn setTitle:@"重置" forState:UIControlStateNormal];
    [self.submitBtn setCornerRadius:20];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
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







