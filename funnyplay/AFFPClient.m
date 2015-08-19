//
//  AFFPClient.m
//  funnyplay
//
//  Created by cash on 15-6-24.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "AFFPClient.h"

static NSString * const AFFPBaseURLString = @"https://api.app.net/";

@implementation AFFPClient

+ (instancetype)sharedClient {
    static AFFPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFFPClient alloc] initWithBaseURL:[NSURL URLWithString:AFFPBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

@end
