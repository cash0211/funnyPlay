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

@interface FlowgroundViewController () {
    
    NSMutableArray *_dataArray;
}

@end

@implementation FlowgroundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data.plist" ofType:nil]];
    
    for (NSDictionary *dict in dataArray) {
        
        Flowground *f = [Flowground flowgroundWithDict:dict];
        
        [_dataArray addObject:f];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FlowgroundCell *flowCell = [tableView dequeueReusableCellWithIdentifier:[FlowgroundCell ID]];
    
    if (!flowCell) {
        flowCell = [[FlowgroundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FlowgroundCell ID]];
    }
    
    flowCell.flowground = _dataArray[indexPath.row];
    
    return flowCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    return [_dataArray[indexPath.row] height];
    
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end













































































































