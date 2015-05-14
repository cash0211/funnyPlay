//
//  NearbyCell.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "NearbyCell.h"
#import "Nearby.h"

@implementation NearbyCell



+ (id)nearbyCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"NearbyCell" owner:nil options:nil][0];
}

- (void)setNearby:(Nearby *)nearby {
    
    _nearby = nearby;
    
    self.imageView.image = [UIImage imageNamed:_nearby.imageName];
    self.itemName.text = _nearby.itemName;
    self.itemDesc.text = _nearby.desc;
    self.itemLoc.text = _nearby.loc;
    self.itemDistance.text = [NSString stringWithFormat:@"%.1f", _nearby.distance];
    
}


+ (NSString *)cellId {
    return @"NearbyCell";
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
