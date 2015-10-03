//
//  Flowground.h
//  funnyplay
//
//  Created by cash on 15-5-25.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flowground : NSObject

@property (nonatomic, assign) int64_t locationID;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSURL *iconURL;
@property (nonatomic, assign) int64_t userID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pubDate;
//@property (nonatomic, assign) bool vip;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSURL *smallImgURL;
@property (nonatomic, strong) NSURL *bigImgURL;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, assign) NSUInteger appClient;
@property (nonatomic, assign) NSUInteger viewCount;


@property (nonatomic, strong) NSMutableArray *likeList;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)flowgroundWithDict:(NSDictionary *)dict;


@end
