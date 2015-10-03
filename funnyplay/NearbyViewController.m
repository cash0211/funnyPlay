//
//  NearbyViewController.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "NearbyViewController.h"
#import "Nearby.h"
#import "NearbyCell.h"
#import "Tool.h"

@interface NearbyViewController () {
    
    NSMutableArray *_allItems;
}

@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allItems = [[NSMutableArray alloc] init];
    NSArray *arrayData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"location.plist" ofType:nil]];
    
    for (NSDictionary* dict in arrayData) {
        Nearby *nearby = [Nearby nearbyWithDict:dict];
        
        [_allItems addObject:nearby];
    }
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
    
    NearbyCell *cell = (NearbyCell *)[tableView dequeueReusableCellWithIdentifier:[NearbyCell cellId]];
    if (!cell) {
        cell = [NearbyCell nearbyCell];
    }
    
    cell.nearby = _allItems[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Nearby *nearby = _allItems[indexPath.row];
    if (nearby) {
        //self.parentViewController.title = loc.itemName;
        //        self.parentViewController.tabBarItem.title = @"评论";
        [Tool pushNearbyDetail:nearby andNavController:self.parentViewController.navigationController];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
