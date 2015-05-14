//
//  LocationViewController.m
//  funnyplay
//
//  Created by cash on 15-3-16.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationCell.h"
#import "Location.h"
#import "LocationDetail.h"
#import "Tool.h"

@interface LocationViewController () {
    
    NSMutableArray *_allItems;
}

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor grayColor];
    
    _allItems = [[NSMutableArray alloc] init];
    NSArray *arrayData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"location.plist" ofType:nil]];
    
    for (NSDictionary* dict in arrayData) {
        Location *loc = [Location locationWithDict:dict];
        
        [_allItems addObject:loc];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_allItems count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        LocationCell *cell = (LocationCell *)[tableView dequeueReusableCellWithIdentifier:[LocationCell cellId]];
        if (!cell) {
            cell = [LocationCell locationCell];
        }
        
        cell.location = _allItems[indexPath.row];
        
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Location *loc = _allItems[indexPath.row];
    if (loc) {
        //self.parentViewController.title = loc.itemName;
//        self.parentViewController.tabBarItem.title = @"评论";
        
        [Tool pushLocationDetail:loc andNavController:self.parentViewController.navigationController];
    }
    
    /* 两个一样
    if (self.navigationController == self.parentViewController.navigationController) {
        NSLog(@"yes");
        NSLog(@"%@", self.navigationController);
        NSLog(@"%@", self.parentViewController.navigationController);
    }
    */
    
    
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
