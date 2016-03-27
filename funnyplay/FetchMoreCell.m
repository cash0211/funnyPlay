//
//  FetchMoreCell.m
//  funnyplay
//
//  Created by cash on 15-8-28.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FetchMoreCell.h"

@interface FetchMoreCell ()

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end

@implementation FetchMoreCell

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _status = LastCellStatusNotVisible;
        
        [self setLayout];
    }
    
    return self;
}

- (void)setStatus:(LastCellStatus)status
{
    if (status == LastCellStatusLoading) {
        [_indicator startAnimating];
        _indicator.hidden = NO;
    } else {
        [_indicator stopAnimating];
        _indicator.hidden = YES;
    }
    
    self.textLabel.text = @[
                            @"",
                            @"点击查看更多",
                            @"",
                            ][status];
    
    _status = status;
}

- (void)setLayout
{
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont boldSystemFontOfSize:14];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin  | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _indicator.color = [UIColor colorWithRed:54/255 green:54/255 blue:54/255 alpha:1.0];
    _indicator.center = self.center;
    [self.contentView addSubview:_indicator];
}


@end








