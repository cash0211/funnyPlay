//
//  FlowgroundTableViewCell.h
//  funnyplay
//
//  Created by cash on 15-5-25.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlowgroundFrame;

@interface FlowgroundTableViewCell : UITableViewCell

@property (nonatomic, strong) FlowgroundFrame *flowgroundFrame;

+ (NSString *)ID;

@end
