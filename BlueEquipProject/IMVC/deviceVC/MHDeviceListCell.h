//
//  MHDeviceListCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHDeviceListCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addModelToDataModel:(NSDictionary *)mode;
@end

NS_ASSUME_NONNULL_END
