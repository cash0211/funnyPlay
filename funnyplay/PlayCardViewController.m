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
#import "LocationCell.h"
#import "PlayCardCell.h"
#import "Tool.h"

@interface PlayCardViewController ()

@end

@implementation PlayCardViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arrayData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"playCard.plist" ofType:nil]];
    
    for (NSDictionary *dict in arrayData) {
        
        PlayCardData *playCardData = [PlayCardData playCardDataWithDict:dict];
        
        [self.objects addObject:playCardData];
    }
    
    // addSubViews
    
    [self.tableView registerClass:[LocationCell class] forCellReuseIdentifier:[LocationCell cellId]];
    [self.tableView registerClass:[PlayCardCell class] forCellReuseIdentifier:[PlayCardCell cellId]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Event response



#pragma mark - Private methods



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.objects[section] contents] count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [self.objects[section] header];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    if ([[self.objects[section] header] isEqual:@"本地人玩"]) {
        
        LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:[LocationCell cellId] forIndexPath:indexPath];
        
        PlayCardData *playCardData = self.objects[section];
        cell.location = playCardData.playCards[row];
        
        return cell;
    } else {
        
        PlayCardCell *cell = (PlayCardCell *)[tableView dequeueReusableCellWithIdentifier:[PlayCardCell cellId] forIndexPath:indexPath];
        
        PlayCardData *playCardData = self.objects[section];
        cell.playCard = playCardData.playCards[row];
        
        return cell;
    }
}


#pragma mark - UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlayCardData *play = self.objects[indexPath.section];
    Location *loc = play.playCards[indexPath.row];
    if (loc) {
        //self.parentViewController.title = loc.itemName;
        //        self.parentViewController.tabBarItem.title = @"评论";
        
        [Tool pushLocationDetail:loc andNavController:self.navigationController];
    }
}


#pragma mark - CustomDelegate



#pragma mark - Getters & Setters



@end





