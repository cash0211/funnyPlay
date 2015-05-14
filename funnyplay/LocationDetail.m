//
//  LocationDetail.m
//  funnyplay
//
//  Created by cash on 15-3-17.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "LocationDetail.h"
#import "Tool.h"

@interface LocationDetail ()

@end

@implementation LocationDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parentViewController.navigationItem.title = @"title";
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStyleDone target:self action:@selector(clickCollection:)];
    self.parentViewController.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:barButton, nil];
    
    
}

#pragma mark tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%d, %d", indexPath.section, indexPath.row);
}


- (void)clickCollection:(id)sender {
    
    /*
    if ([Config Instance].isCookie == NO) {
        [Tool noticeLogin:self.view andDelegate:self andTitle:@"请先登录后发表评论"];
        return;
    }
    */
    if (YES) {
        [Tool noticeLogin:self.view andDelegate:self andTitle:@"请先登录再收藏"];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
