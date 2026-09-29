//
//  FloatingWController.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^FloatingWCBlock)(void);
@interface FloatingWController : UIViewController

@property (nonatomic, copy) void(^FloatingWCCCCVieweBLock)(NSString *strLLLL);
@property (nonatomic, strong) UIViewController *selfVVC;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, assign) CGFloat x_lef;
@property (nonatomic, copy) FloatingWCBlock block_;
@property (nonatomic, assign) CGFloat x_boundary;
@property (nonatomic, assign) CGFloat y_boundary;

- (void)uploadPointMethod:(CGPoint)pointS img:(NSString *)imgNam;
- (void)uploadImgMEhodname:(NSString *)img;

- (void)showVC;
- (void)showVCTwoMethod;

- (void)botmUIUIUBoo:(BOOL)booM;

- (void)clearUIVC;

- (void)hiddenShowMMmehtodUIUIBoo:(BOOL)isbb;

- (void)uploadPointFiveSevenMethod:(CGPoint)pointS;
@end

NS_ASSUME_NONNULL_END
