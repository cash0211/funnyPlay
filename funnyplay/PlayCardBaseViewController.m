//
//  PlayCardBaseViewController.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PlayCardBaseViewController.h"
#import "PlayCardViewController.h"

@interface PlayCardBaseViewController ()

@end

@implementation PlayCardBaseViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self myInit];
    }
    
    return self;
}

- (void)myInit {
    
    self.title = @"玩略";
    
    //表格子视图
    self.playCardViewCon = [[PlayCardViewController alloc] init];
    [self addChildViewController:self.playCardViewCon];
    [self.view addSubview:self.playCardViewCon.view];
    self.playCardViewCon.view.frame = self.view.bounds;
    self.playCardViewCon.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
