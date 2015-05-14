//
//  ForgetPwdViewController.m
//  funnyplay
//
//  Created by cash on 15-4-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "Tool.h"
#import <SMS_SDK/SMS_SDK.h>

@interface ForgetPwdViewController () {
    
    NSString* _defaultCode;
    NSString* _defaultCountryName;
    
    NSDictionary *_dict;
}

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"找回密码";
    
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
    UIButton* getVerCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
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
    
    //提交按钮
    UIButton* submitBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [submitBtn setTitle:NSLocalizedString(@"提交", nil) forState:UIControlStateNormal];
    NSString *icon2 = [NSString stringWithFormat:@"smssdk.bundle/loginbtn.png"];
    [submitBtn setBackgroundImage:[UIImage imageNamed:icon2] forState:UIControlStateNormal];
    submitBtn.frame=CGRectMake(phoneNumField.frame.origin.x, verCodeField.frame.origin.y + verCodeField.frame.size.height + 10, verCodeField.frame.size.width, verCodeField.frame.size.height - 5);
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    _phoneNumTextField = phoneNumField;
    _getVerCodeBtn = getVerCodeBtn;
    _verCodeTextField = verCodeField;
    _submitBtn = submitBtn;
    
    
    //设置本地区号
    [self setTheLocalAreaCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)submit {
    
    [self.view endEditing:YES];
    
    
    [Tool pushResetPwd:nil andNavController:self.navigationController];
}

- (IBAction)backgrondTouch:(id)sender
{
    [self.phoneNumTextField resignFirstResponder];
    [self.verCodeTextField resignFirstResponder];
}

-(void)setTheLocalAreaCode
{
    //    NSLocale *locale = [NSLocale currentLocale];
    
    _defaultCode=@"+86";
    _defaultCountryName=@"CN";
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
