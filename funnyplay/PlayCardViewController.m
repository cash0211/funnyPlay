//
//  PlayCardViewController.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PlayCardViewController.h"
#import "PlayCard.h"
#import "PlayCardData.h"
#import "PlayCardCell.h"
#import "LocationCell.h"
#import "Tool.h"

@interface PlayCardViewController () {
    
    NSMutableArray *_allItems;
}

@end

@implementation PlayCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allItems = [[NSMutableArray alloc] init];
    NSArray *arrayData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"playCard.plist" ofType:nil]];
    
    for (NSDictionary *dict in arrayData) {
        
        PlayCardData *playCardData = [PlayCardData playCardDataWithDict:dict];
        
        [_allItems addObject:playCardData];
    }
    
}

#pragma mark -tableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_allItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[_allItems[section] contents] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [_allItems[section] header];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if ([[_allItems[section] header] isEqual:@"本地人玩"]) {
        
        LocationCell *cell = (LocationCell *)[tableView dequeueReusableCellWithIdentifier:[LocationCell cellId]];
        if (!cell) {
            cell = [LocationCell locationCell];
        }
        
        PlayCardData *playCardData = _allItems[section];
        cell.location = playCardData.playCards[row];
        
        return cell;
    } else {
        
        PlayCardCell *cell = (PlayCardCell *)[tableView dequeueReusableCellWithIdentifier:[PlayCardCell cellId]];
        if (!cell) {
            cell = [PlayCardCell playCardCell];
        }
        
        PlayCardData *playCardData = _allItems[section];
        cell.playCard = playCardData.playCards[row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlayCardData *play = _allItems[indexPath.section];
    Location *loc = play.playCards[indexPath.row];
    if (loc) {
        //self.parentViewController.title = loc.itemName;
        //        self.parentViewController.tabBarItem.title = @"评论";
        
        [Tool pushLocationDetail:loc andNavController:self.navigationController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
