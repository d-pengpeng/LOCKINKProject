//
//  c2cChatController.h
//  DragonTeethLive
//
//  Created by Edwin on 2022/10/24.
//

#import "eBaseViewController.h"
#import "TUIChatConversationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface c2cChatController : eBaseViewController

@property (nonatomic, copy) NSString *chatId;
@property (nonatomic, copy) NSString *showName;
@property (nonatomic, copy) NSString *conversationID;
@property (nonatomic, copy) NSString *recordId;
@property (nonatomic, copy) NSString *typeIdRec;
@property (nonatomic, copy) NSString *dayId;

@property (nonatomic, assign) BOOL isTransferBo;
@property (nonatomic, assign) BOOL isHistoryBoo;
@property (nonatomic) TUIChatConversationModel *conversationData;
@property (nonatomic, copy) NSString *highlightKeyword;
@property (nonatomic, strong) V2TIMMessage *locateMessage;
@end

NS_ASSUME_NONNULL_END
