//
//  MHVisitorCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import <UIKit/UIKit.h>
#import "MHVisitorModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MHVisitorCellDelegate <NSObject>

- (void)MHVisitorCellDelegateMEthodRow:(NSInteger)typeM indeP:(NSIndexPath *)indPP;

@end
@interface MHVisitorCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic, assign) id<MHVisitorCellDelegate> delegate_;
- (void)addDataToModel:(MHVisitorModel *)modelM indeP:(NSIndexPath *)row typeN:(NSString *)typNum;
@end

NS_ASSUME_NONNULL_END
