//
//  AreaPlay.m
//  funnyplay
//
//  Created by cash on 15-3-29.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "AreaPlay.h"
#import "Location.h"

@implementation AreaPlay

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        _locArea = dict[@"area"];
        _areaPlays = dict[@"areaPlays"];
        
        _locations = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict2 in _areaPlays) {
            
            Location *location = [Location locationWithDict:dict2];
            [_locations addObject:location];
        }

    }
    
    return self;
}

+ (instancetype)areaPlayWithDict:(NSDictionary *)dict {
    
   return [[self alloc] initWithDict:dict];
}


@end


















