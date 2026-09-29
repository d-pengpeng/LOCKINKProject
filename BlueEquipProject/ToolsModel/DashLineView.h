//
//  DashLineView.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/10/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DashLineView : UIView

- (instancetype)initWithFrame:(CGRect)frame withLineLength:(NSInteger)lineLength withLineSpacing:(NSInteger)lineSpacing withLineColor:(UIColor *)lineColor;
@end

NS_ASSUME_NONNULL_END
