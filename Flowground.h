//
//  Flowground.h
//  funnyplay
//
//  Created by cash on 15-5-25.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flowground : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
//@property (nonatomic, assign) bool vip;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *source;


- (id) initWithDict:(NSDictionary *)dict;
+ (id) flowgroundWithDict:(NSDictionary *)dict;


@end
