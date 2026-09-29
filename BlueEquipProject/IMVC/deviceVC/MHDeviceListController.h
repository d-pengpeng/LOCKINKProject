//
//  MHDeviceListController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/22.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^deviceListBlock)(int numLL);
@interface MHDeviceListController : eBaseViewController

@property (nonatomic, copy) deviceListBlock block_;
@end

NS_ASSUME_NONNULL_END
