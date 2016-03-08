//
//  ResetPwdViewController.m
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "Tool.h"

#import <ReactiveCocoa.h>

@interface ResetPwdViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"重置密码";
    
    [self initSubviews];
    [self setLayout];
    
    RACSignal *retrieveActiveSignal = [RACSignal combineLatest:@[_pwdTextField1.rac_textSignal, _pwdTextField2.rac_textSignal]
                                                   reduce:^(NSString *pwd1, NSString *pwd2) {
                                                       return @(pwd1.length > 0 && pwd2.length > 0);
                                                   }];
    
    RAC(self.submitBtn, enabled) = retrieveActiveSignal;
    
    //登陆按钮的透明度
    RAC(_submitBtn, alpha) = [retrieveActiveSignal map:^(NSNumber *b) {
        return b.boolValue ? @1: @0.4;
    }];
}

- (void)initSubviews {
    
    //密码_1
    _pwdTextField1 = [UITextField new];
    _pwdTextField1.placeholder = @"～密码～";
    _pwdTextField1.font = [UIFont fontWithName:@"Helvetica" size:15];
    _pwdTextField1.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    _pwdTextField1.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _pwdTextField1.secureTextEntry = YES;
    _pwdTextField1.delegate = self;
    _pwdTextField1.returnKeyType = UIReturnKeyNext;
    _pwdTextField1.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextField1.enablesReturnKeyAutomatically = YES;
    _pwdTextField1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_pwdTextField1];
    
    //密码_2
    _pwdTextField2 = [UITextField new];
    _pwdTextField2.placeholder = @"～再次输入～";
    _pwdTextField2.font = [UIFont fontWithName:@"Helvetica" size:15];
    _pwdTextField2.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    _pwdTextField2.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _pwdTextField2.secureTextEntry = YES;
    _pwdTextField2.delegate = self;
    _pwdTextField2.returnKeyType = UIReturnKeyDone;
    _pwdTextField2.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextField2.enablesReturnKeyAutomatically = YES;
    _pwdTextField2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_pwdTextField2];
    
    
    [_pwdTextField1 addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_pwdTextField2 addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //注册按钮
    _submitBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    _submitBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [_submitBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_submitBtn setCornerRadius:20];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

//当 账号和密码输入框 都没有键盘的时候, 不接收GR点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (![_pwdTextField1 isFirstResponder] && ![_pwdTextField2 isFirstResponder]) {
        return NO;
    }
    return YES;
}

- (void)setLayout {
    
    for (UIView *view in [self.view subviews]) { view.translatesAutoresizingMaskIntoConstraints = NO;}
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_pwdTextField1, _pwdTextField2, _submitBtn);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_pwdTextField1]-10-|"
                                                                      options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_pwdTextField1(40)]-5-[_pwdTextField2(40)]-10-[_submitBtn(40)]"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil views:views]];
    
}

#pragma mark - 键盘操作

- (void)hidenKeyboard
{
    [_pwdTextField1 resignFirstResponder];
    [_pwdTextField2 resignFirstResponder];
}

//键盘上Next && Done会调用
- (void)returnOnKeyboard:(UITextField *)sender
{
    if (sender == _pwdTextField1) {
        //账户编辑完了, 密码框成FirstResponder
        [_pwdTextField2 becomeFirstResponder];
    } else if (sender == _pwdTextField2) {
        //同样
        [self hidenKeyboard];
        if (_submitBtn.enabled) {
            [self submit];
        }
    }
}

- (void)submit {
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
