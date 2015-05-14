//
//  Nearby.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "Nearby.h"

@implementation Nearby

- (id)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        _imageName = dict[@"imageName"];
        _itemName = dict[@"itemName"];
        _desc = dict[@"desc"];
        _loc = dict[@"loc"];
        _distance = [dict[@"distance"] floatValue];
    }
    
    return self;
}

+ (id)nearbyWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


@end
