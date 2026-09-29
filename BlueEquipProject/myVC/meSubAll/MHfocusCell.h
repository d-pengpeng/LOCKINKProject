//
//  MHfocusCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/11.
//

#import <UIKit/UIKit.h>
#import "MHVisitorModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MHfocusCellDelegate <NSObject>

- (void)MHfocusCellDelegateMEthodRow:(NSInteger)indPP;
- (void)MHfocusCellDelegateMEthodClickAvatorRow:(NSInteger)indPP;
@end

@interface MHfocusCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic, assign) id<MHfocusCellDelegate> delegate_;
- (void)addDataToModel:(MHVisitorModel *)modelM indeP:(NSInteger)row;
- (void)addDataToFensiModel:(MHVisitorModel *)modelM indeP:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END
