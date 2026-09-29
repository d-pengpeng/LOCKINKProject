//
//  homeLivingOneCell.h
//  AuctionLiveProject
//
//  Created by Edwin on 2023/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol homeLivingOneCellDelegate <NSObject>

@optional
- (void)clickHomeLivingOneCellMethod:(NSInteger)num;
- (void)homeLivUploadMethod;

@end
@interface homeLivingOneCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic, assign) id<homeLivingOneCellDelegate> delegate_;
- (void)addDataToMeUser:(NSDictionary *)userDD;
- (void)addDataToOthrUser:(NSDictionary *)userDD;
@end

NS_ASSUME_NONNULL_END
