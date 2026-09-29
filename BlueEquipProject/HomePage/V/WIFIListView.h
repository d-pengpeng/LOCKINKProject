//
//  WIFIListView.h
//  MachineGlory
//
//  Created by Edwin on 2021/8/21.
//  Copyright © 2021 time. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WIFIListViewBlock)(NSInteger typeN, NSString *isStrM);
@interface WIFIListView : UIView

@property (nonatomic, copy) WIFIListViewBlock block_;
- (void)addDataList:(NSArray *)arr choseArr:(NSArray *)chosArr rowN:(NSArray *)rowN;

- (void)isBBLEBooMehtodBoo:(BOOL)isBBLEBoo;
@end

NS_ASSUME_NONNULL_END
