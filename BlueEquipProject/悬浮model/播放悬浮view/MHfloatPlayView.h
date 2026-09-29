//
//  MHfloatPlayView.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MHfloatPlayViewwDelegate <NSObject>

- (void)floatingPlayLivingViewDelegateDeleteMethod;

@end
@interface MHfloatPlayView : UIView

@property (nonatomic, assign) id<MHfloatPlayViewwDelegate> delegate_;
@property (nonatomic, copy) NSString *pullUr;
@property (nonatomic, strong) UIImageView *DDDbtn;
@end

NS_ASSUME_NONNULL_END
