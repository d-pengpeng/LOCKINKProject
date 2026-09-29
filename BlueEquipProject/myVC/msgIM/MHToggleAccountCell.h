//
//  MHToggleAccountCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/5.
//

#import <UIKit/UIKit.h>
#import "MHToggleAccountModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHToggleAccountCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UIImageView *selImgV;
@property (nonatomic, strong) UILabel *nickLab;
- (void)addDataToDic:(MHToggleAccountModel *)model;
@end

NS_ASSUME_NONNULL_END
