//
//  myBlackListController.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/30.
//

#import "eBaseViewController.h"
#import "TUICommonContactCell.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^blackListBlock)(TUICommonContactCell *cell);
@interface myBlackListController : eBaseViewController

@property (nonatomic, copy) blackListBlock black_;
@end

NS_ASSUME_NONNULL_END
