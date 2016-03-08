//
//  PlayCardData.m
//  funnyplay
//
//  Created by cash on 15-3-30.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PlayCardData.h"
#import "PlayCard.h"
#import "Location.h"

@implementation PlayCardData

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        _header = dict[@"header"];
        _contents = dict[@"contents"];
        _playCards = [[NSMutableArray alloc] init];
        
        if ([_header isEqual:@"本地人玩"]) {
            
            for (NSDictionary *dict2 in _contents) {
                
                Location *location = [Location locationWithDict:dict2];
                [_playCards addObject:location];
            }
            
        } else {
            
            for (NSDictionary *dict3 in _contents) {
                
                PlayCard *playCard = [PlayCard playCardWithDict:dict3];
                [_playCards addObject:playCard];
            }
        }
    }
    
    return self;
}

+ (id)playCardDataWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

@end
