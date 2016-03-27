//
//  ForgetPwdViewController.m
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "Tool.h"

#import <ReactiveCocoa.h>

@interface ForgetPwdViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate> {
    
    NSString* _defaultCode;
    NSString* _defaultCountryName;
    
    NSDictionary *_dict;
}

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"找回密码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:@"86", @"zone",
             @"^1(3|5|7|8|4)\\d{9}", @"rule",
             nil];
    
    [self initSubviews];
    [self setLayout];
    
    RACSignal *retrieveActiveSignal = [RACSignal combineLatest:@[_phoneNumTextField.rac_textSignal, _verCodeTextField.rac_textSignal]
                                                   reduce:^(NSString *phoneNum, NSString *verCode) {
                                                       return @(phoneNum.length > 0 && verCode.length > 0);
                                                   }];
    
    RAC(self.submitBtn, enabled) = retrieveActiveSignal;
    
    //登陆按钮的透明度
    RAC(_submitBtn, alpha) = [retrieveActiveSignal map:^(NSNumber *b) {
        return b.boolValue ? @1: @0.4;
    }];
    
    //设置本地区号
    [self setTheLocalAreaCode];
}

- (void)initSubviews {
    
    //手机号
    _phoneNumTextField = [UITextField new];
    _phoneNumTextField.placeholder = @"～手机号～";
    _phoneNumTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    _phoneNumTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    _phoneNumTextField.keyboardType = UIKeyboardTypePhonePad;
    _phoneNumTextField.delegate = self;
    _phoneNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_phoneNumTextField];
    
    //获取验证码
    _getVerCodeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _getVerCodeBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    _getVerCodeBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [_getVerCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getVerCodeBtn setCornerRadius:10];
    [_getVerCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_getVerCodeBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_getVerCodeBtn];
    
    //验证码
    _verCodeTextField = [UITextField new];
    _verCodeTextField.placeholder = @"～验证码～";
    _verCodeTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    _verCodeTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    _verCodeTextField.keyboardType = UIKeyboardTypePhonePad;
    _verCodeTextField.delegate = self;
    _verCodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    _verCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_verCodeTextField];
    
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
    if (![_phoneNumTextField isFirstResponder] && ![_verCodeTextField isFirstResponder]) {
        return NO;
    }
    return YES;
}

- (void)setLayout {
    
    for (UIView *view in [self.view subviews]) { view.translatesAutoresizingMaskIntoConstraints = NO;}
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_phoneNumTextField, _getVerCodeBtn,_verCodeTextField, _submitBtn);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_phoneNumTextField(140)]-10-[_getVerCodeBtn]-10-|"
                                                                      options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_getVerCodeBtn(40)]"     options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNumTextField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_getVerCodeBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_phoneNumTextField(40)]"
                                                                      options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_verCodeTextField]-10-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-125-[_verCodeTextField(40)]-10-[_submitBtn(40)]"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil views:views]];
                               
}

- (void)getVerCode {
    
//    NSString* str = [_defaultCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    if (self.phoneNumTextField.text.length != 11) {
        
        //手机号码不正确
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil)
                                                      message:NSLocalizedString(@"手机号码不对哦～", nil)
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                            otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSString* rule1=_dict[@"rule"];
    NSPredicate* pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",rule1];
    BOOL isMatch=[pred evaluateWithObject:self.phoneNumTextField.text];
    if (!isMatch)
    {
        //手机号码不正确
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil)
                                                      message:NSLocalizedString(@"手机号码无效哦～", nil)
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                            otherButtonTitles:nil, nil];
        [alert show];
        return;
    } else {
        
        [self.verCodeTextField becomeFirstResponder];
    }
    
}

- (void)submit {
    
    [self.view endEditing:YES];
    
    
    [Tool pushResetPwd:nil andNavController:self.navigationController];
}

-(void)setTheLocalAreaCode
{
    //    NSLocale *locale = [NSLocale currentLocale];
    
    _defaultCode=@"+86";
    _defaultCountryName=@"CN";
}

#pragma mark - 键盘操作

- (void)hidenKeyboard
{
    [_phoneNumTextField resignFirstResponder];
    [_verCodeTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
