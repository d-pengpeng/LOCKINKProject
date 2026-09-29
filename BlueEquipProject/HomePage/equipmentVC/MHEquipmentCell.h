//
//  MHEquipmentCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/21.
//

#import <UIKit/UIKit.h>
#import "MHEquipmentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHEquipmentCell : UITableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addDataToDic:(MHEquipmentModel *)model row:(NSInteger)rowL;
@end

NS_ASSUME_NONNULL_END
