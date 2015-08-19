//
//  LocationCell.m
//  funnyplay
//
//  Created by cash on 15-3-17.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "LocationCell.h"
#import "Location.h"


#import <UIImageView+AFNetworking.h>

@implementation LocationCell


+ (id)locationCell {
    
    return [[NSBundle mainBundle] loadNibNamed:@"LocationCell" owner:nil options:nil][0];
}

- (void)setLocation:(Location *)location {
    
    _location = location;
    
    self.imageView.image = [UIImage imageNamed:location.imageName];
    //异步下载loc图片
//    [self.imageView setImageWithURL:location.avatarImageURL placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
    self.itemName.text = location.itemName;
    self.itemDesc.text = location.desc;
    self.itemLoc.text = location.loc;
    self.itemDistance.text = [NSString stringWithFormat:@"%.1f", location.distance];
    
}

+ (NSString *)cellId {
    
    return @"LocationCell";
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
