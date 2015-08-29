//
//  FlowgroundFrame.m
//  funnyplay
//
//  Created by cash on 15-5-25.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FlowgroundFrame.h"
#import "Flowground.h"

@implementation FlowgroundFrame

- (void)setFlowground:(Flowground *)flowground {
    
    _flowground = flowground;
    
    //头像
    CGFloat iconX = kCellBorder;
    CGFloat iconY = kCellBorder;
    _iconViewF = CGRectMake(iconX, iconY, kIconSize, kIconSize);
    
    //名字
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + kCellBorder;
    CGFloat nameY = iconY;
//    CGSize nameSize = [_flowground.name sizeWithFont:kNameFont];
    CGSize nameSize = [_flowground.name sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15]}];
    _nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    //vip
//    CGFloat vipX = CGRectGetMaxX(_nameLabelF) + kCellBorder;
//    CGFloat vipY = nameY;
//    _vipViewF = CGRectMake(vipX, vipY, kVipsize, kVipsize);
    
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_nameLabelF) + kCellBorder;
//    CGSize timeSize = [_flowground.time sizeWithFont:kTimeFont];
    CGSize timeSize = [_flowground.time sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15]}];
    _timeLabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    
    //文本
    CGFloat contentX = kCellBorder;
    CGFloat max = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + kCellBorder;
    CGFloat contentY = max;
    CGSize contentSize = [_flowground.content sizeWithFont:kContentFont constrainedToSize:CGSizeMake(320 - 2 * kCellBorder, MAXFLOAT)];
//    CGRect contentRect = [_flowground.content boundingRectWithSize:CGSizeMake(320 - 2 * kCellBorder, MAXFLOAT) options:NSStringDrawingUsesDeviceMetrics attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]} context:nil];
    _contentLabelF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    //图片
    if (_flowground.image) {
        CGFloat imageX = kCellBorder;
        CGFloat imageY = CGRectGetMaxY(_contentLabelF) + kCellBorder;
        _imageViewF = CGRectMake(imageX, imageY, kimageSize, kimageSize);
        
        _height = CGRectGetMaxY(_imageViewF) + kCellBorder;
    } else {
        
        _height = CGRectGetMaxY(_contentLabelF) + kCellBorder;
    }
    
    //来源
    CGFloat sourceX = kCellBorder;
    CGFloat sourceY = _height;
    NSString *sourceString = [NSString stringWithFormat:@"来自%@", _flowground.source];
//    CGSize sourceSize = [sourceString sizeWithFont:kSourceFont];
    CGSize sourceSize = [sourceString sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15]}];
    _sourceLabelF = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    //分享
    CGFloat shareX = kCellBorder;
    CGFloat shareY = CGRectGetMaxY(_sourceLabelF) + kCellBorder;
    _shareBtnF = CGRectMake(shareX, shareY, kfixedWSize, kfixedHSize);
    
    //评论
    CGFloat commentX = CGRectGetMaxX(_shareBtnF) + 100;
    CGFloat commentY = shareY;
    _commentBtnF = CGRectMake(commentX, commentY, kfixedWSize, kfixedHSize);
    
    //赞
    CGFloat likeX = CGRectGetMaxX(_commentBtnF) + 20;
    CGFloat likeY = shareY;
    _likeBtnF = CGRectMake(likeX, likeY, kfixedWSize, kfixedHSize);
    

    _height = CGRectGetMaxY(_likeBtnF) + kCellBorder;
}

- (id)initWithFlowgroundFrame:(Flowground *)flowground {
    
    if (self = [super init]) {
        self.flowground = flowground;  //这里必须要用点语法来触发set方法，不然会没有数据。
    }
    
    return self;
}

+(id) FlowgroundFramewithflow:(Flowground *)flowground {
    
    return [[self alloc] initWithFlowgroundFrame:flowground];
}


@end


















