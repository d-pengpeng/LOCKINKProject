//
//  MHfindChooseView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^findChooseVBlock)(NSArray *arrList);
@interface MHfindChooseView : UIView

@property (nonatomic, copy) findChooseVBlock block_;
@property (nonatomic, strong) NSArray *arrFind;
@property (nonatomic, strong) NSArray *arrFind2;
- (void)addUIUIU;
@end

NS_ASSUME_NONNULL_END
