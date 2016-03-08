//
//  UIImageView+Util.m
//  iosapp
//
//  Created by chenhaoxiang on 11/11/14.
//  Copyright (c) 2014 oschina. All rights reserved.
//

#import "UIImageView+Util.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Util)

- (void)loadIcon:(NSURL *)iconURL
{
    [self sd_setImageWithURL:iconURL placeholderImage:[UIImage imageNamed:@"default-icon"] options:0];
}

@end
