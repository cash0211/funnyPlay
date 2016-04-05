//
//  FPTabBarController.m
//  funnyplay
//
//  Created by cash on 15-8-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FPTabBarController.h"

#import "LocationViewController.h"
#import "RecommendViewController.h"
#import "FlowgroundViewController.h"
#import "PlayCardViewController.h"
#import "PersonInfoViewController.h"

@interface FPTabBarController ()

@end

@implementation FPTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LocationViewController *locVC = [LocationViewController new];
    
    RecommendViewController *recoVC = [[RecommendViewController alloc] init];
    
    FlowgroundViewController *flowgroundVC = [[FlowgroundViewController alloc] init];
    
    PlayCardViewController *playCardVC = [[PlayCardViewController alloc] init];
    
    PersonInfoViewController *personInfoVC = [[PersonInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    self.viewControllers = @[
                             [[UINavigationController alloc] initWithRootViewController:locVC],
                             [[UINavigationController alloc] initWithRootViewController:recoVC],
                             [[UINavigationController alloc] initWithRootViewController:flowgroundVC],
                             [[UINavigationController alloc] initWithRootViewController:playCardVC],
                             [[UINavigationController alloc] initWithRootViewController:personInfoVC]
                             ];
    
    NSArray *titles = @[@"南京", @"推荐", @"流动墙", @"玩略", @"我的"];
    NSArray *images = @[@"location", @"reco2", @"flowzone", @"playcard", @"my"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setImage:[UIImage imageNamed:images[idx]]];
    }];
    
}

#pragma mark - UITabBarDelegate

/***
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

@end
