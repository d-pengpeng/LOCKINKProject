//
//  eDrawingView.h
//  beijing
//
//  Created by Edwin on 2020/10/8.
//  Copyright © 2020 zhou last. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^eDrawingViewBlock)(NSArray *arrMM);
@interface eDrawingView : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat point_YY;
@property (nonatomic, assign) CGFloat point_YY2;
@property (nonatomic, assign) CGFloat point_YY3;
@property (nonatomic, assign) CGFloat point_YY4;
@property(nonatomic,strong) NSMutableArray *pointMutY;
@property(nonatomic,strong) NSMutableArray *pointMutYPath;
@property(nonatomic,strong) NSMutableArray *pointMutAr;
@property (nonatomic, copy) eDrawingViewBlock block_;

@property (nonatomic, assign) BOOL isShowImg;

- (CGFloat)getPointYY;

- (void)clean;
//回退
- (void)undo;

@end

NS_ASSUME_NONNULL_END
