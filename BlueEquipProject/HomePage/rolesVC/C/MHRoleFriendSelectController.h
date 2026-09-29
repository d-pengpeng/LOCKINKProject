//
//  MHRoleFriendSelectController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/17.
//

#import "eBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^FriendSelectBlock)(NSString *userId, NSString *avatorStr, NSString *nickN);
@interface MHRoleFriendSelectController : eBaseViewController

@property (nonatomic, copy) FriendSelectBlock block_;
@property (nonatomic, assign) BOOL isHeBoo;
@property (nonatomic, copy) NSString *typeMM;
@property (nonatomic, copy) NSString *deviceId;
@property (nonatomic, copy) NSString *typeId;

@end

NS_ASSUME_NONNULL_END
