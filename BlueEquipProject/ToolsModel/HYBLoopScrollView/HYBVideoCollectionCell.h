//
//  HYBVideoCollectionCell.h
//  yunbaolive
//
//  Created by Edwin on 2023/2/20.
//  Copyright © 2023 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HYBVideoCollectionCellBlock)(BOOL boo, float fl_num, float fl_all);
typedef void(^HYBVideoCollecCBooBlock)(BOOL boo);
typedef void(^HYBVideoCollecCFullBooBlock)(void);
@interface HYBVideoCollectionCell : UICollectionViewCell

@property (nonatomic, copy) HYBVideoCollectionCellBlock block_;
@property (nonatomic, copy) HYBVideoCollecCBooBlock twoblock_;
@property (nonatomic, copy) HYBVideoCollecCFullBooBlock thrblock_;

@property (nonatomic, copy) NSString *video_url;
- (void)addUIUIDic:(NSDictionary *)dicDic;

- (void)pauseResumeVideoBoo:(BOOL)boo;

- (void)stopVideoBoo;

- (void)seeToFloatMehtod:(CGFloat)fl_see;
@end

NS_ASSUME_NONNULL_END
