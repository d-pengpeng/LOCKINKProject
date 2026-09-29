
#import <UIKit/UIKit.h>
#import "TUICommonPendencyCell.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 【模块名称】好友申请界面（TUINewFriendViewController）
 * 【功能说明】负责拉取好友申请信息，并在界面中显示。
 *  通过本界面，您可以查看自己收到的好友请求，并进行同意/拒绝申请的操作。
 */

@protocol TUINewFriendViewCDelegate <NSObject>

- (void)TUINewFriendViewCDelegateMethodTyp:(TUICommonPendencyCellData *)model;
- (void)TUINewFriendViewCDelegateMethodTypTwoSpace:(TUICommonPendencyCellData *)model; //进入个人空间

@end
@interface TUINewFriendViewController : UIViewController

@property (nonatomic) void (^cellClickBlock)(TUICommonPendencyCell *cell);
@property (nonatomic, assign) id<TUINewFriendViewCDelegate> delegate_;

- (void)addUIUIUIUIUpload;
@end

NS_ASSUME_NONNULL_END
