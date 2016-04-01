//
//  LocationDetail.m
//  funnyplay
//
//  Created by cash on 15-3-17.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "LocationDetail.h"
#import "Tool.h"
#import "UIView+ActivityIndicator.h"

#import <MBProgressHUD.h>

@interface LocationDetail ()

@end

@implementation LocationDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parentViewController.navigationItem.title = @"title";
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStyleDone target:self action:@selector(clickCollection:)];
    self.parentViewController.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:barButton, nil];
    
    [self.view showHUDIndicatorViewAtCenterWithTitle:@"请稍等..."];
    

    //网络请求细节内容
    [self getLocationDetail];
}

- (void)getLocationDetail {
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 临时延迟，看网络加载情况
            [self.view hideDelayHUDViewAtCenter];
        });
    });
    
    /*
    [[AFFPClient sharedClient] GET:@"" parameters:@{} success:^(NSURLSessionDataTask *task, id responseObject) {
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    }];
     */
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
    
    NSLog(@"%ld, %ld", (long)indexPath.section, (long)indexPath.row);
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
