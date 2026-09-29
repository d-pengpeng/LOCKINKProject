//
//  myIMSearchCell.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/28.
//

#import <UIKit/UIKit.h>
#import "myIMSearchModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol myIMSearchCellDelegate <NSObject>

- (void)myIMSearchCellDDetgateNrwo:(NSInteger)rowN;

@end
@interface myIMSearchCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<myIMSearchCellDelegate> delegate_;
- (void)addModelToDataMode:(myIMSearchModel *)model lisC2CBoo:(BOOL)isBBoo indexP:(NSInteger)rowNN;
@end

NS_ASSUME_NONNULL_END
