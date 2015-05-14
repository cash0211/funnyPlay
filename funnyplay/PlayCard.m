//
//  PlayCard.m
//  funnyplay
//
//  Created by cash on 15-3-30.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PlayCard.h"

@implementation PlayCard

- (id)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        _imageName = dict[@"imageName"];
        _itemName = dict[@"itemName"];
        _desc = dict[@"desc"];
    }
    
    return self;
}

+ (id)playCardWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

@end
