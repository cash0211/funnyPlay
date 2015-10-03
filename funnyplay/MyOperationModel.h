//
//  MyOperationModel.h
//  funnyplay
//
//  Created by cash on 15-3-23.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOperationModel : NSObject

@property (nonatomic, copy) NSString *btnName;

- (instancetype)initWithString:(NSString *)btnName;

@end
