//
//  MHFriendChooseCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/20.
//

#import <UIKit/UIKit.h>
#import "MHFriendChooseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHFriendChooseCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addModelToDataModel:(MHFriendChooseModel *)model;
@end

NS_ASSUME_NONNULL_END
