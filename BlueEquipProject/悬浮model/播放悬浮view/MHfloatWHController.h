//
//  MHfloatWHController.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/28.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FloatingWHHDelegate <NSObject>

- (void)FloatingWCCDelegateFloatingWindowHidden;

@end
@interface MHfloatWHController : eBaseViewController
@property (nonatomic, assign) id<FloatingWHHDelegate> delegate_;
@property (nonatomic, copy) NSString *pullUr;

//数据
@property (nonatomic, strong) NSArray *pArrList;
@property (nonatomic, assign) NSInteger pRowL;
@property (nonatomic, assign) NSInteger spedRow;
@property (nonatomic, assign) int playTNum;
@property (nonatomic, assign) BOOL isPlayLis;
@property (nonatomic, copy) NSString *id_id;

@property (nonatomic, assign) BOOL isMusicPlay;

- (void)showVC;
- (void)dismissVC;
- (void)dismissVCTwo;
@end

NS_ASSUME_NONNULL_END
