//
//  MHRoleThrRecordCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/20.
//

#import <UIKit/UIKit.h>
#import "MHRoleThrRecordModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MHRoleThrRecordCDelegate <NSObject>

- (void)roleThrRecordCDelegateRow:(NSIndexPath *)indPP;

@end
@interface MHRoleThrRecordCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<MHRoleThrRecordCDelegate> delegate_;
- (void)addDataToModel:(MHRoleThrRecordModel *)model indeP:(NSIndexPath *)indPP;
@end

NS_ASSUME_NONNULL_END
