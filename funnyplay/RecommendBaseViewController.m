//
//  RecommendBaseViewController.m
//  funnyplay
//
//  Created by cash on 15-5-22.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "RecommendBaseViewController.h"
#import "RecommendViewController.h"

@interface RecommendBaseViewController ()

@end

@implementation RecommendBaseViewController


#pragma mark - Lifecycle

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;

    self.navigationItem.title = @"推荐";
    
    //表格子视图
    self.recommendViewCon = [[RecommendViewController alloc] init];
    [self addChildViewController:self.recommendViewCon];
    [self.view addSubview:self.recommendViewCon.view];
    self.recommendViewCon.view.frame = self.view.bounds;
    self.recommendViewCon.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
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








