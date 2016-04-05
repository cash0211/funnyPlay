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


#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor whiteColor];
    
    [self _initSubviews];
    [self _setLayout];
    
    return self;
}

- (void)awakeFromNib {
    
}


#pragma mark - Event response

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark - Public methods

+ (NSString *)cellId {
    
    return @"PlayCardCell";
}


#pragma mark - Private methods

- (void)_initSubviews {
    
}

- (void)_setLayout {
    
}


#pragma mark - CustomDelegate



#pragma mark - Getters & Setters

- (void)setPlayCard:(PlayCard *)playCard {
    
    _playCard = playCard;
    
    _itemImageView.image = [UIImage imageNamed:_playCard.imageName];
    _itemName.text = _playCard.itemName;
    _itemDesc.text = _playCard.desc;
}


@end
