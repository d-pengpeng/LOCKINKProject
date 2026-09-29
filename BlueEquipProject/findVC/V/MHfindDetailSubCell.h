//
//  MHfindDetailSubCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import <UIKit/UIKit.h>
#import "MHfindDetailModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MHfindDetailSubCellDelegate <NSObject>

- (void)findDetailSubCellDelegateNum:(NSInteger)typeN indP:(NSIndexPath *)indPP;

@end
@interface MHfindDetailSubCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<MHfindDetailSubCellDelegate> delegate_;
- (void)addDataToModel:(MHfindDetailModel *)model indeP:(NSIndexPath *)row;
@end

NS_ASSUME_NONNULL_END
