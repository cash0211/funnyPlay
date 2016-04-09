//
//  FPMessages.m
//  funnyplay
//
//  Created by cash on 16/3/30.
//  Copyright © 2016年 ___CASH___. All rights reserved.
//

#import "FPMessages.h"

@implementation FPMessages

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.messages = [NSMutableArray new];
//        
//        JSQMessagesAvatarImage *jsqImage = [JSQMessagesAvatarImageFactory avatarImageWithUserInitials:@"JSQ"
//                                                                                      backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
//                                                                                            textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
//                                                                                                 font:[UIFont systemFontOfSize:14.0f]
//                                                                                             diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
//        
//        JSQMessagesAvatarImage *cookImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_cook"]
//                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
//        
//        JSQMessagesAvatarImage *jobsImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]
//                                                                                       diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
//        
//        JSQMessagesAvatarImage *wozImage = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_woz"]
//                                                                                      diameter:kJSQMessagesCollectionViewAvatarSizeDefault];
//        
//        self.avatars = @{ kJSQDemoAvatarIdSquires : jsqImage,
//                          kJSQDemoAvatarIdCook : cookImage,
//                          kJSQDemoAvatarIdJobs : jobsImage,
//                          kJSQDemoAvatarIdWoz : wozImage };
//        
//        
//        self.users = @{ kJSQDemoAvatarIdJobs : kJSQDemoAvatarDisplayNameJobs,
//                        kJSQDemoAvatarIdCook : kJSQDemoAvatarDisplayNameCook,
//                        kJSQDemoAvatarIdWoz : kJSQDemoAvatarDisplayNameWoz,
//                        kJSQDemoAvatarIdSquires : kJSQDemoAvatarDisplayNameSquires };
        
        
        JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        
        self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleBlueColor]];
        self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
    }
    
    return self;
}

- (void)addPhotoMediaMessage {
    
}

- (void)addLocationMediaMessageCompletion:(JSQLocationMediaItemCompletionBlock)completion {
    
}

- (void)addVideoMediaMessage {
    
}


@end









