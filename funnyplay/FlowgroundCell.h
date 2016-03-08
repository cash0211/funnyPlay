//
//  FlowgroundCell.h
//  funnyplay
//
//  Created by cash on 15-8-29.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Flowground;

@interface FlowgroundCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *vipView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *uploadimageView;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UILabel *likeListLabel;

@property (nonatomic, strong) Flowground *flowground;

+ (NSString *)ID;

@end
