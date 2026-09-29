//
//  MHLanguageCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import <UIKit/UIKit.h>
#import "MHLanguageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHLanguageCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addModelData:(MHLanguageModel *)model;
@end

NS_ASSUME_NONNULL_END
