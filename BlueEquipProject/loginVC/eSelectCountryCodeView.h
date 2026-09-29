//
//  eSelectCountryCodeView.h
//  yunbaolive
//
//  东莞梦幻网络科技有限公司 注 on 2021/5/8.
//  Copyright © 2021 cat. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^eSelectCountryCodeVBlock)(NSString *code);
@interface eSelectCountryCodeView : UIView

@property (nonatomic, copy) eSelectCountryCodeVBlock eSelectBlock;
@end

NS_ASSUME_NONNULL_END
