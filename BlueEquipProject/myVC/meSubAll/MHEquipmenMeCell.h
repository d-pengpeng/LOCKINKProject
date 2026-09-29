//
//  MHEquipmenMeCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHEquipmenMeCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addDataToModel:(NSDictionary *)dicMMMM;
@end

NS_ASSUME_NONNULL_END
