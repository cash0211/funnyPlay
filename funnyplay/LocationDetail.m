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

@interface LocationDetail ()

@end

@implementation LocationDetail


#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)commonInit {
    
    self.navigationItem.title = @"title";
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStyleDone target:self action:@selector(clickCollection:)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    [self.view showHUDIndicatorViewAtCenterWithTitle:@"请稍等..."];
    
    
    //网络请求细节内容
    [self _getLocationDetail];
}

- (void)viewDidLoad {
    
    // addSubViews
    // registerClass
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Event response

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


#pragma mark - Public methods



#pragma mark - Private methods

- (void)_getLocationDetail {
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 临时延迟，看网络加载情况
            [self.view hideDelayHUDViewAtCenter];
        });
    });
    
//    AFHTTPSessionManager
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}


#pragma mark - UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld, %ld", (long)indexPath.section, (long)indexPath.row);
}


#pragma mark - CustomDelegate



#pragma mark - Getters & Setters





@end
