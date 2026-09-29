//
//  receiveRedbagCell.h
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/26.
//

#import <UIKit/UIKit.h>
#import "receiveRedbagModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface receiveRedbagCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

- (void)addDataModel:(receiveRedbagModel *)model;
@end

NS_ASSUME_NONNULL_END
