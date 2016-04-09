//
//  WBStatusComposeEmoticonView.m
//  YYKitExample
//
//  Created by ibireme on 15/9/6.
//  Copyright (C) 2015 ibireme. All rights reserved.
//

#import "WBEmoticonInputView.h"
#import "WBStatusHelper.h"
#import "WBModel.h"
#import "YYKit.h"

#define kViewHeight 216
#define kToolbarHeight 37
#define kOneEmoticonHeight 50
#define kOnePageCount 20


@interface WBEmoticonCell : UICollectionViewCell
@property (nonatomic, strong) WBEmoticon *emoticon;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation WBEmoticonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _imageView = [UIImageView new];
    _imageView.size = CGSizeMake(32, 32);
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
    return self;
}

- (void)setEmoticon:(WBEmoticon *)emoticon {
    if (_emoticon == emoticon) return;
    _emoticon = emoticon;
    [self updateContent];
}

- (void)setIsDelete:(BOOL)isDelete {
    if (_isDelete == isDelete) return;
    _isDelete = isDelete;
    [self updateContent];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayout];
}

// 设置_imageView.image( X & ( emoji(CoreText 画) & .png(bundlePath) ) )
- (void)updateContent {
    [_imageView cancelCurrentImageRequest];
    _imageView.image = nil;
    
    if (_isDelete) {
        _imageView.image = [WBStatusHelper imageNamed:@"compose_emotion_delete"];
    } else if (_emoticon) {
        // Model(code) -> str已经是Emoji ?
        if (_emoticon.type == WBEmoticonTypeEmoji) {
            NSNumber *num = [NSNumber numberWithString:_emoticon.code];
            NSString *str = [NSString stringWithUTF32Char:num.unsignedIntValue];
            if (str) {
                //
                UIImage *img = [UIImage imageWithEmoji:str size:_imageView.width];
                _imageView.image = img;
            }
        // WBEmoticonTypeImage ->
        } else if (_emoticon.group.groupID && _emoticon.png){
            // EmoticonWeibo.bundle
            NSString *pngPath = [[WBStatusHelper emoticonBundle] pathForScaledResource:_emoticon.png ofType:nil inDirectory:_emoticon.group.groupID];
            // EmoticonWeibo.bundle/additional
            if (!pngPath) {
                NSString *addBundlePath = [[WBStatusHelper emoticonBundle].bundlePath stringByAppendingPathComponent:@"additional"];
                NSBundle *addBundle = [NSBundle bundleWithPath:addBundlePath];
                pngPath = [addBundle pathForScaledResource:_emoticon.png ofType:nil inDirectory:_emoticon.group.groupID];
            }
            if (pngPath) {
                [_imageView setImageWithURL:[NSURL fileURLWithPath:pngPath] options:YYWebImageOptionIgnoreDiskCache];
            }
        }
    }
}

- (void)updateLayout {
    _imageView.center = CGPointMake(self.width / 2, self.height / 2);
}

@end









@protocol WBEmoticonScrollViewDelegate <UICollectionViewDelegate>
- (void)emoticonScrollViewDidTapCell:(WBEmoticonCell *)cell;
@end

@interface WBEmoticonScrollView : UICollectionView
@end

@implementation WBEmoticonScrollView {
    NSTimeInterval *_touchBeganTime;
    BOOL _touchMoved;
    UIImageView *_magnifier;
    UIImageView *_magnifierContent;
    __weak WBEmoticonCell *_currentMagnifierCell;
    NSTimer *_backspaceTimer;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [UIView new];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = NO;
    self.canCancelContentTouches = NO;
    self.multipleTouchEnabled = NO;
    _magnifier = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"emoticon_keyboard_magnifier"]];
    _magnifierContent = [UIImageView new];
    _magnifierContent.size = CGSizeMake(40, 40);
    _magnifierContent.centerX = _magnifier.width / 2;
    [_magnifier addSubview:_magnifierContent];
    _magnifier.hidden = YES;
    [self addSubview:_magnifier];
    return self;
}

- (void)dealloc {
    [self endBackspaceTimer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touchMoved = NO;
    WBEmoticonCell *cell = [self cellForTouches:touches];
    _currentMagnifierCell = cell;
    [self showMagnifierForCell:_currentMagnifierCell];
    
    // 有image && 不是delete
    if (cell.imageView.image && !cell.isDelete) {
        [[UIDevice currentDevice] playInputClick];
    }
    
    if (cell.isDelete) {
        [self endBackspaceTimer];
        [self performSelector:@selector(startBackspaceTimer) afterDelay:0.5];
    }
}

// 不是 X键，赋值 + show
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touchMoved = YES;
    // X键 return
    if (_currentMagnifierCell && _currentMagnifierCell.isDelete) return;
    
    WBEmoticonCell *cell = [self cellForTouches:touches];
    if (cell != _currentMagnifierCell) {
        if (!_currentMagnifierCell.isDelete && !cell.isDelete) {
            _currentMagnifierCell = cell;
        }
        [self showMagnifierForCell:cell];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    WBEmoticonCell *cell = [self cellForTouches:touches];
    // (emoticon && 不是X) || (没移动 && 是X) => delegate.emoticonScrollViewDidTapCell:
    if ((!_currentMagnifierCell.isDelete && cell.emoticon) || (!_touchMoved && cell.isDelete)) {
        if ([self.delegate respondsToSelector:@selector(emoticonScrollViewDidTapCell:)]) {
            [((id<WBEmoticonScrollViewDelegate>) self.delegate) emoticonScrollViewDidTapCell:cell];
        }
    }
    [self hideMagnifier];
    [self endBackspaceTimer];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self hideMagnifier];
    [self endBackspaceTimer];
}

// point -> indexPath -> cell
- (WBEmoticonCell *)cellForTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    if (indexPath) {
        WBEmoticonCell *cell = (id)[self cellForItemAtIndexPath:indexPath];
        return cell;
    }
    return nil;
}

// 放大图
- (void)showMagnifierForCell:(WBEmoticonCell *)cell {
    if (cell.isDelete || !cell.imageView.image) {
        [self hideMagnifier];
        return;
    }
    // 根据cellRect在view中的坐标，layout _magnifier + _magnifierContent
    CGRect rect = [cell convertRect:cell.bounds toView:self];
    _magnifier.centerX = CGRectGetMidX(rect);
    _magnifier.bottom = CGRectGetMaxY(rect) - 9;
    _magnifier.hidden = NO;
    
    _magnifierContent.image = cell.imageView.image;
    _magnifierContent.top = 20;
    
    [_magnifierContent.layer removeAllAnimations];
    // top 20->3->6->5
    NSTimeInterval dur = 0.1;
    [UIView animateWithDuration:dur delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _magnifierContent.top = 3;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:dur delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _magnifierContent.top = 6;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:dur delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                _magnifierContent.top = 5;
            } completion:^(BOOL finished) {
            }];
        }];
    }];
}

- (void)hideMagnifier {
    _magnifier.hidden = YES;
}

// 0.1s延迟，self.delegate -> emoticonScrollViewDidTapCell
- (void)startBackspaceTimer {
    [self endBackspaceTimer];
    @weakify(self);
    _backspaceTimer = [NSTimer timerWithTimeInterval:0.1 block:^(NSTimer *timer) {
        @strongify(self);
        if (!self) return;
        WBEmoticonCell *cell = self->_currentMagnifierCell;
        if (cell.isDelete) {
            if ([self.delegate respondsToSelector:@selector(emoticonScrollViewDidTapCell:)]) {
                [[UIDevice currentDevice] playInputClick];
                [((id<WBEmoticonScrollViewDelegate>) self.delegate) emoticonScrollViewDidTapCell:cell];
            }
        }
    } repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_backspaceTimer forMode:NSRunLoopCommonModes];
}

- (void)endBackspaceTimer {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startBackspaceTimer) object:nil];
    [_backspaceTimer invalidate];
    _backspaceTimer = nil;
}
@end








@interface WBEmoticonInputView () <UICollectionViewDelegate, UICollectionViewDataSource, UIInputViewAudioFeedback,WBEmoticonScrollViewDelegate>
@property (nonatomic, strong) NSArray<UIButton *> *toolbarButtons;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *pageControl;
@property (nonatomic, strong) NSArray<WBEmoticonGroup *> *emoticonGroups;
@property (nonatomic, strong) NSArray<NSNumber *> *emoticonGroupPageIndexs; // 起始页
@property (nonatomic, strong) NSArray<NSNumber *> *emoticonGroupPageCounts; // 各group总数
@property (nonatomic, assign) NSInteger emoticonGroupTotalPageCount;
@property (nonatomic, assign) NSInteger currentPageIndex;

@end


@implementation WBEmoticonInputView

+ (instancetype)sharedView {
    static WBEmoticonInputView *v;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        v = [self new];
    });
    return v;
}

- (instancetype)init {
    self = [super init];
    self.frame = CGRectMake(0, 0, kScreenWidth, kViewHeight);
    self.backgroundColor = UIColorHex(f9f9f9);
    [self _initGroups];
    [self _initTopLine];
    [self _initCollectionView];
    [self _initToolbar];  //底部表情按钮
    
    _currentPageIndex = NSNotFound;
    [self _toolbarBtnDidTapped:_toolbarButtons.firstObject];
    
    return self;
}

- (void)_initGroups {
    _emoticonGroups = [WBStatusHelper emoticonGroups];
    NSMutableArray *indexs = [NSMutableArray new];
    NSUInteger index = 0;
    for (WBEmoticonGroup *group in _emoticonGroups) {
        [indexs addObject:@(index)];
        NSUInteger count = ceil(group.emoticons.count / (float)kOnePageCount);
        if (count == 0) count = 1;
        index += count;
    }
    _emoticonGroupPageIndexs = indexs;
    
    NSMutableArray *pageCounts = [NSMutableArray new];
    _emoticonGroupTotalPageCount = 0;
    for (WBEmoticonGroup *group in _emoticonGroups) {
        NSUInteger pageCount = ceil(group.emoticons.count / (float)kOnePageCount);
        if (pageCount == 0) pageCount = 1;
        [pageCounts addObject:@(pageCount)];
        _emoticonGroupTotalPageCount += pageCount;
    }
    _emoticonGroupPageCounts = pageCounts;
}

- (void)_initTopLine {
    UIView *line = [UIView new];
    line.width = self.width;
    line.height = CGFloatFromPixel(1);
    line.backgroundColor = UIColorHex(bfbfbf);
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:line];
}

- (void)_initCollectionView {
    // itemWidth + 左右padding
    CGFloat itemWidth = (kScreenWidth - 10 * 2) / 7.0;
    itemWidth = CGFloatPixelRound(itemWidth);
    CGFloat padding = (kScreenWidth - 7 * itemWidth) / 2.0;
    CGFloat paddingLeft = CGFloatPixelRound(padding);
    CGFloat paddingRight = kScreenWidth - paddingLeft - itemWidth * 7;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(itemWidth, kOneEmoticonHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight);
    
    _collectionView = [[WBEmoticonScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kOneEmoticonHeight * 3) collectionViewLayout:layout];
    [_collectionView registerClass:[WBEmoticonCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.top = 5;
    [self addSubview:_collectionView];
    
    _pageControl = [UIView new];
    _pageControl.size = CGSizeMake(kScreenWidth, 20);
    _pageControl.top = _collectionView.bottom - 5;
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
}

// Toolbar + 黑bg + scrollView(+btn)
- (void)_initToolbar {
    UIView *toolbar = [UIView new];
    toolbar.size = CGSizeMake(kScreenWidth, kToolbarHeight);
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[WBStatusHelper imageNamed:@"compose_emotion_table_right_normal"]];
    bg.size = toolbar.size;
    [toolbar addSubview:bg];
    
    UIScrollView *scroll = [UIScrollView new];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.alwaysBounceHorizontal = YES;
    scroll.size = toolbar.size;
    scroll.contentSize = toolbar.size;
    [toolbar addSubview:scroll];
    
    NSMutableArray *btns = [NSMutableArray new];
    UIButton *btn;
    for (NSUInteger i = 0; i < _emoticonGroups.count; i++) {
        WBEmoticonGroup *group = _emoticonGroups[i];
        btn = [self _createToolbarButton];
        [btn setTitle:group.nameCN forState:UIControlStateNormal];
        btn.left = kScreenWidth / (float)_emoticonGroups.count * i;
        btn.tag = i;
        [scroll addSubview:btn];
        [btns addObject:btn];
    }
    
    toolbar.bottom = self.height;
    [self addSubview:toolbar];
    _toolbarButtons = btns;
}

// Selected -> 白底黑字，Normal -> 黑底白字
- (UIButton *)_createToolbarButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.exclusiveTouch = YES;
    btn.size = CGSizeMake(kScreenWidth / _emoticonGroups.count, kToolbarHeight);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:UIColorHex(5D5C5A) forState:UIControlStateSelected];
    
    UIImage *img;
    img = [WBStatusHelper imageNamed:@"compose_emotion_table_left_normal"]; // 黑
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, img.size.width - 1) resizingMode:UIImageResizingModeStretch];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    
    img = [WBStatusHelper imageNamed:@"compose_emotion_table_left_selected"]; // 白
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, img.size.width - 1) resizingMode:UIImageResizingModeStretch];
    [btn setBackgroundImage:img forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(_toolbarBtnDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

// 点击btn -> 跳转到起始页
- (void)_toolbarBtnDidTapped:(UIButton *)btn {
    NSInteger groupIndex = btn.tag;  // 0 6 10
    NSInteger page = ((NSNumber *)_emoticonGroupPageIndexs[groupIndex]).integerValue;
    CGRect rect = CGRectMake(page * _collectionView.width, 0, _collectionView.width, _collectionView.height);
    [_collectionView scrollRectToVisible:rect animated:NO];
    [self scrollViewDidScroll:_collectionView];
}

// 感觉就是为了+6个图片
- (WBEmoticon *)_emoticonForIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;  // 0-11
    for (NSInteger i = _emoticonGroupPageIndexs.count - 1; i >= 0; i--) { // 2 1 0
        NSNumber *pageIndex = _emoticonGroupPageIndexs[i]; // 10 6 0
        if (section >= pageIndex.unsignedIntegerValue) {
            // (section 0-11 + row 0-19) => group中的index
            WBEmoticonGroup *group = _emoticonGroups[i];
            // 对当前group中的section -> 当前group中第几个
            NSUInteger page = section - pageIndex.unsignedIntegerValue;
            NSUInteger index = page * kOnePageCount + indexPath.row;
            
            // 按20/页和第几个
            NSUInteger ip = index / kOnePageCount; // 页
            NSUInteger ii = index % kOnePageCount; // 第几个
            NSUInteger reIndex = (ii % 3) * 7 + (ii / 3);
            index = reIndex + ip * kOnePageCount;
            
            if (index < group.emoticons.count) {
                return group.emoticons[index];
            } else {
                return nil;
            }
        }
    }
    return nil;
}


#pragma mark WBEmoticonScrollViewDelegate

// (emoticon && 不是X) || (没移动 && 是X)
- (void)emoticonScrollViewDidTapCell:(WBEmoticonCell *)cell {
    if (!cell) return;
    if (cell.isDelete) {
        if ([self.delegate respondsToSelector:@selector(emoticonInputDidTapBackspace)]) {
            [[UIDevice currentDevice] playInputClick];
            [self.delegate emoticonInputDidTapBackspace];
        }
    } else if (cell.emoticon) {
        NSString *text = nil;
        // 图片表情->.chs OR emoji->code(NSNumber->NSString)
        switch (cell.emoticon.type) {
            case WBEmoticonTypeImage: {
                text = cell.emoticon.chs;
            } break;
            case WBEmoticonTypeEmoji: {
                NSNumber *num = [NSNumber numberWithString:cell.emoticon.code];
                text = [NSString stringWithUTF32Char:num.unsignedIntValue];
            } break;
            default:break;
        }  // 通知delegate显示表情
        if (text && [self.delegate respondsToSelector:@selector(emoticonInputDidTapText:)]) {
            [self.delegate emoticonInputDidTapText:text];
        }
    }
}

#pragma mark UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = round(scrollView.contentOffset.x / scrollView.width);
    
    if (page < 0) page = 0;
    else if (page >= _emoticonGroupTotalPageCount) page = _emoticonGroupTotalPageCount - 1;
    if (page == _currentPageIndex) return;
    _currentPageIndex = page;
    
    // 当前移动page -> groupIndex(0 1 2) + pageIndex(0 6 10) + pageCnt(6 4 2)
    NSInteger curGroupIndex = 0, curGroupPageIndex = 0, curGroupPageCount = 0;
    for (NSInteger i = _emoticonGroupPageIndexs.count - 1; i >= 0; i--) { // 2 1 0
        NSNumber *pageIndex = _emoticonGroupPageIndexs[i]; // 10 6 0
        if (page >= pageIndex.unsignedIntegerValue) {
            curGroupIndex = i;
            curGroupPageIndex = ((NSNumber *)_emoticonGroupPageIndexs[i]).integerValue;
            curGroupPageCount = ((NSNumber *)_emoticonGroupPageCounts[i]).integerValue;
            break;
        }
    }
    [_pageControl.layer removeAllSublayers];
    CGFloat padding = 5, width = 6, height = 2;
    CGFloat pageControlWidth = (width + 2 * padding) * curGroupPageCount;
    for (NSInteger i = 0; i < curGroupPageCount; i++) { // ex: page = 3, i = 0-5
        
        CALayer *layer = [CALayer layer];
        layer.size = CGSizeMake(width, height);
        layer.cornerRadius = 1;
        
        if (page - curGroupPageIndex == i) { // ex: i=3, 当前页为`橘色`
            layer.backgroundColor = UIColorHex(fd8225).CGColor;
        } else {
            layer.backgroundColor = UIColorHex(dedede).CGColor;
        }
        
        layer.centerY = _pageControl.height / 2; // 10
        layer.left = (_pageControl.width - pageControlWidth) / 2 + i * (width + 2 * padding) + padding;
        [_pageControl.layer addSublayer:layer];
    }
    // 滑动到下一个范围，按钮自动跳动
    [_toolbarButtons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.selected = (idx == curGroupIndex);
    }];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _emoticonGroupTotalPageCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kOnePageCount + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WBEmoticonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == kOnePageCount) {
        cell.isDelete = YES;
        cell.emoticon = nil;
    } else {
        cell.isDelete = NO;
        cell.emoticon = [self _emoticonForIndexPath:indexPath];
    }
    return cell;
}

#pragma mark - UIInputViewAudioFeedback

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

@end
