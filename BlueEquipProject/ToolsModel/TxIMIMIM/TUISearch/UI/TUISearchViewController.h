//
//  TUISearchViewController.h
//  Pods
//
//  Created by harvy on 2020/12/24.
//

#import <UIKit/UIKit.h>
#import "TUIChatConversationModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TUISearchViewCDelegate <NSObject>

- (void)selectTUISearchViewCCLickModel:(V2TIMFriendInfo *)model;
- (void)TUISearchViewCSelectRow:(TUIChatConversationModel *)conData highlightKeyword:(NSString *)highlightKeyword imgMMMessage:(V2TIMMessage *)locateMessage;
- (void)TUISearchViewCSelectGroupid:(NSString *)groupId name:(NSString *)nameT isBOO:(BOOL)isBoo;
@end
@interface TUISearchViewController : UIViewController

@property (nonatomic, assign) id<TUISearchViewCDelegate> delegate_;
@property (nonatomic, assign) BOOL isHistoryBoo;

- (void)addSearchTxtStr:(NSString *)str_str;
@end

NS_ASSUME_NONNULL_END
