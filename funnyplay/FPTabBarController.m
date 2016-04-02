//
//  FPTabBarController.m
//  funnyplay
//
//  Created by cash on 15-8-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FPTabBarController.h"

#import "LocationBaseViewController.h"
#import "RecommendBaseViewController.h"
#import "PlayCardBaseViewController.h"
#import "FlowgroundBaseViewController.h"
#import "PersonInfoViewController.h"

@interface FPTabBarController ()

@end

@implementation FPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置各种VC，添加进viewControllers
    //本地
    LocationBaseViewController *locBase = [[LocationBaseViewController alloc] initWithNibName:@"LocationBase" bundle:nil];
    
    //附近
    //    self.nearBase = [[NearbyBaseViewController alloc] initWithNibName:@"NearbyBase" bundle:nil];
    //    UINavigationController *nearbyNav = [[UINavigationController alloc] initWithRootViewController:self.nearBase];
    
    //推荐
    RecommendBaseViewController *recoBase = [[RecommendBaseViewController alloc] init];
    
    //流动墙
    FlowgroundBaseViewController *flowgroundBase = [[FlowgroundBaseViewController alloc] init];
    
    //玩略
    PlayCardBaseViewController *playCardBase = [[PlayCardBaseViewController alloc] init];
    
    //个人信息
    PersonInfoViewController *personInfoBase = [[PersonInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    self.viewControllers = @[
                             [[UINavigationController alloc] initWithRootViewController:locBase],
                             [[UINavigationController alloc] initWithRootViewController:recoBase],
                             [[UINavigationController alloc] initWithRootViewController:flowgroundBase],
                             [[UINavigationController alloc] initWithRootViewController:playCardBase],
                             [[UINavigationController alloc] initWithRootViewController:personInfoBase]
                             ];
    
    //设置tabbar的item的图片,文字
    NSArray *titles = @[@"南京", @"推荐", @"流动墙", @"玩略", @"我的"];
    NSArray *images = @[@"location", @"reco2", @"flowzone", @"playcard", @"my"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setImage:[UIImage imageNamed:images[idx]]];
//        [item setSelectedImage:[UIImage imageNamed:[images[idx] stringByAppendingString:@""]]];
    }];
    
}

#pragma mark - UITabBarDelegate

/******保留，没看懂********
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (self.selectedIndex <= 1 && self.selectedIndex == [tabBar.items indexOfObject:item]) {
        SwipableViewController *swipeableVC = (SwipableViewController *)((UINavigationController *)self.selectedViewController).viewControllers[0];
        OSCObjsViewController *objsViewController = (OSCObjsViewController *)swipeableVC.viewPager.childViewControllers[swipeableVC.titleBar.currentIndex];
        
        
        [UIView animateWithDuration:0.1 animations:^{
            [objsViewController.tableView setContentOffset:CGPointMake(0, -objsViewController.refreshControl.frame.size.height)];
        } completion:^(BOOL finished) {
            [objsViewController.refreshControl beginRefreshing];
        }];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [objsViewController refresh];
        });
    }
}
*/

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
