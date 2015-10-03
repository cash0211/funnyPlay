//
//  FlowgroundCell.m
//  funnyplay
//
//  Created by cash on 15-8-29.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FlowgroundCell.h"
#import "Flowground.h"
#import "Tool.h"

@implementation FlowgroundCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self initSubviews];
    }
    
    return self;
}

- (void)initSubviews
{
    // 1.头像
    _iconView = [UIImageView new];
    _iconView.contentMode = UIViewContentModeScaleAspectFit;
    _iconView.userInteractionEnabled = YES;
    [_iconView setCornerRadius:5.0];
    [self.contentView addSubview:_iconView];
    
    // 2.名字
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    _nameLabel.userInteractionEnabled = YES;
    _nameLabel.textColor = [UIColor nameColor];
    [self.contentView addSubview:_nameLabel];

    //vipView
    
    // 3.时间
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    [self.contentView addSubview:_timeLabel];
    
    
    // 4.内容
    _contentLabel = [UILabel new];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_contentLabel];
    
    
    // 5.图片
    _uploadimageView = [UIImageView new];
    [self.contentView addSubview:_uploadimageView];
    
    // 6.来源
    _sourceLabel = [UILabel new];
    _sourceLabel.font = [UIFont systemFontOfSize:12];
    _sourceLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    [self.contentView addSubview:_sourceLabel];
    
    // 7.分享
    _shareBtn = [UIButton new];
    [self.contentView addSubview:_shareBtn];
    
    // 8.评论
    _commentBtn = [UIButton new];
    [self.contentView addSubview:_commentBtn];
    
    // 9.赞
    _likeBtn = [UIButton new];
    [self.contentView addSubview:_likeBtn];
    
    // 10.赞列表
    _likeListLabel = [UILabel new];
    _likeListLabel.numberOfLines = 0;
    _likeListLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _likeListLabel.font = [UIFont systemFontOfSize:12];
    _likeListLabel.userInteractionEnabled = YES;
    _likeListLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    [self.contentView addSubview:_likeListLabel];
}

- (void)setFlowground:(Flowground *)flowground {
    
    _flowground = flowground;
    
    [self settingData];
    [self setLayout];
}

- (void)settingData {
    
    //SDWebImage请求图片
//    [_iconView loadIcon:_flowground.iconURL];
    _iconView.image = [UIImage imageNamed:_flowground.icon];
    
    _nameLabel.text = _flowground.name;
    
    /*
     if (weibo.vip) {
     _nameLabel.textColor = [UIColor redColor];
     }
     
     _vipView.hidden = !weibo.vip;
     */
    
    //计算时间
//    _timeLabel.text = [Tool intervalSinceNow:_flowground.pubDate];
    _timeLabel.text = [Tool pubTime:_flowground.pubDate];
    
    _contentLabel.attributedText = [Tool emojiStringFromRawString:_flowground.content];
    
    //OSC没在这里设置
    if (_flowground.image) {
        _uploadimageView.hidden = NO;
        
        _uploadimageView.image = [UIImage imageNamed:_flowground.image];
    } else {
        
        _uploadimageView.hidden = YES;
    }
    
    
//    _sourceLabel.attributedText = [Tool getAppclient:_flowground.appClient];
    _sourceLabel.text = [NSString stringWithFormat:@"来自%@", _flowground.source];
    
    
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

- (void)setLayout
{
    for (UIView *view in [self.contentView subviews]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(_iconView, _nameLabel, _timeLabel, _contentLabel, _uploadimageView, _sourceLabel, _likeListLabel,_shareBtn, _commentBtn, _likeBtn);
    
    // V  NSLayoutFormatAlignAllLeft -- 使得下面所有元素与icon对齐
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_iconView(60)]-10-[_contentLabel]-<=10-[_uploadimageView(100)]-<=10-[_sourceLabel]-<=10-[_likeListLabel]-10-[_shareBtn]-10-|"
                                      
                                                                             options:NSLayoutFormatAlignAllLeft
                                                                             metrics:nil views:viewsDict]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_uploadimageView(100)]"
                                      
                                                                             options:0
                                                                             metrics:nil views:viewsDict]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_iconView(60)]-10-[_nameLabel]-10-|"
                                      
                                                                             options:0
                                                                             metrics:nil views:viewsDict]];
    
    /*
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_contentLabel]-10-|"
                                      
                                                                             options:0
                                                                             metrics:nil views:viewsDict]];
    */
     
    //效果同 ↑↑↑↑↑
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual
                                                                    toItem:_nameLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_nameLabel]-10-[_timeLabel]"
                                      
                                                                             options:NSLayoutFormatAlignAllLeft                                                                             metrics:nil views:viewsDict]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_shareBtn]-10-[_commentBtn]-10-[_likeBtn]-10-|"
                                      
                                                                             options:0
                                                                             metrics:nil views:viewsDict]];
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
