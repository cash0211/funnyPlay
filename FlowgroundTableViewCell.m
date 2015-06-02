//
//  FlowgroundTableViewCell.m
//  funnyplay
//
//  Created by cash on 15-5-25.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FlowgroundTableViewCell.h"
#import "Flowground.h"
#import "FlowgroundFrame.h"


@interface FlowgroundTableViewCell  () {
    
    UIImageView *_iconView;
    UILabel *_nameLabel;
//    UIImageView *_vipView;
    UILabel *_timeLabel;
    
    UILabel *_contentLabel;
    UIImageView *_imageView;
    UILabel *_sourceLabel;
    
    
    UIButton *_shareBtn;
    UIButton *_commentBtn;
    UIButton *_likeBtn;
    
}

@end

@implementation FlowgroundTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // 1.头像
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
        
        // 2.名字
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kNameFont;
        [self.contentView addSubview:_nameLabel];
        
        // 3.vip
//        _vipView = [[UIImageView alloc] init];
//        _vipView.image = [UIImage imageNamed:@"vip.jpg"];
//        [self.contentView addSubview:_vipView];
        
        // 3.时间
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = kTimeFont;
        [self.contentView addSubview:_timeLabel];
        
        
        // 4.内容
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = kContentFont;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
        
        // 5.图片
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        
        // 6.来源
        _sourceLabel = [[UILabel alloc] init];
        _sourceLabel.font = kSourceFont;
        [self.contentView addSubview:_sourceLabel];

        // 7.分享
        _shareBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_shareBtn];
        
        // 8.评论
        _commentBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_commentBtn];
        
        // 9.赞
        _likeBtn = [[UIButton alloc] init];
        [self.contentView addSubview:_likeBtn];
        
    }
    
    return self;
}

- (void)setFlowgroundFrame:(FlowgroundFrame *)flowgroundFrame {
    
    _flowgroundFrame = flowgroundFrame;
    
    [self settingData];
    
    //要拿到数据才知道位置，所以要在set方法里面做
    [self settingFrame];
}

- (void)settingFrame {
    
    _iconView.frame = _flowgroundFrame.iconViewF;
    
    _nameLabel.frame = _flowgroundFrame.nameLabelF;
    
//    _vipView.frame = _weiboFrame.vipViewF;
    
    _timeLabel.frame = _flowgroundFrame.timeLabelF;
    
    
    
    _contentLabel.frame = _flowgroundFrame.contentLabelF;
    
    if (_flowgroundFrame.flowground.image) {
        
        _imageView.frame = _flowgroundFrame.imageViewF;
        
    }
    
    _sourceLabel.frame = _flowgroundFrame.sourceLabelF;
    
    
    _shareBtn.frame = _flowgroundFrame.shareBtnF;
    
    _commentBtn.frame = _flowgroundFrame.commentBtnF;
    
    _likeBtn.frame = _flowgroundFrame.likeBtnF;
    
}

- (void)settingData {
    
    Flowground *flow = _flowgroundFrame.flowground;
    
    _iconView.image = [UIImage imageNamed:flow.icon];
    
    _nameLabel.text = flow.name;
    
    /*
    if (weibo.vip) {
        _nameLabel.textColor = [UIColor redColor];
    }
    
    _vipView.hidden = !weibo.vip;
    */
    
    _timeLabel.text = flow.time;
    
    
    
    _contentLabel.text = flow.content;
    
    if (flow.image) {
        _imageView.hidden = NO;
        
        _imageView.image = [UIImage imageNamed:flow.image];
    } else {
        
        _imageView.hidden = YES;
    }
    
    _sourceLabel.text = [NSString stringWithFormat:@"来自%@", flow.source];
    
    
//    _shareBtn.imageView.image = [UIImage imageNamed:@"share"];
    [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [_shareBtn setImage:[UIImage imageNamed:@"share_2"] forState:UIControlStateHighlighted];
    [_shareBtn addTarget:self action:@selector(clickForShare) forControlEvents:UIControlEventTouchUpInside];
    
    [_commentBtn setImage:[UIImage imageNamed:@"commentBtn"] forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(clickForComment) forControlEvents:UIControlEventTouchUpInside];
    
    [_likeBtn setImage:[UIImage imageNamed:@"likeBtn"] forState:UIControlStateNormal];
    [_likeBtn addTarget:self action:@selector(clickForLike) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) clickForShare {
    
    NSLog(@"share");
}

- (void) clickForComment {
    
    NSLog(@"comment");
}

- (void) clickForLike {
    
     NSLog(@"like");
}

+(NSString *)ID {
    
    return @"flowgroundCell";
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


























