//
//  MHOthrMyController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/13.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^otherMyCVCVBLock)(void);
@interface MHOthrMyController : eBaseViewController

@property (nonatomic, copy) otherMyCVCVBLock block_;
@property (nonatomic, copy) NSString *otherId;
@end

NS_ASSUME_NONNULL_END
