//
//  Q_AOneCell.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/10/12.
//

#import <UIKit/UIKit.h>
#import "Q_AOneModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Q_AOneCell : UITableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView;

- (void)addModelData:(Q_AOneModel *)model;
@end

NS_ASSUME_NONNULL_END
