//
//  c2cChatDetailController.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/20.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface c2cChatDetailController : eBaseViewController

@property (nonatomic, copy) NSString *chatId;
@property (nonatomic, copy) NSString *conversationID;
@property (nonatomic, assign) int typeId;
@property (nonatomic, assign) BOOL isShowSend;
@end

NS_ASSUME_NONNULL_END
