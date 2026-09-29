//
//  myConversationListCell.h
//  DragonTeethLive
//
//  Created by Edwin on 2022/10/24.
//

#import <UIKit/UIKit.h>
#import "searchFriendAddModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol myConversationListCellDelegate <NSObject>

- (void)myConversationListCellAddFriendUserId:(NSString *)user_idd;

@end
@interface myConversationListCell : UITableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic, assign) id<myConversationListCellDelegate> delegate_;

- (void)addmyHornHistoryCellDic:(V2TIMConversation *)model;
- (void)addmyHornAddFriendCellDic:(searchFriendAddModel *)model;

@end

NS_ASSUME_NONNULL_END
