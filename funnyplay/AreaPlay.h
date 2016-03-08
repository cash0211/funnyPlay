//
//  AreaPlay.h
//  funnyplay
//
//  Created by cash on 15-3-29.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Location;

@interface AreaPlay : NSObject

//area：玄武，鼓楼...
//对应每个area的玩的地点
@property (nonatomic, copy) NSString *area;
@property (nonatomic, strong) NSArray *areaPlays;

@property (nonatomic, strong) NSMutableArray *locations;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)areaPlayWithDict:(NSDictionary *)dict;

@end
