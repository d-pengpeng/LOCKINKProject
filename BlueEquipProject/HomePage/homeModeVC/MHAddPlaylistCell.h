//
//  MHAddPlaylistCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/2.
//

#import <UIKit/UIKit.h>
#import "MHLibraryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHAddPlaylistCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
- (void)addDataToDic:(MHLibraryModel *)model;
- (void)addMusicDataToDic:(MHLibraryModel *)model;
@end

NS_ASSUME_NONNULL_END
