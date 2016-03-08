//
//  PersonCell.h
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonCellModel;

@interface PersonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *personImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *isVipImageView;
@property (weak, nonatomic) IBOutlet UILabel *descString;
@property (weak, nonatomic) IBOutlet UILabel *defaultString;

@property (strong, nonatomic) PersonCellModel *personCellModel;

+ (instancetype)personCell;
+ (NSString *)cellId;

@end
