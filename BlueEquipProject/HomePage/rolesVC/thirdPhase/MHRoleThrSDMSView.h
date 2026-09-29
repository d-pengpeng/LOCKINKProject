//
//  MHRoleThrSDMSView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MHRoleThrSDMSVBlock)(NSInteger selNumk, BOOL isBoo);
@interface MHRoleThrSDMSView : UIView

@property (nonatomic, copy) MHRoleThrSDMSVBlock block_;
@property (nonatomic, assign) int sel_row;
- (void)addUploadUIUIMethod;
@end


typedef void(^MHFourthChannelJDBXBlock)(NSMutableArray *listArr, BOOL isBoo);
@interface MHFourthChannelJDBXView : UIView

@property (nonatomic, copy) MHFourthChannelJDBXBlock block_;
@property (nonatomic, strong) NSMutableArray *listArr;
@property (nonatomic, assign) int playNumb;
- (void)addDataUploadUIUIMethod:(BOOL) isChannelA;
@end


@protocol MHFourthChannelJDBXCelDelaget <NSObject>

-(void)FourthChannelJDBX:(NSInteger)typeN indexPath:(NSIndexPath *)indexPath;
@end
@interface MHFourthChannelJDBXCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;
@property (nonatomic, assign) id<MHFourthChannelJDBXCelDelaget> delegate_;
@property (nonatomic, strong) NSIndexPath *indPax;
@property (nonatomic, assign) BOOL isPlayb;
- (void)addDataToDic:(NSString *)model;

@end


NS_ASSUME_NONNULL_END
