//
//  MHfloatShowView.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MHfloatShowVBLock)(NSInteger typeL, BOOL isBoo);
@interface MHfloatShowView : UIView
//数据
@property (nonatomic, strong) NSArray *pArrList;
@property (nonatomic, assign) NSInteger pRowL;
@property (nonatomic, assign) NSInteger spedR;
@property (nonatomic, assign) int playTNum;
@property (nonatomic, assign) BOOL isPlayLis;
@property (nonatomic, copy) NSString *id_id;
@property (nonatomic, copy) MHfloatShowVBLock block_;

- (instancetype)initWithFrame:(CGRect)frame ArrLis:(NSArray *)arlist rowL:(NSInteger)rowN playT:(int)playTT sped:(NSInteger)spedN;

- (instancetype)initWithFrame:(CGRect)frame isMusicPlay:(BOOL)boo;

- (void)ddBBMethodsTwoMMMMM;

- (void)ddBBMethodsThrBoo:(BOOL)isBBB;

- (void)uploadYyy:(CGFloat)yYY LeftRig:(BOOL)isLef;
@end

NS_ASSUME_NONNULL_END
