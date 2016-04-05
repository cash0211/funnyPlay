//
//  LocationCell.m
//  funnyplay
//
//  Created by cash on 15-3-17.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "LocationCell.h"
#import "Location.h"

#define kSubviewsPadding       10

@implementation LocationCell


#pragma mark - Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
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


#pragma mark - Event response

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark - Public methods

+ (NSString *)cellId {
    
    return @"LocationCell";
}


#pragma mark - Private methods

- (void)_initSubviews {
    
    UIImageView *itemImageView = [UIImageView new];
    itemImageView.contentMode = UIViewContentModeScaleAspectFit;
    itemImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:itemImageView];
    self.itemImageView = itemImageView;
    
    UILabel *itemName = [UILabel new];
    itemName.font = [UIFont systemFontOfSize:15];
    itemName.numberOfLines = 0;
    itemName.userInteractionEnabled = YES;
    [self.contentView addSubview:itemName];
    self.itemName = itemName;
    
    UITextView *itemDesc = [UITextView new];
    itemDesc.font = [UIFont systemFontOfSize:12];
    itemDesc.userInteractionEnabled = NO;
    [self.contentView addSubview:itemDesc];
    self.itemDesc = itemDesc;
    
    UILabel *itemLoc = [UILabel new];
    itemLoc.font = [UIFont systemFontOfSize:10];
    itemLoc.userInteractionEnabled = YES;
    [self.contentView addSubview:itemLoc];
    self.itemLoc = itemLoc;
    
    UILabel *itemDistance = [UILabel new];
    itemDistance.font = [UIFont systemFontOfSize:10];
    itemDistance.userInteractionEnabled = YES;
    [self.contentView addSubview:itemDistance];
    self.itemDistance = itemDistance;
}

- (void)_setLayout {
    
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.contentView).with.offset(kSubviewsPadding);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [self.itemName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemImageView);
        make.left.equalTo(self.itemImageView.right).with.offset(kSubviewsPadding);
        make.right.equalTo(self.contentView).with.offset(-kSubviewsPadding);
        make.height.mas_equalTo(20);
    }];
    
    [self.itemDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemName.bottom).with.offset(kSubviewsPadding);
        make.left.and.right.equalTo(self.itemName);
        make.bottom.equalTo(self.itemLoc.top).with.offset(-kSubviewsPadding);
    }];

    [self.itemLoc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemName);
        make.bottom.equalTo(self.contentView).with.offset(-kSubviewsPadding);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(110);
    }];

    [self.itemDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.itemLoc.right).with.offset(kSubviewsPadding * 2);
        make.bottom.equalTo(self.itemLoc);
        make.right.equalTo(self.itemName);
        make.height.mas_equalTo(15);
    }];
}


#pragma mark - CustomDelegate



#pragma mark - Getters & Setters

- (void)setLocation:(Location *)location {
    
    _location = location;
    
    _itemImageView.image = [UIImage imageNamed:location.imageName];
    _itemName.text = location.itemName;
    _itemDesc.text = location.desc;
    _itemLoc.text = location.loc;
    _itemDistance.text = [NSString stringWithFormat:@"%.1f", location.distance];
}


@end





