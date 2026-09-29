//
//  choosePickerView.h
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2021/6/26.
//  Copyright © 2021 time. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^choosePickerViewBlock)(NSString *name);
@interface choosePickerView : UIView

@property (nonatomic, copy) choosePickerViewBlock block_;
- (void)addChooseDataToArr:(NSArray *)arr;
@end

NS_ASSUME_NONNULL_END
