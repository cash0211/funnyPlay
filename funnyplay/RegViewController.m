//
//  RegViewController.m
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "RegViewController.h"
#import <SMS_SDK/SMS_SDK.h>

@interface RegViewController () {
    
//    NSMutableArray* _areaArray;
    NSString* _defaultCode;
    NSString* _defaultCountryName;
    
    NSDictionary *_dict;
}

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:@"86", @"zone",
                                                      @"^1(3|5|7|8|4)\\d{9}", @"rule",
                                                      nil];
    
    CGFloat statusBarHeight = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        statusBarHeight = 20;
    }
    
    //手机号
    UITextField* phoneNumField = [[UITextField alloc] init];
    phoneNumField.frame = CGRectMake(10, 60+statusBarHeight, (self.view.frame.size.width - 160), 40+statusBarHeight/4);
    phoneNumField.borderStyle = UITextBorderStyleRoundedRect;
    phoneNumField.placeholder = [NSString stringWithFormat:@"～手机号～"];
    phoneNumField.font = [UIFont fontWithName:@"Helvetica" size:15];
    phoneNumField.keyboardType = UIKeyboardTypePhonePad;
    phoneNumField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:phoneNumField];
    
    //获取验证码
    UIButton* getVerCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom]; //这里用custom不会闪烁
    getVerCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [getVerCodeBtn setTitle:NSLocalizedString(@"获取验证码", nil) forState:UIControlStateNormal];

    NSString *icon = [NSString stringWithFormat:@"smssdk.bundle/loginbtn.png"];
    [getVerCodeBtn setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    getVerCodeBtn.frame=CGRectMake(phoneNumField.frame.origin.x + phoneNumField.frame.size.width + 10, phoneNumField.frame.origin.y, 130, phoneNumField.frame.size.height);
    [getVerCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getVerCodeBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getVerCodeBtn];
    
    //验证码
    UITextField* verCodeField = [[UITextField alloc] init];
    verCodeField.frame = CGRectMake(phoneNumField.frame.origin.x, phoneNumField.frame.origin.y + phoneNumField.frame.size.height + 5, (self.view.frame.size.width - 20), phoneNumField.frame.size.height);
    verCodeField.borderStyle = UITextBorderStyleRoundedRect;
    verCodeField.placeholder = [NSString stringWithFormat:@"～验证码～"];
    verCodeField.font = [UIFont fontWithName:@"Helvetica" size:15];
    verCodeField.keyboardType = UIKeyboardTypePhonePad;
    verCodeField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:verCodeField];
    
    //密码
    UITextField* passwordField = [[UITextField alloc] init];
    passwordField.frame = CGRectMake(phoneNumField.frame.origin.x, verCodeField.frame.origin.y + verCodeField.frame.size.height + 5, verCodeField.frame.size.width, verCodeField.frame.size.height);
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.placeholder = [NSString stringWithFormat:@"～登录密码～"];
    passwordField.font = [UIFont fontWithName:@"Helvetica" size:15];
    passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordField.secureTextEntry = YES;
    [self.view addSubview:passwordField];
    
    //注册按钮
    UIButton* regBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [regBtn setTitle:NSLocalizedString(@"注册", nil) forState:UIControlStateNormal];
    NSString *icon2 = [NSString stringWithFormat:@"smssdk.bundle/loginbtn.png"];
    [regBtn setBackgroundImage:[UIImage imageNamed:icon2] forState:UIControlStateNormal];
    regBtn.frame=CGRectMake(phoneNumField.frame.origin.x, passwordField.frame.origin.y + passwordField.frame.size.height + 10, passwordField.frame.size.width, passwordField.frame.size.height - 5);
    [regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [regBtn addTarget:self action:@selector(regUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
    
    _phoneNumTextField = phoneNumField;
    _getVerCodeBtn = getVerCodeBtn;
    _verCodeTextField = verCodeField;
    _pwdTextField = passwordField;
    _regBtn = regBtn;
    
    
    //设置本地区号
    [self setTheLocalAreaCode];
}

- (void)getVerCode {
    
    [self.verCodeTextField becomeFirstResponder];
    
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
    }
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:self.phoneNumTextField.text
                                          zone:str
                                        result:^(SMS_SDKError *error)
     {
         //bug --- 因为反应慢，按多次会显示多次 --- 闪烁！！！
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

- (IBAction)backgrondTouch:(id)sender
{
    [self.phoneNumTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    [self.verCodeTextField resignFirstResponder];
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
