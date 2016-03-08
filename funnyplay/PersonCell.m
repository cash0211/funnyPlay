//
//  PersonCell.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PersonCell.h"
#import "PersonCellModel.h"

@implementation PersonCell

+ (instancetype)personCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"PersonCell" owner:nil options:nil][0];
}

- (void)setPersonCellModel:(PersonCellModel *)personCellModel {
    
    _personCellModel = personCellModel;
    
    self.personImageView.image = [UIImage imageNamed:_personCellModel.imageName];
    self.userName.text = _personCellModel.username;
    self.isVipImageView.hidden = _personCellModel.isVip;
    self.descString.text = _personCellModel.descString;
}

+ (NSString *)cellId {
    
    return @"PersonCell";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
