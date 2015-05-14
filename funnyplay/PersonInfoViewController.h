//
//  PersonInfoViewController.h
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *personInfoTable;

@property (nonatomic, retain) NSArray *settings;
@property (nonatomic, retain) NSMutableDictionary *settingInSections;

@end
 