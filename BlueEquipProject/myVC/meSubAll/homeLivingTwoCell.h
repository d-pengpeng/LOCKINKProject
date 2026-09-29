//
//  homeLivingTwoCell.h
//  AuctionLiveProject
//
//  Created by Edwin on 2023/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^homeLivingTwoCellBLock)(NSInteger selRow);
@interface homeLivingTwoCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, copy) homeLivingTwoCellBLock block_;
@property (nonatomic, strong) UIViewController *selVC;
@property (nonatomic, copy) NSString *othrId;
- (void)addDataToModel:(NSArray *)datArr  datList:(NSArray *)listArr typeL:(NSInteger)typeL booScrol:(BOOL)scrolB vieControl:(UIViewController *)selfVV;
@end

NS_ASSUME_NONNULL_END
