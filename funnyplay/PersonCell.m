//
//  PersonCell.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PersonCell.h"
#import "PersonCellModel.h"
#import "UIColor+Util.h"

#define kSubviewsPadding       10

@implementation PersonCell

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


#pragma mark - Private methods

- (void)_initSubviews {
    
    self.avatarImageView = [UIImageView new];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.avatarImageView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    self.nameLabel.userInteractionEnabled = YES;
    self.nameLabel.textColor = [UIColor nameColor];
    [self.contentView addSubview:self.nameLabel];
    
    //vipView
    
    self.descLabel = [UILabel new];
    self.descLabel.font = [UIFont systemFontOfSize:12];
    self.descLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    self.descLabel.numberOfLines = 0;
    [self.contentView addSubview:self.descLabel];
}

- (void)_setLayout {
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(kSubviewsPadding);
        make.left.equalTo(self.contentView).with.offset(15);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView);
        make.left.equalTo(self.avatarImageView.right).with.offset(kSubviewsPadding);
        make.right.equalTo(self.contentView).with.offset(-kSubviewsPadding * 3);
        make.height.mas_equalTo(20);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.bottom).with.offset(kSubviewsPadding);
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView).with.offset(-kSubviewsPadding * 2);
        make.bottom.equalTo(self.avatarImageView);
    }];
}


#pragma mark - Getters & Setters

- (void)setPersonCellModel:(PersonCellModel *)personCellModel {
    
    _personCellModel = personCellModel;
    
    self.avatarImageView.image = [UIImage imageNamed:self.personCellModel.imageName];
    self.nameLabel.text = self.personCellModel.username;
    self.isVipImageView.hidden = self.personCellModel.isVip;
    self.descLabel.text = self.personCellModel.descString;
}



@end
