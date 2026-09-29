//
//  MHVioceRecordView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^VioceRecordVBlock)(NSString *pathUrl, int oneIn, int twoIn);
@interface MHVioceRecordView : UIView

@property (nonatomic, copy) VioceRecordVBlock block_;
@property (nonatomic, copy) VioceRecordVBlock blockTwo_;
@end

NS_ASSUME_NONNULL_END
