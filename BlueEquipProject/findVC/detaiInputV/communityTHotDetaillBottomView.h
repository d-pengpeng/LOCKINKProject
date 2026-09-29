//
//  communityTHotDetaillBottomView.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/12/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^communityTHotDetaillBottomVBlock)(NSInteger typeN);
@interface communityTHotDetaillBottomView : UIView

@property (nonatomic, strong) UIButton *rankBtn;
@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, copy) communityTHotDetaillBottomVBlock block_;

- (void)addUIUIType:(NSInteger)typeNM;

@end

NS_ASSUME_NONNULL_END
