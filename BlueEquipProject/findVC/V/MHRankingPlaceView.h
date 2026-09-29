//
//  MHRankingPlaceView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RankingPlaceVBlock)(BOOL isBBB);
@interface MHRankingPlaceView : UIView

@property (nonatomic, copy) RankingPlaceVBlock block_;
@property (nonatomic, copy) NSString *nickNam;
- (void)addDataToDic:(NSInteger)Typ;

- (void)addFourthDataToDic:(NSInteger)Typ;
- (void)addFourthDataToDicTypeNum:(NSInteger)Typ;

- (void)addIMMsgDataToTag:(NSInteger)Typ;

@end

NS_ASSUME_NONNULL_END
