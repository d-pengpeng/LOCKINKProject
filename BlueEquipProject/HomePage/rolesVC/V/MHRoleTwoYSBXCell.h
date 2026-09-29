//
//  MHRoleTwoYSBXCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/26.
//

#import <UIKit/UIKit.h>
#import "MHBoXingModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MHRoleTwoYSBXCellDelegate <NSObject>

@optional
- (void)roleTwoYSBXCelldelegateDeleteRow:(NSIndexPath *)indMMP;
- (void)roleTwoYSBXCelldelegateDeletePlayBooRow:(NSIndexPath *)indMMP;
@end
@interface MHRoleTwoYSBXCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, strong) NSDictionary *dicMM;
@property (nonatomic, strong) NSIndexPath *indPPP;
@property (nonatomic, assign) id<MHRoleTwoYSBXCellDelegate> delegate_;

- (void)addModelToDataModel; 
- (void)addModelToDataModelUser; 
@end




@interface MHRoleTwoYSBXCell_three : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic, strong) NSIndexPath *indPPP;
@property (nonatomic, strong) MHBoXingModel *model;
@property (nonatomic, assign) id<MHRoleTwoYSBXCellDelegate> delegate_;

- (void)addModelToDataModelUser;
@end

NS_ASSUME_NONNULL_END
