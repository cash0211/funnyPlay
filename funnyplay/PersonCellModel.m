//
//  PersonCellModel.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PersonCellModel.h"

@implementation PersonCellModel

- (id)defaultInit {
    
    _imageName = @"appicon.png";
    
    return self;
}

- (id)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        _imageName = dict[@"imageName"];
        _username = dict[@"userName"];
        _isVip = [dict[@"isVip"] boolValue];
        _descString = dict[@"descString"];
    }
    
    return self;
}

+ (id)personCellWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

@end
