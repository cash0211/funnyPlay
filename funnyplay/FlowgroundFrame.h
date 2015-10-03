//
//  FlowgroundFrame.h
//  funnyplay
//
//  Created by cash on 15-5-25.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//



//边框
#define kCellBorder 10
//头像
#define kIconSize 60
//vip
#define kVipsize 20
//图片大小
#define kimageSize 100
//固定按钮大小
#define kfixedWSize 40
#define kfixedHSize 30

//font
#define kNameFont [UIFont systemFontOfSize:15]
#define kTimeFont [UIFont systemFontOfSize:12]
#define kSourceFont [UIFont systemFontOfSize:12]
#define kContentFont [UIFont systemFontOfSize:15]


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Flowground;

@interface FlowgroundFrame : NSObject

@property (nonatomic, assign,readonly) CGRect iconViewF;
@property (nonatomic, assign,readonly) CGRect nameLabelF;
//@property (nonatomic, assign,readonly) CGRect vipViewF;
@property (nonatomic, assign,readonly) CGRect timeLabelF;
@property (nonatomic, assign,readonly) CGRect contentLabelF;
@property (nonatomic, assign,readonly) CGRect imageViewF;
@property (nonatomic, assign,readonly) CGRect sourceLabelF;

//内容固定不变，只变位置
@property (nonatomic, assign, readonly) CGRect shareBtnF;
@property (nonatomic, assign, readonly) CGRect likeBtnF;
@property (nonatomic, assign, readonly) CGRect commentBtnF;


@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) Flowground *flowground;

- (instancetype)initWithFlowgroundFrame:(Flowground *)flowground;
+ (instancetype)FlowgroundFramewithflow:(Flowground *)flowground;

@end


























