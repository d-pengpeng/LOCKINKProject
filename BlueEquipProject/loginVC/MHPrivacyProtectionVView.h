//
//  MHPrivacyProtectionVView.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PrivacyProtectionVBlock)(NSInteger typ);
@interface MHPrivacyProtectionVView : UIView

@property (nonatomic, copy) PrivacyProtectionVBlock block_;
@end

NS_ASSUME_NONNULL_END
