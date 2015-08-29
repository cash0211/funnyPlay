//
//  FetchMoreCell.h
//  funnyplay
//
//  Created by cash on 15-8-28.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LastCellStatus)
{
    LastCellStatusNotVisible,
    LastCellStatusMore,
    LastCellStatusLoading,
};

@interface FetchMoreCell : UITableViewCell

@property (nonatomic, assign) LastCellStatus status;

@end
