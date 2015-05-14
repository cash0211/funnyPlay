//
//  MyOperationCell.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "MyOperationCell.h"
#import "MyOperationModel.h"

@implementation MyOperationCell

+ (id)myOperationCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"MyOperationCell" owner:nil options:nil][0];
}

- (void)setMyOperationModel:(MyOperationModel *)myOperationModel {
    
    _myOperationModel = myOperationModel;
    
    self.itemLabel.text = _myOperationModel.btnName;
}

+ (NSString *)cellId {
    
    return @"MyOperationCell";
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
