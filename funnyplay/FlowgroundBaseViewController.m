//
//  FlowgroundBaseViewController.m
//  funnyplay
//
//  Created by cash on 15-5-21.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FlowgroundBaseViewController.h"
#import "FlowgroundViewController.h"

@interface FlowgroundBaseViewController ()

@end

@implementation FlowgroundBaseViewController


#pragma mark - Lifecycle

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
    
    self.navigationItem.title = @"流动墙";
    
    //表格子视图
    self.flowgroundViewCon = [[FlowgroundViewController alloc] init];
    [self addChildViewController:self.flowgroundViewCon];
    [self.view addSubview:self.flowgroundViewCon.view];
    self.flowgroundViewCon.view.frame = self.view.bounds;
    self.flowgroundViewCon.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //"区域玩" --- 直接 BarButtonItem
    //    UIBarButtonItem *btnAreaPlay = [[UIBarButtonItem alloc] initWithTitle:@"区域玩" style:UIBarButtonItemStyleDone target:self action:@selector(clickAreaPlay:)];
    //    self.navigationItem.rightBarButtonItem = btnAreaPlay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






