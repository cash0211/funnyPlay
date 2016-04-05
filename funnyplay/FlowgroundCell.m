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
#define kSolidButtonWidth      ([[UIScreen mainScreen] bounds].size.width - 4 * kSubviewsPadding) / 3

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
    UIImageView *avatarImageView = [UIImageView new];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    avatarImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:avatarImageView];
    self.avatarImageView = avatarImageView;
    
    // 2.名字
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont boldSystemFontOfSize:15];
    nameLabel.userInteractionEnabled = YES;
    nameLabel.textColor = [UIColor nameColor];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //vipView
    
    // 3.时间
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 4.内容
    UILabel *contentLabel = [UILabel new];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    // 5.图片
    UIImageView *uploadImageView = [UIImageView new];
    uploadImageView.contentMode = UIViewContentModeScaleAspectFit;
    uploadImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:uploadImageView];
    self.uploadImageView = uploadImageView;
    
    // 6.来源
    UILabel *sourceLabel = [UILabel new];
    sourceLabel.font = [UIFont systemFontOfSize:12];
    sourceLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    [self.contentView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    // 7.分享
    UIButton *shareBtn = [UIButton new];
    [self.contentView addSubview:shareBtn];
    self.shareBtn = shareBtn;
    
    // 8.评论
    UIButton *commentBtn = [UIButton new];
    [self.contentView addSubview:commentBtn];
    self.commentBtn = commentBtn;
    
    // 9.赞
    UIButton *likeBtn = [UIButton new];
    [self.contentView addSubview:likeBtn];
    self.likeBtn = likeBtn;
    
    // 10.赞列表
    UILabel *likeListLabel = [UILabel new];
    likeListLabel.numberOfLines = 0;
    likeListLabel.lineBreakMode = NSLineBreakByWordWrapping;
    likeListLabel.font = [UIFont systemFontOfSize:12];
    likeListLabel.userInteractionEnabled = YES;
    likeListLabel.textColor = [UIColor colorWithHex:0xA0A3A7];
    [self.contentView addSubview:likeListLabel];
    self.likeListLabel = likeListLabel;
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







