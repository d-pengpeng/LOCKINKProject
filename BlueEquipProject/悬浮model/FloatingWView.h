//
//  FloatingWView.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FloatingWView : UIView

@property (nonatomic, copy) void(^FloatingWVieweBLock)(NSString *strLLLL);
@property (nonatomic, assign) CGPoint lastPointInSelf;
@property (nonatomic, assign) CGPoint lastPointInSuperView;

@property (nonatomic, assign) CGFloat x_lef;
@property (nonatomic, assign) CGFloat x_boundary;
@property (nonatomic, assign) CGFloat y_boundary;

- (void)uploadPointMM:(CGPoint)point;
@end

NS_ASSUME_NONNULL_END
