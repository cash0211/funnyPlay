//
//  LocationCell.h
//  funnyplay
//
//  Created by cash on 15-3-17.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Location;

@interface LocationCell : UITableViewCell

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel     *itemName;
@property (nonatomic, strong) UITextView  *itemDesc;
@property (nonatomic, strong) UILabel     *itemLoc;
@property (nonatomic, strong) UILabel     *itemDistance;
@property (nonatomic, strong) Location    *location;

+ (NSString *)cellId;

@end
