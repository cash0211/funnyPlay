//
//  PlayCard.h
//  funnyplay
//
//  Created by cash on 15-3-30.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayCard : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *desc;

- (id)initWithDict:(NSDictionary *)dict;
+ (id)playCardWithDict:(NSDictionary *)dict;


@end
