//
//  MHfindSubPatternsCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/3.
//

#import <UIKit/UIKit.h>
#import "MHfindSubPatternsModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MHfindSubPatternsCelDelaget <NSObject>

-(void)focusOrGoodOrComment:(NSInteger)typeN indexPath:(NSIndexPath *)indexPath;
- (void)fileClick:(NSArray *)array row:(NSInteger)row indexPath:(NSIndexPath *)indexPath;

@end
@interface MHfindSubPatternsCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<MHfindSubPatternsCelDelaget> delegate_;
- (void)addDataToDic:(MHfindSubPatternsModel *)model row:(NSIndexPath *)rowL;
- (void)addDataToMeDic:(MHfindSubPatternsModel *)model row:(NSIndexPath *)rowL typMethod:(NSInteger)typM;
@end

NS_ASSUME_NONNULL_END
