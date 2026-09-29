//
//  MHNewDrawingView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^eNewDrawingViewBlock)(void);
@interface MHNewDrawingView : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat point_YY;
@property (nonatomic, assign) CGFloat point_YY2;
@property (nonatomic, assign) CGFloat point_YY3;
@property (nonatomic, assign) CGFloat point_YY4;

@property (nonatomic, assign) CGFloat point2_YY;
@property (nonatomic, assign) CGFloat point2_YY2;
@property (nonatomic, assign) CGFloat point2_YY3;
@property (nonatomic, assign) CGFloat point2_YY4;

@property (nonatomic, assign) BOOL point_boo;
@property (nonatomic, assign) BOOL point_boo2;

@property(nonatomic,strong) NSMutableArray *pointMutY;
@property(nonatomic,strong) NSMutableArray *pointMutYPath;
@property(nonatomic,strong) NSMutableArray *pointMutAr;
@property (nonatomic, copy) eNewDrawingViewBlock block_;

@property (nonatomic, assign) BOOL isShowImg;
@property (nonatomic, assign) BOOL isShowImg2;

- (CGFloat)getPointYYTwo; //旋转
- (CGFloat)getPointYY; //电击

- (void)clean;
//回退
- (void)undo;
@end

NS_ASSUME_NONNULL_END
