//
//  PlayCardCell.m
//  funnyplay
//
//  Created by cash on 15-3-30.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PlayCardCell.h"
#import "PlayCard.h"

@implementation PlayCardCell

+ (instancetype)playCardCell {
    return [[NSBundle mainBundle] loadNibNamed:@"PlayCard" owner:nil options:nil][0];
}

- (void)setPlayCard:(PlayCard *)playCard {
    
    _playCard = playCard;
    
    _itemImageView.image = [UIImage imageNamed:_playCard.imageName];
    _itemName.text = _playCard.itemName;
    _itemDesc.text = _playCard.desc;
}


+ (NSString *)cellId {
    
    return @"PlayCardCell";
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
