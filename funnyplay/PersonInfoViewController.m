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
#import <QuartzCore/QuartzCore.h>
#import "Tool.h"

@interface PersonInfoViewController () {
    
    NSMutableArray *_personItem;
    BOOL isLogin;
}

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.personInfoTable.layer.cornerRadius = 8.0;
//    self.personInfoTable.layer.cornerRadius = 10;
//    self.personInfoTable.layer.masksToBounds = YES;
    
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
                                [[MyOperationModel alloc] initWithString:@"我的收藏"],
                                [[MyOperationModel alloc] initWithString:@"我的玩略"],
                                [[MyOperationModel alloc] initWithString:@"我的足迹"],
                                nil];
    
    NSArray *setting = [[NSArray alloc] initWithObjects:
                                [[MyOperationModel alloc] initWithString:@"设置"],
                                nil];
    
    [self.settingInSections setObject:itemPerson forKey:@"个人"];
    [self.settingInSections setObject:itemMyoperation forKey:@"我的操作"];
    [self.settingInSections setObject:setting forKey:@"设置"];
    
    self.settings = [[NSArray alloc] initWithObjects:@"个人", @"我的操作", @"设置",nil];
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
        
        
        //添加圆角边框
        UIView *container_ = [[UIView alloc] initWithFrame:CGRectMake(0,0,personCell.frame.size.width,personCell.frame.size.height)];
        container_.layer.cornerRadius = 8.0;
        container_.layer.masksToBounds = YES;
        [personCell.contentView addSubview:container_];
        
        personCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return personCell;
    } else if (3 == indexPath.section) {
        
        UITableViewCell *settingCell = [tableView dequeueReusableCellWithIdentifier:@"MyOperationCell"];
        
        if (!settingCell) {
            
            settingCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyOperationCell"];
        }
        NSString *key = _settings[indexPath.section];
        NSArray *set = _settingInSections[key];
        
        settingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return set[indexPath.row];
        
    } else {
        
//        MyOperationCell *operationCell = (MyOperationCell *)[tableView dequeueReusableCellWithIdentifier:[MyOperationCell cellId]];
        UITableViewCell *operationCell = [tableView dequeueReusableCellWithIdentifier:@"MyOperationCell"];
        
        if (!operationCell) {
//            operationCell = [MyOperationCell myOperationCell];
            operationCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyOperationCell"];
        }
        
        NSString *key = _settings[indexPath.section];
        NSArray *set = _settingInSections[key];
        MyOperationModel *opModel = set[indexPath.row];
        
        //添加圆角边框
        UIView *container_ = [[UIView alloc] initWithFrame:CGRectMake(0,0,operationCell.frame.size.width,operationCell.frame.size.height)];
        container_.layer.cornerRadius = 8.0;
        container_.layer.masksToBounds = YES;
        [operationCell.contentView addSubview:container_];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
