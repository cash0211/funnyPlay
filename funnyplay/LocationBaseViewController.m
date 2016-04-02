//
//  LocationBaseViewController.m
//  funnyplay
//
//  Created by cash on 15-3-16.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "LocationBaseViewController.h"
#import "LocationViewController.h"
#import "Tool.h"

@interface LocationBaseViewController ()

@end

@implementation LocationBaseViewController


#pragma mark - Lifecycle

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
    
    self.navigationItem.title = @"南京";
    
    //表格子视图
    self.locationViewCon = [[LocationViewController alloc] init];
    [self addChildViewController:self.locationViewCon];
    [self.view addSubview:self.locationViewCon.view];
    self.locationViewCon.view.frame = self.view.bounds;
    self.locationViewCon.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    //"区域玩"
    //    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //    [btn setTitle:@"区域玩" forState:UIControlStateNormal];
    //    [btn addTarget:self action:@selector(clickAreaPlay:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    UIBarButtonItem *btnAreaPlay = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //    self.navigationItem.rightBarButtonItem = btnAreaPlay;
    
    //"附近"
    UIBarButtonItem *btnNearbyTitle = [[UIBarButtonItem alloc] initWithTitle:@"附近" style:UIBarButtonItemStyleDone target:self action:@selector(clickNearby:)];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn addTarget:self action:@selector(clickNearby:) forControlEvents:UIControlEventTouchUpInside];
    if([[[UIDevice currentDevice] systemVersion]floatValue] >= 7.0)
    {
        [btn setImage:[UIImage imageNamed:@"nearby"] forState:UIControlStateNormal];
        //        btn.imageEdgeInsets = UIEdgeInsetsMake(0,10, 0, -10);
    }
    
    else
        [btn setImage:[UIImage imageNamed:@"nearby"] forState:UIControlStateNormal];
    
    UIBarButtonItem *btnNearby = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:btnNearbyTitle, btnNearby, nil];
    
    
    
    //"区域玩" --- 直接 BarButtonItem
    UIBarButtonItem *btnAreaPlay = [[UIBarButtonItem alloc] initWithTitle:@"区域玩" style:UIBarButtonItemStyleDone target:self action:@selector(clickAreaPlay:)];
    self.navigationItem.rightBarButtonItem = btnAreaPlay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark - Event response

- (void)clickAreaPlay:(id)sender {
    
//    [Tool pushAreaPlay:sender andNavController:self.parentViewController.navigationController];
    
    //这里只能是self的nav！！！
    [Tool pushAreaPlay:sender andNavController:self.navigationController];
}

- (void)clickNearby:(id)sender {
    
    
}

@end







