//
//  MHrankingTwoCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/12.
//

#import <UIKit/UIKit.h>
#import "MHrankingUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHrankingTwoCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

- (void)addDataToModel:(MHrankingUserModel *)model row:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END
