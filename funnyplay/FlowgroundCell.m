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

#define kSubviewsPadding       10
#define kSolidButtonWidth      (self.contentView.bounds.size.width - 4 * kSubviewsPadding) / 3

@implementation FlowgroundCell


#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor whiteColor];
    
    [self _initSubviews];
    [self _setLayout];
    
    return self;
}


#pragma mark - Event response

- (void)clickForShare {
    
    NSLog(@"share");
}

- (void)clickForComment {
    
    NSLog(@"comment");
}

- (void)clickForLike {
    
    NSLog(@"like");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark - Public methods

+ (NSString *)cellId {
    
    return @"flowgroundCell";
}


#pragma mark - Private methods

- (void)_initSubviews
{
    // 1.头像
    self.avatarImageView = [UIImageView new];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.avatarImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.avatarImageView];
    
    // 2.名字
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:15];
    self.nameLabel.userInteractionEnabled = YES;
    self.nameLabel.textColor = [UIColor nameColor];
    [self.contentView addSubview:self.nameLabel];
    
    //vipView
    
    // 3.时间
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    [self.contentView addSubview:self.timeLabel];
    
    
    // 4.内容
    self.contentLabel = [UILabel new];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.contentLabel];
    
    
    // 5.图片
    self.uploadImageView = [UIImageView new];
    self.uploadImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.uploadImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.uploadImageView];
    
    // 6.来源
    self.sourceLabel = [UILabel new];
    self.sourceLabel.font = [UIFont systemFontOfSize:12];
    self.sourceLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    [self.contentView addSubview:self.sourceLabel];
    
    // 7.分享
    self.shareBtn = [UIButton new];
    [self.contentView addSubview:self.shareBtn];
    
    // 8.评论
    self.commentBtn = [UIButton new];
    [self.contentView addSubview:self.commentBtn];
    
    // 9.赞
    self.likeBtn = [UIButton new];
    [self.contentView addSubview:self.likeBtn];
    
    // 10.赞列表
    _likeListLabel = [UILabel new];
    _likeListLabel.numberOfLines = 0;
    _likeListLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _likeListLabel.font = [UIFont systemFontOfSize:12];
    _likeListLabel.userInteractionEnabled = YES;
    _likeListLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    [self.contentView addSubview:_likeListLabel];
}

- (void)_setLayout2
{
    for (UIView *view in [self.contentView subviews]) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    NSDictionary *viewsDict = NSDictionaryOfVariableBindings(_avatarImageView, _nameLabel, _timeLabel, _contentLabel, _uploadImageView, _sourceLabel, _likeListLabel, _shareBtn, _commentBtn, _likeBtn);
    
    // V  NSLayoutFormatAlignAllLeft -- 使得下面所有元素与icon对齐
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_avatarImageView(60)]-10-[_contentLabel]-<=10-[_uploadImageView(100)]-<=10-[_sourceLabel]-<=10-[_likeListLabel]-10-[_shareBtn]-10-|"
                                      
                                                                             options:NSLayoutFormatAlignAllLeft
                                                                             metrics:nil views:viewsDict]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_uploadImageView(100)]"
                                      
                                                                             options:0
                                                                             metrics:nil views:viewsDict]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_avatarImageView(60)]-10-[_nameLabel]-10-|"
                                                                             options:0
                                                                             metrics:nil views:viewsDict]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentLabel  attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.nameLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_nameLabel]-10-[_timeLabel]"
                                      
                                                                             options:NSLayoutFormatAlignAllLeft                                                                             metrics:nil views:viewsDict]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_shareBtn]-10-[_commentBtn]-10-[_likeBtn]-10-|"
                                      
                                                                             options:0
                                                                             metrics:nil views:viewsDict]];
}

- (void)_setLayout {
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.contentView).with.offset(kSubviewsPadding);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView);
        make.left.equalTo(self.avatarImageView.right).with.offset(kSubviewsPadding);
        make.right.equalTo(self.contentView).with.offset(-kSubviewsPadding);
        make.height.mas_equalTo(20);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel).with.offset(kSubviewsPadding);
        make.left.and.right.equalTo(self.nameLabel);
        make.bottom.equalTo(self.avatarImageView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.bottom).with.offset(kSubviewsPadding);
        make.left.equalTo(self.avatarImageView);
        make.bottom.equalTo(self.uploadImageView.top).with.offset(-kSubviewsPadding);
        make.right.equalTo(self.contentView).with.offset(-kSubviewsPadding);
    }];
    
    [self.uploadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    [self.sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView);
        make.bottom.equalTo(self.shareBtn.top).with.offset(-kSubviewsPadding);
        make.right.equalTo(self.contentLabel);
        make.height.mas_equalTo(20);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView);
        make.bottom.equalTo(self.contentView).with.offset(-kSubviewsPadding);
        make.width.mas_equalTo(kSolidButtonWidth);
        make.height.mas_equalTo(30);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareBtn.right).with.offset(kSubviewsPadding);
        make.bottom.equalTo(self.shareBtn);
        make.width.mas_equalTo(kSolidButtonWidth);
        make.height.mas_equalTo(30);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentBtn.right).with.offset(kSubviewsPadding);
        make.bottom.equalTo(self.shareBtn);
        make.width.mas_equalTo(kSolidButtonWidth);
        make.height.mas_equalTo(30);
    }];
}

- (void)_settingData {
    
    self.avatarImageView.image = [UIImage imageNamed:self.flowground.icon];
    
    self.nameLabel.text = self.flowground.name;
    
    // VIP
    //     if (weibo.vip) {
    //     self.nameLabel.textColor = [UIColor redColor];
    //     }
    //
    //     _vipView.hidden = !weibo.vip;
    
    
    //计算时间
    //    self.timeLabel.text = [Tool intervalSinceNow:self.flowground.pubDate];
    self.timeLabel.text = [Tool pubTime:self.flowground.pubDate];
    
    self.contentLabel.attributedText = [Tool emojiStringFromRawString:self.flowground.content];
    
    
    if (self.flowground.image) {
        self.uploadImageView.hidden = NO;
        
        self.uploadImageView.image = [UIImage imageNamed:self.flowground.image];
    } else {
        
        self.uploadImageView.hidden = YES;
    }
    
    
    //    self.sourceLabel.attributedText = [Tool getAppclient:self.flowground.appClient];
    self.sourceLabel.text = [NSString stringWithFormat:@"来自%@", self.flowground.source];
    
    //    self.shareBtn.imageView.image = [UIImage imageNamed:@"share"];
    [self.shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.shareBtn setImage:[UIImage imageNamed:@"share_2"] forState:UIControlStateHighlighted];
    [self.shareBtn addTarget:self action:@selector(clickForShare) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commentBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(clickForComment) forControlEvents:UIControlEventTouchUpInside];
    
    [self.likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [self.likeBtn addTarget:self action:@selector(clickForLike) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark - CustomDelegate



#pragma mark - Getters & Setters

- (void)setFlowground:(Flowground *)flowground {
    
    _flowground = flowground;
    
    [self _settingData];
}


@end







