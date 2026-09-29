//
//  MHRoleTwoSDDJStartView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^MHRoleTwoSDDJStartVBlock)(void);
@interface MHRoleTwoSDDJStartView : UIView
@property (nonatomic, strong) UIButton *play_Btn;
@property (nonatomic, copy) MHRoleTwoSDDJStartVBlock block_;

- (void)addBXUploadMethod;

- (int)getPlayFFFHHH;
@end

NS_ASSUME_NONNULL_END
