//
//  PlayCardCell.h
//  funnyplay
//
//  Created by cash on 15-3-30.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayCard;

@interface PlayCardCell : UITableViewCell

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel     *itemName;
@property (nonatomic, strong) UITextView  *itemDesc;

@property (nonatomic, strong) PlayCard    *playCard;

+ (NSString *)cellId;

@end
