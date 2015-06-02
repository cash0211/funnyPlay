//
//  NearbyBaseViewController.m
//  funnyplay
//
//  Created by cash on 15-3-21.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "NearbyBaseViewController.h"
#import "NearbyViewController.h"

@interface NearbyBaseViewController ()

@end

@implementation NearbyBaseViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self myInit];
    }
    
    return self;
}

- (void)myInit {
    
    //初始化主视图
    self.tabBarItem.title = @"附近";
    self.tabBarItem.image = [UIImage imageNamed:@"nearby"];
    
    self.navigationItem.title = @"附近";
    
    //表格子视图
    self.nearbyViewCon = [[NearbyViewController alloc] init];
    [self addChildViewController:self.nearbyViewCon];
    [self.view addSubview:self.nearbyViewCon.view];
    self.nearbyViewCon.view.frame = self.view.bounds;
    self.nearbyViewCon.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
