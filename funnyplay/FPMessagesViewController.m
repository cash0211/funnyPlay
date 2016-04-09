//
//  FPMessagesViewController.m
//  funnyplay
//
//  Created by cash on 16/3/30.
//  Copyright © 2016年 ___CASH___. All rights reserved.
//

#import "FPMessagesViewController.h"
#import "FPMessages.h"

#import <JSQMessages.h>

#define kAvatarViewSize         CGSizeMake(30, 30)

@interface FPMessagesViewController ()

@end

@implementation FPMessagesViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    self.title = @"Let's play";
    
    self.senderId = kJSQDemoAvatarIdSquires;
    self.senderDisplayName = kJSQDemoAvatarDisplayNameSquires;
    
//    self.inputToolbar.contentView.textView.pasteDelegate = self;
    
    // 数据
    self.fpMessages = [[FPMessages alloc] init];
//    self.collectionView.collectionViewLayout.incomingAvatarViewSize = kAvatarViewSize;
//    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = kAvatarViewSize;
    
    self.showLoadEarlierMessagesHeader = YES;
    
    
    // nav右侧 点点点
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage jsq_defaultTypingIndicatorImage]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(receiveMessagePressed:)];
    
    // 长按cell后，弹出框的自定义action
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(customAction:)];
    [UIMenuController sharedMenuController].menuItems = @[[[UIMenuItem alloc] initWithTitle:@"Custom Action"
                                                                                      action:@selector(customAction:)] ];
    
    
    // 这个`delete`menuItems本来就有
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(delete:)];
    
    
//    self.inputToolbar.contentView.leftBarButtonItem = nil;
//    self.inputToolbar.contentView.rightBarButtonItem = nil;
    
    self.inputToolbar.maximumHeight = 150;
    
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.inputToolbar.contentView.textView action:@selector(resignFirstResponder)]];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.collectionView.collectionViewLayout.springinessEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    
}


#pragma mark - Event response

- (void)receiveMessagePressed:(UIBarButtonItem *)sender {
    
}


#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date {
    
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    JSQMessage *message = [[JSQMessage alloc] initWithSenderId:senderId
                                             senderDisplayName:senderDisplayName
                                                          date:date
                                                          text:text];
    
    [self.fpMessages.messages addObject:message];
    
    [self finishSendingMessageAnimated:YES];
}

- (void)didPressAccessoryButton:(UIButton *)sender {
    
    [self.inputToolbar.contentView.textView resignFirstResponder];
    
    UIAlertController *sheetController = [UIAlertController alertControllerWithTitle:@"多媒体" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *imageAction = [UIAlertAction actionWithTitle:@"图片" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *locationAction = [UIAlertAction actionWithTitle:@"定位" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *videoAction = [UIAlertAction actionWithTitle:@"视频" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [sheetController addAction:imageAction];
    [sheetController addAction:locationAction];
    [sheetController addAction:videoAction];
    [sheetController addAction:cancelAction];
    
    [self presentViewController:sheetController animated:YES completion:nil];
}


#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.fpMessages.messages objectAtIndex:indexPath.item];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath {
   
    [self.fpMessages.messages removeObjectAtIndex:indexPath.item];
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 如果你不想要bubbles，返回nil
    // 此例，应该设置你collection view cell的textView的背景色
    // 否则，返回你之前创建的bubble图片数据对象
    
    JSQMessage *message = [self.fpMessages.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.fpMessages.outgoingBubbleImageData;
    }
    
    return self.fpMessages.incomingBubbleImageData;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    不要头像，返回nil
//    如果返回nil，需要在`viewDidLoad`中设置: 默认是30.f
//    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
//    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    
    JSQMessage *message = [self.fpMessages.messages objectAtIndex:indexPath.item];
    
    if ([message.senderId isEqualToString:self.senderId]) {
        
    } else {
        
    }
    
    return [self.fpMessages.avatars objectForKey:message.senderId];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    
    // 这个逻辑应该与 你从`heightForCellTopLabelAtIndexPath:`返回的值一致
    // 其他label高度delegate方法类似
    // 每3个消息显示一个时间戳

    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.fpMessages.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    
    JSQMessage *message = [self.fpMessages.messages objectAtIndex:indexPath.item];
    
    // 发送者name
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.fpMessages.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:message.senderId]) {
            return nil;
        }
    }
    
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}


#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.fpMessages.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    // 配置 Text colors, label text, label colors
    // 不要设置`cell.textView.font`，在`viewDidLoad`中用`self.collectionView.collectionViewLayout.messageBubbleFont`替代
    
    // 不要控制cell布局信息，在`viewDidLoad`中用`self.collectionView.collectionViewLayout`重写你想要的属性
    
    JSQMessage *msg = [self.fpMessages.messages objectAtIndex:indexPath.item];
    
    if (!msg.isMediaMessage) {
        
        if ([msg.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor blackColor];
        }
        else {
            cell.textView.textColor = [UIColor whiteColor];
        }
        
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : [UIColor blueColor],
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
    return cell;
}


#pragma mark - UICollectionView Delegate


#pragma mark - Custom menu items

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    if (action == @selector(customAction:)) {
        return YES;
    }
    
    return [super collectionView:collectionView canPerformAction:action forItemAtIndexPath:indexPath withSender:sender];
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    if (action == @selector(customAction:)) {
        [self customAction:sender];
        return;
    }
    
    [super collectionView:collectionView performAction:action forItemAtIndexPath:indexPath withSender:sender];
}

- (void)customAction:(id)sender {
    
    NSLog(@"Custom action received! Sender: %@", sender);
}


#pragma mark - JSQMessages collection view flow layout delegate


#pragma mark - Adjusting cell label heights

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    
    // cell中的所有label都有高度delegate方法，对应它的text数据源方法
    
    // 这个逻辑应该与 你从`attributedTextForCellTopLabelAtIndexPath:`返回的值一致
    // 其他label高度delegate方法类似
    // 每3个消息显示一个时间戳
    
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath {
    
    // 发送者姓名Label
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath {
    
    return 0.0f;
}


#pragma mark - Responding to collection view tap events

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender {
    
    NSLog(@"Load earlier messages!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Tapped avatar!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Tapped message bubble!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation {
    
    NSLog(@"Tapped cell at %@!", NSStringFromCGPoint(touchLocation));
}


@end






































