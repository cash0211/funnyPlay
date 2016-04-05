//
//  FlowgroundViewController.m
//  funnyplay
//
//  Created by cash on 15-5-21.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FlowgroundViewController.h"
#import "Flowground.h"
#import "FlowgroundCell.h"

@interface FlowgroundViewController ()

@end

@implementation FlowgroundViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"流动墙";
    
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil]];
    
    for (NSDictionary *dict in dataArray) {
        
        Flowground *f = [Flowground flowgroundWithDict:dict];
        
        [self.objects addObject:f];
    }
    
    [self.tableView registerClass:[FlowgroundCell class] forCellReuseIdentifier:[FlowgroundCell cellId]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Event response


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FlowgroundCell *flowCell = [tableView dequeueReusableCellWithIdentifier:[FlowgroundCell cellId] forIndexPath:indexPath];
    
    flowCell.flowground = self.objects[indexPath.row];
    
    return flowCell;
}


#pragma mark - UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - CustomDelegate


@end





