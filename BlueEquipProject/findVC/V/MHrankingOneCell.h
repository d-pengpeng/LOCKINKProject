//
//  MHrankingOneCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHrankingOneCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addDataToArr:(NSArray *)arList;
@end

NS_ASSUME_NONNULL_END
