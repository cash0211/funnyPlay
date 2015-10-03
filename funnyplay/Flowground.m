//
//  Flowground.m
//  funnyplay
//
//  Created by cash on 15-5-25.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "Flowground.h"

@implementation Flowground

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        _icon = dict[@"icon"];
        _name = dict[@"name"];
//        _vip = [dict[@"vip"] boolValue];
        _pubDate = dict[@"time"];
        _content = dict[@"content"];
        _image = dict[@"image"];
        _source = dict[@"source"];
        
    }
    
    return self;
}

+ (instancetype)flowgroundWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


@end
