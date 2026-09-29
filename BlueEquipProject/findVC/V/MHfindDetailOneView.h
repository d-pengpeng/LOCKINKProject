//
//  MHfindDetailOneView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import <UIKit/UIKit.h>
#import "MHfindSubPatternsModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MHfindDetailOneViewDelaget <NSObject>

-(void)focusOrGoodOrComment:(NSInteger)typeN indexPath:(NSIndexPath *)indexPath;
- (void)fileClick:(NSArray *)array row:(NSInteger)row indexPath:(NSIndexPath *)indexPath;
- (void)findDetailUploadMethod;
@end
@interface MHfindDetailOneView : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<MHfindDetailOneViewDelaget> delegate_;
- (void)addDataToDic:(MHfindSubPatternsModel *)model row:(NSIndexPath *)rowL dicDetail:(NSDictionary *)detailDci;

@end

NS_ASSUME_NONNULL_END
