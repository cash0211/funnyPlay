//
//  Location.m
//  funnyplay
//
//  Created by cash on 15-3-17.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "Location.h"
#import "AFFPClient.h"

@implementation Location

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

+ (id)locationWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

+ (NSURLSessionDataTask *)globalTimelineLocationsWithBlock:(void (^)(NSArray *locations, NSError *error))block {
    
    return [[AFFPClient sharedClient] GET:@"stream/0/posts/stream/global" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSArray *locationsFromResponse = [JSON valueForKeyPath:@"data"];
        NSMutableArray *mutablelocations = [NSMutableArray arrayWithCapacity:[locationsFromResponse count]];
        for (NSDictionary *attributes in locationsFromResponse) {
            Location *loc = [[Location alloc] initWithDict:attributes];
            [mutablelocations addObject:loc];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablelocations], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end











































