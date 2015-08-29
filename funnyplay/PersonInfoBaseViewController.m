//
//  PersonInfoBaseViewController.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PersonInfoBaseViewController.h"
#import "PersonInfoViewController.h"

@interface PersonInfoBaseViewController ()

@end

@implementation PersonInfoBaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self myInit];
    }
    
    return self;
}

- (void)myInit {
    
    self.title = @"我的";
    
    //表格子视图
    self.personInfoViewCon = [[PersonInfoViewController alloc] init];
    [self addChildViewController:self.personInfoViewCon];
    [self.view addSubview:self.personInfoViewCon.view];
    self.personInfoViewCon.view.frame = self.view.bounds;
    self.personInfoViewCon.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
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
