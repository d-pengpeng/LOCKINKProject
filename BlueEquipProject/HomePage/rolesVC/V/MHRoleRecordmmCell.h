//
//  MHRoleRecordmmCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/18.
//

#import <UIKit/UIKit.h>
#import "MHfindSubPatternsModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MHRoleRecordmmCellDelaget <NSObject>

-(void)focusOrGoodOrComment:(NSInteger)typeN indexPath:(NSIndexPath *)indexPath;
- (void)fileClick:(NSArray *)array row:(NSInteger)row indexPath:(NSIndexPath *)indexPath;

@end

@interface MHRoleRecordmmCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<MHRoleRecordmmCellDelaget> delegate_;

- (void)addDataToMeDic:(MHfindSubPatternsModel *)model row:(NSIndexPath *)rowL typMethod:(NSInteger)typM;
@end

NS_ASSUME_NONNULL_END
