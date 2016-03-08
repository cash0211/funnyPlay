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

@end
