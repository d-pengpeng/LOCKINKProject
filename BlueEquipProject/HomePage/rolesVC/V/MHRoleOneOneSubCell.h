//
//  MHRoleOneOneSubCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol roleOneModesDelegate <NSObject>

- (void)roleOneModesDelegateRow:(NSInteger)rowlL;

@end
@interface MHRoleOneOneSubCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, strong) UIView *placVV;
@property (nonatomic, assign) NSInteger rowMML;
@property (nonatomic, assign) id <roleOneModesDelegate> delegate_;
- (void)addModelToDataModel:(NSDictionary *)nameSt choseName:(NSInteger)chosN;
@end

NS_ASSUME_NONNULL_END
