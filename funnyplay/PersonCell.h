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

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UIImageView *isVipImageView;
@property (nonatomic, strong) UILabel     *descLabel;

@property (nonatomic, strong) PersonCellModel *personCellModel;

@end
