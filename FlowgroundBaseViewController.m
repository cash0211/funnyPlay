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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self myInit];
    }
    
    return self;
}

- (void)myInit {
    
    self.title = @"流动墙";
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
