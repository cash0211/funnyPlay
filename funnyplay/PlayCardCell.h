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

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UITextView *itemDesc;

@property (nonatomic, strong) PlayCard *playCard;

+ (instancetype)playCardCell;
+ (NSString *)cellId;

@end
