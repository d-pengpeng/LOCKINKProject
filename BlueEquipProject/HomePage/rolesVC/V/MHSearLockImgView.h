//
//  MHSearLockImgView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SearLockImgVBlock)(NSInteger numTyp);
@interface MHSearLockImgView : UIView

@property (nonatomic, copy) SearLockImgVBlock block_;
@property (nonatomic, assign) BOOL isAppleMapBoo;
- (void)addListArr:(NSArray *)arr coor:(CLLocationCoordinate2D)coor;
@end

NS_ASSUME_NONNULL_END
