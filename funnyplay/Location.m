//
//  Location.m
//  funnyplay
//
//  Created by cash on 15-3-17.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        _imageName = dict[@"imageName"];
        _itemName = dict[@"itemName"];
        _desc = dict[@"desc"];
        _loc = dict[@"loc"];
        _distance = [dict[@"distance"] floatValue];
    }
    
    return self;
}

+ (instancetype)locationWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


@end











































