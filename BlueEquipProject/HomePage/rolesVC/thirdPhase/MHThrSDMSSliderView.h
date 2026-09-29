//
//  MHThrSDMSSliderView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^MHThrSDMSSliderVBlock)(NSString *oneNum, NSString *twoNum);
typedef void(^MHThrSDMSSliderVTwoBlock)(BOOL isBoo);

@interface MHThrSDMSSliderView : UIView

@property (nonatomic, strong) UIImageView *leftBtn;
@property (nonatomic, strong) UIImageView *rigBtn;
@property (nonatomic, strong) UIButton *leftBtnsub;
@property (nonatomic, strong) UIButton *rigBtnsub;
@property (nonatomic, strong) UIView *slidVVV;
@property (nonatomic, assign) CGPoint lastPointInSuperView;

@property (nonatomic, assign) int typeN;
@property (nonatomic, assign) BOOL isboo_boo;
@property (nonatomic, copy) MHThrSDMSSliderVBlock block_;
@property (nonatomic, copy) MHThrSDMSSliderVTwoBlock twoBlock_;

- (void)addLeftStr:(int)leftStr righStr:(int)rigStr;
- (void)uploadMethodtagboo;
@end


@interface MHThrSDMSSliderView_one : UIView

@property (nonatomic, strong) UIImageView *leftBtn;
@property (nonatomic, strong) UIView *slidVVV;
@property (nonatomic, assign) CGPoint lastPointInSuperView;
@property (nonatomic, assign) int sel_val;
@property (nonatomic, assign) BOOL isboo_boo;
@property (nonatomic, copy) MHThrSDMSSliderVBlock block_;
@property (nonatomic, copy) MHThrSDMSSliderVTwoBlock twoBlock_;

- (void)addLeftStr:(int)leftStr;
- (void)uploadMethodtagboo;
@end

NS_ASSUME_NONNULL_END
