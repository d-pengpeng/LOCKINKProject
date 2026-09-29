//
//  muteGroupListCell.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/10/9.
//

#import <UIKit/UIKit.h>
#import "TUICommonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface muteGroupListCell : UITableViewCell
- (void)fillWithDataModel:(TUIUserModel *)model;
@end

NS_ASSUME_NONNULL_END
