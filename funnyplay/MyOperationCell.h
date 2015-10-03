//
//  MyOperationCell.h
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyOperationModel;

@interface MyOperationCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *itemLabel;

@property (strong, nonatomic) MyOperationModel *myOperationModel;

+ (instancetype)myOperationCell;
+ (NSString *)cellId;

@end
