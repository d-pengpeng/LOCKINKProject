//
//  MHToggleAccountAddCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHToggleAccountAddCell : UITableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *nickLab;
@end

NS_ASSUME_NONNULL_END
