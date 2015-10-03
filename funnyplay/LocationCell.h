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

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UITextView *itemDesc;
@property (weak, nonatomic) IBOutlet UILabel *itemLoc;
@property (weak, nonatomic) IBOutlet UILabel *itemDistance;

@property (strong, nonatomic) Location *location;

+ (instancetype)locationCell;
+ (NSString *)cellId;

@end
