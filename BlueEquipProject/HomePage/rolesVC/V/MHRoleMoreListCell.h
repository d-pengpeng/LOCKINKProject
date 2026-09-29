//
//  MHRoleMoreListCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/22.
//

#import <UIKit/UIKit.h>
#import "MHRoleMoreListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHRoleMoreListCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addModelToDataModel:(MHRoleMoreListModel *)model;
- (void)addModelToDataModelTwo:(MHRoleMoreListModel *)model;
@end

NS_ASSUME_NONNULL_END
