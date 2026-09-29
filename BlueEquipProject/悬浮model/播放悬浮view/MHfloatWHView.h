//
//  MHfloatWHView.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MHfloatWHViewwDelegate <NSObject>

- (void)FloatingWViewDelegateMethod;
- (void)FloatingWViewDelegateMethodYyyy:(CGFloat)y_y isLeftRig:(BOOL)isLefRig;
@end
@interface MHfloatWHView : UIView
@property (nonatomic, assign) id<MHfloatWHViewwDelegate> delegate_;
@property (nonatomic, assign) CGPoint lastPointInSelf;
@property (nonatomic, assign) CGPoint lastPointInSuperView;
@end

NS_ASSUME_NONNULL_END
