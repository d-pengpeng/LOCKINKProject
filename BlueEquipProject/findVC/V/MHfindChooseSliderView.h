//
//  MHfindChooseSliderView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHfindChooseSliderView : UIView

@property (nonatomic, strong) UIImageView *leftBtn;
@property (nonatomic, strong) UIImageView *rigBtn;

@property (nonatomic, strong) UIButton *leftBtnsub;
@property (nonatomic, strong) UIButton *rigBtnsub;

@property (nonatomic, strong) UIView *slidVVV;

- (NSArray *)getStartToEnd;

- (void)addLeftStr:(int)leftStr righStr:(int)rigStr;
@end

NS_ASSUME_NONNULL_END
