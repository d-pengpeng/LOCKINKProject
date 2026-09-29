//
//  MHRecordingAuthenticationController.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/22.
//

#import "eBaseViewController.h"
#import "MHRoleOneModel.h"
#import "MHDeviceListMsgModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^RecordingAuthentiBLock)(void);
@interface MHRecordingAuthenticationController : eBaseViewController

@property (nonatomic, copy) RecordingAuthentiBLock block_;
@property (nonatomic, strong) MHRoleOneModel *roleOneModel;
@property (nonatomic, strong) MHDeviceListMsgModel *msgModel;
@property (nonatomic, copy) NSString *accepted_str;

@property (nonatomic, assign) BOOL isRecivBoo;

@property (nonatomic, assign) BOOL isRecivBoo2;
@end

NS_ASSUME_NONNULL_END
