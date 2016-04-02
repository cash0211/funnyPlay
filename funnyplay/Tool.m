//
//  Tool.m
//  funnyplay
//
//  Created by cash on 15-3-20.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "Tool.h"
#import "LocationDetail.h"
#import "AreaPlayViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "ResetPasswordViewController.h"

#import <MBProgressHUD.h>

@implementation Tool

#pragma mark - 界面推送

+ (void)noticeLogin:(UIView *)view andDelegate:(id)delegate andTitle:(NSString *)title {
    
    UIActionSheet *loginSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"登录", nil];
    [loginSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

+ (void)pushLocationDetail:(Location *)loc andNavController:(UINavigationController *)navController {
    
    UITabBarController *tabBarCon = [[UITabBarController alloc] init];
    LocationDetail *locDetail = [[LocationDetail alloc] init];
    UINavigationController *locationNav = [[UINavigationController alloc] initWithRootViewController:locDetail];
    tabBarCon.viewControllers = [NSArray arrayWithObjects:locationNav, nil];
    tabBarCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:tabBarCon animated:YES];
}

+ (void)pushAreaPlay:(id)sender andNavController:(UINavigationController *)navController {
    
    AreaPlayViewController *areaPlayCon = [[AreaPlayViewController alloc] init];
    areaPlayCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:areaPlayCon animated:YES];
    
}

+ (void)pushLogin:(id)sender andNavController:(UINavigationController *)navController {
    
    LoginViewController *loginCon = [[LoginViewController alloc] init];
    loginCon.hidesBottomBarWhenPushed = YES;
    
    [navController pushViewController:loginCon animated:YES];
}

+ (void)pushRegUser:(id)sender andNavController:(UINavigationController *)navController {
    
    RegisterViewController *regCon = [[RegisterViewController alloc] init];
    
    [navController pushViewController:regCon animated:YES];
}

+(void)pushforgetPwd:(id)sender andNavController:(UINavigationController *)navController {
    
    ForgetPasswordViewController *forgetCon = [[ForgetPasswordViewController alloc] init];
    
    [navController pushViewController:forgetCon animated:YES];
}

+(void)pushResetPwd:(id)sender andNavController:(UINavigationController *)navController {
    
    ResetPasswordViewController *resetCon = [[ResetPasswordViewController alloc] init];
    
    [navController pushViewController:resetCon animated:YES];
}

+ (BOOL)isURL:(NSString *)string
{
    NSString *pattern = @"^(http|https)://.*?$(net|com|.com.cn|org|me|)";
    
    NSPredicate *urlPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    
    return [urlPredicate evaluateWithObject:string];
}


#pragma mark - 流动墙功能
#pragma mark time_1

+ (NSString *)intervalSinceNow:(NSString *)dateStr
{
    NSDictionary *dic = [Tool timeIntervalArrayFromString:dateStr];
    //NSInteger years = [[dic objectForKey:kKeyYears] integerValue];
    NSInteger months = [[dic objectForKey:kKeyMonths] integerValue];
    NSInteger days = [[dic objectForKey:kKeyDays] integerValue];
    NSInteger hours = [[dic objectForKey:kKeyHours] integerValue];
    NSInteger minutes = [[dic objectForKey:kKeyMinutes] integerValue];
    
    if (minutes < 1) {
        return @"刚刚";
    } else if (minutes < 60) {
        return [NSString stringWithFormat:@"%ld分钟前", (long)minutes];
    } else if (hours < 24) {
        return [NSString stringWithFormat:@"%ld小时前", (long)hours];
    } else if (hours < 48 && days == 1) {
        return @"昨天";
    } else if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前", (long)days];
    } else if (days < 60) {
        return @"一个月前";
    } else if (months < 12) {
        return [NSString stringWithFormat:@"%ld个月前", (long)months];
    } else {
        NSArray *arr = [dateStr componentsSeparatedByString:@"T"];
        return arr[0];
    }
}

+ (NSDictionary *)timeIntervalArrayFromString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *compsPast = [calendar components:unitFlags fromDate:date];
    NSDateComponents *compsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger years = [compsNow year] - [compsPast year];
    NSInteger months = [compsNow month] - [compsPast month] + years * 12;
    NSInteger days = [compsNow day] - [compsPast day] + months * 30;
    NSInteger hours = [compsNow hour] - [compsPast hour] + days * 24;
    NSInteger minutes = [compsNow minute] - [compsPast minute] + hours * 60;
    
    return @{
             kKeyYears:  @(years),
             kKeyMonths: @(months),
             kKeyDays:   @(days),
             kKeyHours:  @(hours),
             kKeyMinutes:@(minutes)
             };
}

#pragma mark time_2

+ (NSString *)pubTime:(NSString *)dateStr {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *compsPast = [calendar components:unitFlags fromDate:date];
    NSDateComponents *compsNow = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSInteger years = [compsNow year] - [compsPast year];
    NSInteger months = [compsNow month] - [compsPast month] + years * 12;
    
    NSUInteger monthdays = [compsPast month] == 1 || [compsPast month] == 3 || [compsPast month] == 5 || [compsPast month] == 7 || [compsPast month] == 8 || [compsPast month] == 10 || [compsPast month] == 12 ? 31 : 30;
    
    NSInteger days = [compsNow day] - [compsPast day] + months * monthdays;
    
    if ([compsNow year] == [compsPast year]) {
        
        if ([compsNow month] == [compsPast month]) {
            
            if ([compsNow day] == [compsPast day]) {
                
                return [NSString stringWithFormat:@"今天 %.2ld:%.2ld", (long)[compsPast hour], (long)[compsPast minute]];
                
            } else if (days == 1) {
                
                return [NSString stringWithFormat:@"昨天 %.2ld:%.2ld", (long)[compsPast hour], (long)[compsPast minute]];
                
            } else if (days == 2) {
                
                return [NSString stringWithFormat:@"前天 %.2ld:%.2ld", (long)[compsPast hour], (long)[compsPast minute]];
                
            } else {
                
                return [NSString stringWithFormat:@"%.2ld-%.2ld", (long)[compsPast month], (long)[compsPast day]];
            }
            
        } else if (days == 1) {
            
            return [NSString stringWithFormat:@"昨天 %.2ld:%.2ld", (long)[compsPast hour], (long)[compsPast minute]];
            
            
        } else if (days == 2) {
            
            return [NSString stringWithFormat:@"前天 %.2ld:%.2ld", (long)[compsPast hour], (long)[compsPast minute]];
            
        } else {
            
            return [NSString stringWithFormat:@"%.2ld-%.2ld", (long)[compsPast month], (long)[compsPast day]];
        }
        
    } else {
        
        return [NSString stringWithFormat:@"%ld-%.2ld-%.2ld", (long)[compsPast year], (long)[compsPast month], (long)[compsPast day]];
    }
    
    return nil;
}

// 参考 http://www.cnblogs.com/ludashi/p/3962573.html

#pragma mark content

+ (NSAttributedString *)emojiStringFromRawString:(NSString *)rawString
{
    NSMutableAttributedString *emojiString = [[NSMutableAttributedString alloc] initWithString:rawString];
    NSDictionary *emoji = self.emojiDict;
    
    //[\u4e00-\u9fa5] 匹配中文字符
    NSString *pattern = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]|:[a-zA-Z0-9\\u4e00-\\u9fa5_]+:";
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *resultsArray = [re matchesInString:rawString options:0 range:NSMakeRange(0, rawString.length)];
    
    NSMutableArray *emojiArray = [NSMutableArray arrayWithCapacity:resultsArray.count];
    
    for (NSTextCheckingResult *match in resultsArray) {
        NSRange range = [match range];
        NSString *emojiName = [rawString substringWithRange:range];
        
        if ([emojiName hasPrefix:@"["] && emoji[emojiName]) {
            NSTextAttachment *textAttachment = [NSTextAttachment new];
            textAttachment.image = [UIImage imageNamed:emoji[emojiName]];
            [textAttachment adjustY:-3];
            
            NSAttributedString *emojiAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
            
            [emojiArray addObject: @{@"image": emojiAttributedString, @"range": [NSValue valueWithRange:range]}];
        } else if ([emojiName hasPrefix:@":"]) {
            if (emoji[emojiName]) {
                
                [emojiArray addObject:@{@"text": emoji[emojiName], @"range": [NSValue valueWithRange:range]}];
            } else {
                UIImage *emojiImage = [UIImage imageNamed:[emojiName stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]]];
                //trimming掉 : 符号
                NSTextAttachment *textAttachment = [NSTextAttachment new];
                textAttachment.image = emojiImage;
                [textAttachment adjustY:-3];
                
                NSAttributedString *emojiAttributedString = [NSAttributedString attributedStringWithAttachment:textAttachment];
                
                [emojiArray addObject: @{@"image": emojiAttributedString, @"range": [NSValue valueWithRange:range]}];
            }
        }
    }
    
    for (NSInteger i = emojiArray.count -1; i >= 0; i--) {
        NSRange range;
        [emojiArray[i][@"range"] getValue:&range];
        if (emojiArray[i][@"image"]) {
            [emojiString replaceCharactersInRange:range withAttributedString:emojiArray[i][@"image"]];
        } else {
            [emojiString replaceCharactersInRange:range withString:emojiArray[i][@"text"]];
        }
    }
    
    return emojiString;
}

#pragma mark emoji Dict

+ (NSDictionary *)emojiDict
{
    static dispatch_once_t once;
    static NSDictionary *emojiDict;
    
    dispatch_once(&once, ^ {
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"emoji" ofType:@"plist"];
        emojiDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    });
    
    return emojiDict;
}

#pragma mark 终端获取

+ (NSAttributedString *)getAppclient:(int)clientType
{
    NSMutableAttributedString *clientString = [NSMutableAttributedString new];
    if (clientType >= 0 && clientType <= 2) {
        NSTextAttachment *textAttachment = [NSTextAttachment new];
        textAttachment.image = [UIImage imageNamed:@"phone"];
        [textAttachment adjustY:-2];
        
        NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
        [clientString appendAttributedString:attachmentString];
        
        NSArray *clients = @[@"Android", @"iPhone", @"Windows Phone"];
        [clientString appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        [clientString appendAttributedString:[[NSAttributedString alloc] initWithString:clients[clientType]]];
    } else {
        [clientString appendAttributedString:[[NSAttributedString alloc] initWithString:@""]];
    }
    
    return clientString;
}



@end








































































