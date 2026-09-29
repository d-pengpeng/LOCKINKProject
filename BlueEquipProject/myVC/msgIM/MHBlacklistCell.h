//
//  MHBlacklistCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol blackListDelegate <NSObject>

- (void)blackListDelegateIndePP:(NSIndexPath *)indePP;

@end
@interface MHBlacklistCell : UITableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<blackListDelegate> delegate_;
@property (nonatomic, strong) NSIndexPath *indPPPPl;
- (void)addDataToDic:(NSDictionary *)dicMMdat;


@end

NS_ASSUME_NONNULL_END
