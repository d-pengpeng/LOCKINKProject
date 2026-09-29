//
//  MHshowColoUITwoView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHshowColoUITwoView : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property(nonatomic,strong) NSMutableArray *pointMutAr;
@property(nonatomic,strong) NSMutableArray *pointMutAr2;

@property(nonatomic,strong) NSMutableArray *pathMut;
@property(nonatomic,strong) NSMutableArray *pathMut2;

@property (nonatomic, assign) int HH_H;
@property (nonatomic, assign) int row_int;
- (void)addDataToArr:(NSArray *)arr;

- (void)clearArrMethod;
@end

NS_ASSUME_NONNULL_END
