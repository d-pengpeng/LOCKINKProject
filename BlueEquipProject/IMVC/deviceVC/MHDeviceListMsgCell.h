//
//  MHDeviceListMsgCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/22.
//

#import <UIKit/UIKit.h>
#import "MHDeviceListMsgModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MHDeviceListMsgCellDelegate <NSObject>

- (void)MHDeviceListMsgCellDelegateType:(NSInteger)typeNN indPM:(NSIndexPath *)dinpp;

@end
@interface MHDeviceListMsgCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<MHDeviceListMsgCellDelegate> delegate_;
- (void)addModelToDataModel:(MHDeviceListMsgModel *)mode indPP:(NSIndexPath *)indPP;
@end

NS_ASSUME_NONNULL_END
