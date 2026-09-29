//
//  MHApplyVoteListCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHApplyVoteListCell : UITableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addDataToModel:(NSDictionary *)model;
@end

NS_ASSUME_NONNULL_END
