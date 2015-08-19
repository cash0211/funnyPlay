//
//  AFFPClient.h
//  funnyplay
//
//  Created by cash on 15-6-24.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFFPClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
- (instancetype)initWithBaseURL:(NSURL *)url;

@end
