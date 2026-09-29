//
//  MHMyPhotoCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MHMyPhotoCellDelegate <NSObject>

- (void)myPhotoCellDelegateMethodNum:(NSInteger)tagL arr:(NSArray *)arrM;

@end
@interface MHMyPhotoCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<MHMyPhotoCellDelegate> delegate_;
- (void)addDataToModel:(NSDictionary *)dicMMMM;
@end

NS_ASSUME_NONNULL_END
