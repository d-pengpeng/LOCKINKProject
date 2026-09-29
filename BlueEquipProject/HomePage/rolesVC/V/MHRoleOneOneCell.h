//
//  MHRoleOneOneCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHRoleOneOneCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, strong) UIView *placVV;
@property (nonatomic, strong) UIImageView *nexImgv;
- (void)addModelToDataModel:(NSDictionary *)nameSt choseName:(NSInteger)chosN;
@end

NS_ASSUME_NONNULL_END
