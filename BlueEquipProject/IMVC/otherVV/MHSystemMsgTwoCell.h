//
//  MHSystemMsgTwoCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHSystemMsgTwoCell : UITableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addModelToDataModel:(NSString *)mode;
@end

NS_ASSUME_NONNULL_END
