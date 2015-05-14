//
//  NearbyCell.h
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Nearby;

@interface NearbyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemName;
@property (weak, nonatomic) IBOutlet UITextView *itemDesc;
@property (weak, nonatomic) IBOutlet UILabel *itemLoc;
@property (weak, nonatomic) IBOutlet UILabel *itemDistance;

@property (nonatomic, strong) Nearby *nearby;

+ (id)nearbyCell;
+ (NSString *)cellId;

@end
