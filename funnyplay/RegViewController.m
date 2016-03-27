//
//  RegViewController.m
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "RegViewController.h"
#import "Tool.h"

#import <SMS_SDK/SMS_SDK.h>
#import <ReactiveCocoa.h>

@interface RegViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate> {
    
    NSString* _defaultCode;
    NSString* _defaultCountryName;
    
    NSDictionary *_dict;
}

@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:@"86", @"zone",
                                                      @"^1(3|5|7|8|4)\\d{9}", @"rule",
                                                      nil];
    [self initSubviews];
    [self setLayout];
    
    RACSignal *regActiveSignal = [RACSignal combineLatest:@[_phoneNumTextField.rac_textSignal, _verCodeTextField.rac_textSignal,_pwdTextField.rac_textSignal]
        reduce:^(NSString *phoneNum, NSString *verCode,NSString *password) {
                return @(phoneNum.length > 0 && verCode.length > 0 &&password.length > 0);
                                                      }];
    
    RAC(self.regBtn, enabled) = regActiveSignal;
    
    //登陆按钮的透明度
    RAC(_regBtn, alpha) = [regActiveSignal map:^(NSNumber *b) {
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
    
    //密码
    _pwdTextField = [UITextField new];
    _pwdTextField.placeholder = @"～登录密码～";
    _pwdTextField.font = [UIFont fontWithName:@"Helvetica" size:15];
    _pwdTextField.textColor = [UIColor colorWithRed:56.0f/255.0f green:84.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
    _pwdTextField.secureTextEntry = YES;
    _pwdTextField.delegate = self;
    _pwdTextField.returnKeyType = UIReturnKeyDone;
    _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _pwdTextField.enablesReturnKeyAutomatically = YES;
    _pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_pwdTextField];
    
    //注册按钮
    _regBtn =[UIButton buttonWithType:UIButtonTypeSystem];
    _regBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    _regBtn.backgroundColor = [UIColor colorWithHex:0x15A230];
    [_regBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_regBtn setCornerRadius:20];
    [_regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_regBtn addTarget:self action:@selector(regUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_regBtn];
    
    [_pwdTextField addTarget:self action:@selector(returnOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

//当 账号和密码输入框 都没有键盘的时候, 不接收GR点击
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (![_phoneNumTextField isFirstResponder] && ![_pwdTextField isFirstResponder] && ![_verCodeTextField isFirstResponder]) {
        return NO;
    }
    return YES;
}

- (void)setLayout {
    
    for (UIView *view in [self.view subviews]) { view.translatesAutoresizingMaskIntoConstraints = NO;}
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_phoneNumTextField, _getVerCodeBtn,_verCodeTextField,_pwdTextField, _regBtn);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_phoneNumTextField(140)]-10-[_getVerCodeBtn]-10-|"
                                                                      options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_getVerCodeBtn(40)]"     options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_phoneNumTextField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_getVerCodeBtn attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_phoneNumTextField(40)]"
                                                                      options:0 metrics:nil views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_verCodeTextField]-10-|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-125-[_verCodeTextField(40)]-5-[_pwdTextField(40)]-10-[_regBtn(40)]"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:nil views:views]];

}

- (void)getVerCode {
    
    NSString* str = [_defaultCode stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
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
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:self.phoneNumTextField.text
                                          zone:str
                                        result:^(SMS_SDKError *error)
     {
         
         __block int timeout=60; //倒计时时间
         dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
         dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
         dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
         dispatch_source_set_event_handler(_timer, ^{
             if(timeout <= 0){ //倒计时结束，关闭
                 dispatch_source_cancel(_timer);
                 dispatch_async(dispatch_get_main_queue(), ^{
                     //设置界面的按钮显示 根据自己需求设置
                     [_getVerCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                     _getVerCodeBtn.userInteractionEnabled = YES;
                 });
             }else{
                 
                 int seconds = timeout;
                 NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     //设置界面的按钮显示 根据自己需求设置
                     //                         NSLog(@"____%@",strTime);
                     [_getVerCodeBtn setTitle:[NSString stringWithFormat:@"%@秒后重新获取",strTime] forState:UIControlStateNormal];
                     _getVerCodeBtn.userInteractionEnabled = NO;
                     
                 });
                 timeout--;
                 
             }
         });
         dispatch_resume(_timer);
         
         if (!error)
         {
             
         }
         else
         {
             UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"错误", nil)
                                                           message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription]
                                                          delegate:self
                                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                 otherButtonTitles:nil, nil];
             [alert show];
         }
         
     }];
}

- (void)regUser {
    
    [self.view endEditing:YES];
    
    if (self.phoneNumTextField.text.length == 0 && self.verCodeTextField.text.length == 0 && self.pwdTextField.text.length == 0) {
        
        return;
    }
    //验证手机号码
    if (self.phoneNumTextField.text.length != 11) {
        return;
    }
    
    //验证验证码
    if (self.verCodeTextField.text.length != 4) {
        //手机号码不正确
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"警告", nil)
                                                      message:NSLocalizedString(@"验证码为4位哦～", nil)
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                            otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    //验证密码
    if (self.pwdTextField.text.length < 6 || self.pwdTextField.text.length > 12) {
        return;
    }
    
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
    [_pwdTextField resignFirstResponder];
}

//键盘上Next && Done会调用
- (void)returnOnKeyboard:(UITextField *)sender
{
    
    if (sender == _pwdTextField) {
        
        [self hidenKeyboard];
        if (_regBtn.enabled) {
            [self regUser];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
