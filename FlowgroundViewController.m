//
//  FlowgroundViewController.m
//  funnyplay
//
//  Created by cash on 15-5-21.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FlowgroundViewController.h"
#import "Flowground.h"
#import "FlowgroundFrame.h"
#import "FlowgroundTableViewCell.h"

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
        FlowgroundFrame *fFrame = [FlowgroundFrame FlowgroundFramewithflow:f];
        
        [_dataArray addObject:fFrame];
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FlowgroundTableViewCell *flowCell = [tableView dequeueReusableCellWithIdentifier:[FlowgroundTableViewCell ID]];
    
    if (flowCell == nil) {
        flowCell = [[FlowgroundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FlowgroundTableViewCell ID]];
    }
    
    flowCell.flowgroundFrame = _dataArray[indexPath.row];
    
    return flowCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [_dataArray[indexPath.row] height];
}




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













































































































