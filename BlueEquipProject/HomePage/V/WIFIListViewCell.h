//
//  WIFIListViewCell.h
//  MachineGlory
//
//  Created by Edwin on 2021/8/21.
//  Copyright © 2021 time. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WIFIListViewCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, copy) NSString *readNNam;
- (void)addModelToDataModel:(NSString *)nameSt choseName:(NSString *)chosN;
@end

NS_ASSUME_NONNULL_END
