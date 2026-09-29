//
//  YBWebViewController.h
//  live1v1
//
//  Created by IOS1 on 2019/3/30.
//  Copyright © 2019 IOS1. All rights reserved.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBWebViewController : eBaseViewController
@property (nonatomic,strong) NSString *urls;
@property (nonatomic,assign) BOOL isGuide;
@property(nonatomic,strong)NSString *titles;

@end

NS_ASSUME_NONNULL_END
