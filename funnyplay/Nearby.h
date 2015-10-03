//
//  Nearby.h
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Nearby : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *loc;
@property (nonatomic, assign) CGFloat distance;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)nearbyWithDict:(NSDictionary *)dict;

@end
