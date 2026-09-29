//
//  communityTHDetailInputView.h
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/12/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^communityTHDetailInputVBlock)(NSInteger tyepN, NSString *nameS);
@interface communityTHDetailInputView : UIView

@property (nonatomic, strong) UITextField *input_textF;
@property (nonatomic, strong) UIButton *photo_Btn;
@property (nonatomic, strong) UIButton *video_Btn;
@property (nonatomic, strong) UIButton *face_Btn;
@property (nonatomic, assign) BOOL isTwoMsg;
@property (nonatomic, copy) communityTHDetailInputVBlock block_;

- (void)addImgsArr:(NSArray *)arrImgs video:(NSArray *)arrVideo;
@end

NS_ASSUME_NONNULL_END
