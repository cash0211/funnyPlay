//
//  Flowground.m
//  funnyplay
//
//  Created by cash on 15-5-25.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "Flowground.h"

@implementation Flowground


- (id)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        _icon = dict[@"icon"];
        _name = dict[@"name"];
//        _vip = [dict[@"vip"] boolValue];
        _time = dict[@"time"];
        _content = dict[@"content"];
        _image = dict[@"image"];
        _source = dict[@"source"];

    }
    
    return self;
}

+ (id)flowgroundWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


@end
