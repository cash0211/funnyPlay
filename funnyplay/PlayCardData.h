//
//  PlayCardData.h
//  funnyplay
//
//  Created by cash on 15-3-30.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayCardData : NSObject

@property (nonatomic, copy) NSString *header;
@property (nonatomic, strong) NSArray *contents;

@property (nonatomic, strong) NSMutableArray *playCards;

- (id)initWithDict:(NSDictionary *)dict;
+ (id)playCardDataWithDict:(NSDictionary *)dict;

@end
