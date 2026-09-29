//
//  MHMsgIMOneCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/5.
//

#import <UIKit/UIKit.h>
#import "MHSystemMsgModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MHMsgIMOneCellDelegate <NSObject>

@optional

@end
@interface MHMsgIMOneCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic, assign) id<MHMsgIMOneCellDelegate> deleagte_;

- (void)addModelToDataModel:(MHSystemMsgModel *)model;
@end

NS_ASSUME_NONNULL_END
