//
//  PersonInfoViewController.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PersonCell.h"
#import "MyOperationModel.h"
#import "PersonCellModel.h"
#import "Tool.h"
#import "FPMessagesViewController.h"
#import "TableViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface PersonInfoViewController () {
    
    BOOL isLogin;
}

@property (nonatomic, strong) NSMutableArray *personItem;

@end

@implementation PersonInfoViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    self.navigationItem.title = @"我的";
    
    isLogin = YES;
    self.personItem = [[NSMutableArray alloc] init];
    if (isLogin) {
        //假数据
        NSArray *arrayData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"person.plist" ofType:nil]];
        
        for (NSDictionary* dict in arrayData) {
            PersonCellModel *personCellModel = [PersonCellModel personCellWithDict:dict];
            
            [self.personItem addObject:personCellModel];
        }
    } else {
        
    }
    
    self.settingInSections = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    NSArray *itemPerson = [[NSArray alloc] initWithObjects:
                           self.personItem[0],
                           nil];
    
    NSArray *itemMyoperation = [[NSArray alloc] initWithObjects:
                                [[MyOperationModel alloc] initWithString:@"收藏"],
                                [[MyOperationModel alloc] initWithString:@"玩略"],
                                [[MyOperationModel alloc] initWithString:@"足迹"],
                                [[MyOperationModel alloc] initWithString:@"玩伴"],
                                nil];
    
    NSArray *function = [[NSArray alloc] initWithObjects:
                         [[MyOperationModel alloc] initWithString:@"扫一扫"],
                         [[MyOperationModel alloc] initWithString:@"摇一摇"],
                         nil];
    
    NSArray *setting = [[NSArray alloc] initWithObjects:
                        [[MyOperationModel alloc] initWithString:@"设置"],
                        nil];
    
    [self.settingInSections setObject:itemPerson forKey:@"个人"];
    [self.settingInSections setObject:itemMyoperation forKey:@"我的操作"];
    [self.settingInSections setObject:function forKey:@"功能"];
    [self.settingInSections setObject:setting forKey:@"设置"];
    
    self.settings = [[NSArray alloc] initWithObjects:@"个人", @"我的操作", @"功能", @"设置",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Event response



#pragma mark - Private methods



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.settings count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key =self.settings[section];
    NSArray *set = [self.settingInSections objectForKey:key];
    
    return [set count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        PersonCell *personCell = [[PersonCell alloc] init];
            
        personCell.personCellModel = self.personItem[indexPath.row];
        personCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return personCell;
        
    } else {
        
        UITableViewCell *operationCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoOperationCellIdentifier"];
        
        NSString *key = self.settings[indexPath.section];
        NSArray *set = self.settingInSections[key];
        MyOperationModel *opModel = set[indexPath.row];
        
        operationCell.textLabel.textAlignment = NSTextAlignmentCenter;
        operationCell.textLabel.text = opModel.btnName;
        
        operationCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return operationCell;
    }
}


#pragma mark - UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 120;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *key = self.settings[section];
    NSArray *set = self.settingInSections[key];
    MyOperationModel *opModel = set[row];
    
    if (0 == section) {
        
        [Tool pushLogin:opModel andNavController:self.navigationController];
        
    } else if ([opModel.btnName isEqualToString:@"玩伴"]) {
        
        FPMessagesViewController *fpMessageVC = [FPMessagesViewController messagesViewController];
        fpMessageVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:fpMessageVC animated:YES];
        
    } else if ([opModel.btnName isEqualToString:@"设置"]) {
        
        TableViewController *tableView = [[TableViewController alloc] init];
        tableView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tableView animated:YES];
    }
}


#pragma mark - CustomDelegate



#pragma mark - Getters & Setters

@end






