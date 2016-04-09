//
//  FetchMoreCell.h
//  funnyplay
//
//  Created by cash on 15-8-28.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FetchMoreCellStatus) {
    
    FetchMoreCellStatusNotVisible,
    FetchMoreCellStatusMore,
    FetchMoreCellStatusLoading,
    FetchMoreCellStatusError,
    FetchMoreCellStatusFinished,
    FetchMoreCellStatusEmpty,
};

@interface FetchMoreCell : UITableViewCell

@property (nonatomic, assign) FetchMoreCellStatus status;

@end
