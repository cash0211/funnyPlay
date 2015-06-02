//
//  FlowgroundViewController.h
//  funnyplay
//
//  Created by cash on 15-5-21.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowgroundViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *flowTable;

@end
