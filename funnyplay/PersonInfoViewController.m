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

#import <QuartzCore/QuartzCore.h>

@interface PersonInfoViewController () {
    
    NSMutableArray *_personItem;
    BOOL isLogin;
}

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isLogin = NO;
    _personItem = [[NSMutableArray alloc] init];
    if (isLogin) {
        //假数据
        NSArray *arrayData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"person.plist" ofType:nil]];
        
        for (NSDictionary* dict in arrayData) {
            PersonCellModel *personCellModel = [PersonCellModel personCellWithDict:dict];
            
            [_personItem addObject:personCellModel];
        }
    } else {
        
        PersonCellModel *personCellModel2 = [[PersonCellModel alloc] defaultInit];
        
        [_personItem addObject:personCellModel2];
    }
   
    self.settingInSections = [[NSMutableDictionary alloc] initWithCapacity:2];

    NSArray *itemPerson = [[NSArray alloc] initWithObjects:
                           _personItem[0],
                           nil];
    
    NSArray *itemMyoperation = [[NSArray alloc] initWithObjects:
                                [[MyOperationModel alloc] initWithString:@"收藏"],
                                [[MyOperationModel alloc] initWithString:@"玩略"],
                                [[MyOperationModel alloc] initWithString:@"足迹"],
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_settings count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key =_settings[section];
    NSArray *set = [_settingInSections objectForKey:key];
    
    return [set count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 120;
    } else { 
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        PersonCell *personCell = (PersonCell *)[tableView dequeueReusableCellWithIdentifier:[PersonCell cellId]];
        
        if (!personCell) {
            personCell = [PersonCell personCell];
        }
        
        personCell.personCellModel = _personItem[indexPath.row];
        if (isLogin) {
            personCell.defaultString.hidden = YES;
        }
        
        personCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return personCell;
        
    } else {
        
        UITableViewCell *operationCell = [tableView dequeueReusableCellWithIdentifier:@"MyOperationCell"];
        
        if (!operationCell) {
            operationCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyOperationCell"];
        }
        
        NSString *key = _settings[indexPath.section];
        NSArray *set = _settingInSections[key];
        MyOperationModel *opModel = set[indexPath.row];
        
        operationCell.textLabel.textAlignment = NSTextAlignmentCenter;
        operationCell.textLabel.text = opModel.btnName;
        
        operationCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return operationCell;
    }
}


#pragma  mark tableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSString *key = _settings[section];
    NSArray *set = _settingInSections[key];
    MyOperationModel *opModel = set[row];
    
    if (0 == section) {
        
        [Tool pushLogin:opModel andNavController:self.navigationController];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
