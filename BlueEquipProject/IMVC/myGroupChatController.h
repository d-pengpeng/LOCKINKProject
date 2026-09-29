//
//  myGroupChatController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/12.
//

#import "eBaseViewController.h"
#import "TUIChatConversationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface myGroupChatController : eBaseViewController

@property (nonatomic, copy) NSString *chatId;
@property (nonatomic, copy) NSString *showName;
@property (nonatomic, copy) NSString *conversationID;

@property (nonatomic, assign) BOOL isHistoryBoo;
@property (nonatomic) TUIChatConversationModel *conversationData;
@property (nonatomic, copy) NSString *highlightKeyword;
@property (nonatomic, strong) V2TIMMessage *locateMessage;
@end

NS_ASSUME_NONNULL_END
