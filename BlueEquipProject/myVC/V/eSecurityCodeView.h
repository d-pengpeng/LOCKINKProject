//
//  eSecurityCodeView.h
//  MachineGlory
//
//  Created by Edwin on 2021/2/4.
//  Copyright © 2021 time. All rights reserved.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^eSecurityCodeVBlock)(NSInteger num);
@interface eSecurityCodeView : eBaseViewController

@property (nonatomic, copy) eSecurityCodeVBlock eSecurityCodBlock;

@property (nonatomic, assign) BOOL isSetting;
@end

NS_ASSUME_NONNULL_END
