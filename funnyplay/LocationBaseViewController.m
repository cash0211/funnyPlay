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


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self myInit];
    }
    
    return self;
}

- (void)myInit {
    
    self.title = @"南京";
    
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

- (void)clickAreaPlay:(id)sender {
    
//    [Tool pushAreaPlay:sender andNavController:self.parentViewController.navigationController];
    
    //这里只能是self的nav！！！
    [Tool pushAreaPlay:sender andNavController:self.navigationController];
}

- (void)clickNearby:(id)sender {
    
    
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
