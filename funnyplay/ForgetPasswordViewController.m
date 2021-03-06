//
//  ForgetPasswordViewController.m
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "Tool.h"
#import "UIView+ActivityIndicator.h"

#import <ReactiveCocoa.h>

@interface ForgetPasswordViewController () <UIGestureRecognizerDelegate> {
    
    NSString     *_defaultCode;
    NSString     *_defaultCountryName;
    
    NSDictionary *_dict;
}

@property (nonatomic, strong) UITextField *phoneNumTextField;
@property (nonatomic, strong) UIButton    *getVerCodeBtn;
@property (nonatomic, strong) UITextField *verCodeTextField;
@property (nonatomic, strong) UIButton    *submitBtn;

@end

@implementation ForgetPasswordViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"重置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:@"86", @"zone",
             @"^1(3|5|7|8|4)\\d{9}", @"rule",
             nil];
    
    [self _initSubviews];
    
    RACSignal *retrieveActiveSignal = [RACSignal combineLatest:@[self.phoneNumTextField.rac_textSignal, self.verCodeTextField.rac_textSignal]
                                                        reduce:^(NSString *phoneNum, NSString *verCode) {
                                                            return @(phoneNum.length == 11 && verCode.length >= 4);
                                                        }];
    
    RAC(self.submitBtn, enabled) = retrieveActiveSignal;
    
    //登陆按钮的透明度
    RAC(self.submitBtn, alpha) = [retrieveActiveSignal map:^(NSNumber *b) {
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

- (void)submit {
    
    [self.view endEditing:YES];
    
    [Tool pushResetPwd:nil andNavController:self.navigationController];
}

#pragma mark Keyboard

- (void)hidenKeyboard {
    
    [self.phoneNumTextField resignFirstResponder];
    [self.verCodeTextField  resignFirstResponder];
}


#pragma mark - Private methods

- (void)_setTheLocalAreaCode {
    
    //    NSLocale *locale = [NSLocale currentLocale];
    
    _defaultCode = @"+86";
    _defaultCountryName = @"CN";
}

- (void)_initSubviews {
    
    //手机号
    UITextField *phoneNumTextField = [UITextField new];
    phoneNumTextField.placeholder = @"～手机号～";
    phoneNumTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    phoneNumTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    phoneNumTextField.keyboardType = UIKeyboardTypePhonePad;
    phoneNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:phoneNumTextField];
    self.phoneNumTextField = phoneNumTextField;
    
    //获取验证码
    UIButton *getVerCodeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    getVerCodeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    getVerCodeBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [getVerCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerCodeBtn setCornerRadius:10];
    [getVerCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getVerCodeBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getVerCodeBtn];
    self.getVerCodeBtn = getVerCodeBtn;
    
    //验证码
    UITextField *verCodeTextField = [UITextField new];
    verCodeTextField.placeholder = @"～验证码～";
    verCodeTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    verCodeTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    verCodeTextField.keyboardType = UIKeyboardTypePhonePad;
    verCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    verCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:verCodeTextField];
    self.verCodeTextField = verCodeTextField;
    
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
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_phoneNumTextField, _getVerCodeBtn, _verCodeTextField, _submitBtn);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_phoneNumTextField(140)]-10-[_getVerCodeBtn]-10-|"
                                                                      options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_getVerCodeBtn(40)]"     options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.phoneNumTextField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.getVerCodeBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_phoneNumTextField(40)]"
                                                                      options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_verCodeTextField]-10-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-125-[_verCodeTextField(40)]-10-[_submitBtn(40)]"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil views:views]];
    
}


#pragma mark - UIGestureRecognizerDelegate

//当 账号和密码输入框 都没有键盘的时候, 不接收GR点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (![self.phoneNumTextField isFirstResponder] && ![self.verCodeTextField isFirstResponder]) {
        return NO;
    }
    return YES;
}

@end






