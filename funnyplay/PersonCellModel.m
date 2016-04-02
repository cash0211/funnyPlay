//
//  PersonCellModel.m
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "PersonCellModel.h"

@implementation PersonCellModel

#pragma mark - Lifecycle

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _imageName = dict[@"imageName"];
    _username = dict[@"userName"];
    _isVip = [dict[@"isVip"] boolValue];
    _descString = dict[@"descString"];
    
    return self;
}

+ (instancetype)personCellWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}


#pragma mark - Event response



#pragma mark - Public methods



#pragma mark - Private methods



#pragma mark - CustomDelegate



#pragma mark - Getters & Setters



@end
