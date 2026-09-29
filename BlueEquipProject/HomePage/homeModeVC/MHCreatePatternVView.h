//
//  MHCreatePatternVView.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CreatePatternVVDelegate <NSObject>

- (void)MHCreatePatternVVDelegateMMM;
@end
@interface MHCreatePatternVView : UIView

@property (nonatomic, assign) id<CreatePatternVVDelegate> delegate_;
@property (nonatomic, assign) BOOL isBooL;
@property (nonatomic, assign) BOOL isBooL2;

@property (nonatomic, assign) CGFloat point_YY;
@property (nonatomic, assign) CGFloat point_YY2;
@property (nonatomic, assign) CGFloat point_YY3;
@property (nonatomic, assign) CGFloat point_YY4;

@property (nonatomic, assign) CGFloat point2_YY;
@property (nonatomic, assign) CGFloat point2_YY2;
@property (nonatomic, assign) CGFloat point2_YY3;
@property (nonatomic, assign) CGFloat point2_YY4;

@property (nonatomic, copy) NSString *devicTyp;

- (void)addUIUIUIUType:(NSInteger)typeM;
- (void)stopMethodUI;

- (CGFloat)getPointYYTwo; //旋转
- (CGFloat)getPointYY; //电击

- (void)hiddenShowMMMMMM:(BOOL)isbb;

- (void)chuShiHuaUIUI;

- (void)luoMethodokok;

- (void)setPatternMethodOne:(int)oneFF two:(int)twoFF;

@end

NS_ASSUME_NONNULL_END
