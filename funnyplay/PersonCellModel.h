//
//  PersonCellModel.h
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonCellModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, assign) BOOL isVip;
@property (nonatomic, copy) NSString *descString;

- (instancetype)defaultInit;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)personCellWithDict:(NSDictionary *)dict;

@end
