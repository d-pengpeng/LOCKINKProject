//
//  MHLimitsAuthorityView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LimitsAuthorityBlock)(void);
@interface MHLimitsAuthorityView : UIView

@property (nonatomic, assign) int startNum;
@property (nonatomic, assign) int stopNum;
@property (nonatomic, assign) BOOL wwwhhhBoo;
@property (nonatomic, copy) LimitsAuthorityBlock block_;
@property (nonatomic, copy) LimitsAuthorityBlock twoblock_;
- (void)addLimitsAuthorityUIUI:(NSInteger)tyepMM;
- (void)addTwoLimitsAuthorityUIUI:(NSInteger)tyepMM;
@end

NS_ASSUME_NONNULL_END
