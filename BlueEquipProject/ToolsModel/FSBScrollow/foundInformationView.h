//
//  foundInformationView.h
//  Greens
//
//  东莞梦幻网络科技有限公司 注 on 2021/6/9.
//  Copyright © 2021 SoulZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^rigthAllBlock)(NSInteger type, NSInteger num);
@interface foundInformationView : UIView

@property (nonatomic, copy) rigthAllBlock block_;

@property (nonatomic, assign) BOOL isScrollBoo;
- (void)addVIdeoTopTitleMethodDataToDic:(NSArray *)arrDics;
- (void)changeVIdeoTopTitleXIndex:(NSInteger)num;

- (void)addGuideTopTitleMethodDataToDic:(NSArray *)arrDics;
- (void)changeGuideTitleXIndex:(NSInteger)num;

- (void)stopOrStartUIMehtod:(BOOL)isBoo;
@end

NS_ASSUME_NONNULL_END
