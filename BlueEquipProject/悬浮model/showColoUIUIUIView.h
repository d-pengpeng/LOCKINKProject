//
//  showColoUIUIUIView.h
//  testPayProject
//
//  Created by Edwin on 2023/8/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface showColoUIUIUIView : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *placeColor;
@property(nonatomic,strong) NSMutableArray *pointMutAr;
@property(nonatomic,strong) NSMutableArray *pointMutAr2;

@property(nonatomic,strong) NSMutableArray *pathMut;
@property(nonatomic,strong) NSMutableArray *pathMut2;
@property(nonatomic,strong) NSMutableArray *pathMut_2;
@property(nonatomic,strong) NSMutableArray *pathMut2_2;
@property (nonatomic, assign) int numPag;
@property (nonatomic, assign) int HH_H;
@property (nonatomic, assign) BOOL isShowCirc;
@property (nonatomic, assign) BOOL isCreateB;
@property (nonatomic, assign) int wid_num;
@property (nonatomic, strong) UIView *poVVVV;

@property (nonatomic, assign) BOOL isfinallyB;
@property (nonatomic, assign) int row_int;
- (void)addDataToArr:(NSArray *)arr;
- (void)addDataPlaceToArr:(NSArray *)arr;

- (void)clearArrMethod;
@end

NS_ASSUME_NONNULL_END
