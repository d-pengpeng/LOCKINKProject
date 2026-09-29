//
//  MHRoleConnectView.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RoleConnectVBlock)(BOOL isBBB);
@interface MHRoleConnectView : UIView

@property (nonatomic, copy) RoleConnectVBlock block_;
-(void)addUIUIUIUIType:(NSInteger)typNum;
@end

NS_ASSUME_NONNULL_END
