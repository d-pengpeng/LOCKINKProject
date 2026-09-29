//
//  myMergeMessageListController.h
//  BlueEquipProject
//
//  Created by Edwin on 2023/12/28.
//

#import "eBaseViewController.h"
#import "TUIDefine.h"
#import "TUIMessageControllerDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface myMergeMessageListController : eBaseViewController
@property (nonatomic, weak) id<TUIMessageControllerDelegate> delegate;
@property (nonatomic, strong) V2TIMMergerElem *mergerElem;
@property (nonatomic, copy) dispatch_block_t willCloseCallback;


@end

NS_ASSUME_NONNULL_END
