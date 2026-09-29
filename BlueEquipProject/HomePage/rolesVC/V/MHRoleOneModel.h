//
//  MHRoleOneModel.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHRoleOneModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *mac;
@property (nonatomic, copy) NSString *currRole;
@property (nonatomic, assign) BOOL matchingCompleted;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, copy) NSString *master;
@property (nonatomic, copy) NSString *masterProfile;
@property (nonatomic, copy) NSString *masterNickName;
@property (nonatomic, copy) NSString *servant;
@property (nonatomic, copy) NSString *servantProfile;
@property (nonatomic, copy) NSString *servantNickName;
@property (nonatomic, assign) int remainingCharge;
@property (nonatomic, assign) BOOL timeLockEnabled; //是否开启定时锁
@property (nonatomic, copy) NSString *timeLockReleaseTime;
@property (nonatomic, assign) int timeLockReleaseSeconds;
@property (nonatomic, assign) int timeLockReleaseVoltage;
@property (nonatomic, strong) NSArray *timeVoucherList;
@property (nonatomic, assign) BOOL revokePermission; //是否没收佩戴者权限
@property (nonatomic, assign) BOOL devicePublic;
@property (nonatomic, assign) BOOL locationLockEnabled;
@property (nonatomic, copy) NSString *locationLockUnlockLatitude;
@property (nonatomic, copy) NSString *locationLockUnlockLongitude;
@property (nonatomic, copy) NSString *locationSERVANTLatitude;
@property (nonatomic, copy) NSString *locationSERVANTLongitude;
@property (nonatomic, assign) int locationLockUnlockRangeInKm;
@property (nonatomic, assign) int monthlyForcedUnlockTimes;
@property (nonatomic, strong) NSArray *forcedUnlockPenaltyList;
@property (nonatomic, strong) NSArray *forcedUnbindPenaltyList;
@property (nonatomic, assign) BOOL isPenalty; //判断是否处于开锁惩罚中
@property (nonatomic, copy) NSString *penaltyReleaseTime;
@property (nonatomic, strong) NSArray *scheduledElectricShockLogList;
@property (nonatomic, assign) BOOL hardcoreModeEnabled; //是否开启硬核模式
@property (nonatomic, assign) BOOL isForcedUnbindPenalty;
@property (nonatomic, assign) int monthlyForcedUnbindTimes;
@property (nonatomic, copy) NSString *forcedUnbindPenaltyReleaseTime;
@property (nonatomic, assign) BOOL shortTermPermissionTransfer;
@property (nonatomic, assign) BOOL existsUnExecutedVote;
@property (nonatomic, strong) NSArray *deleteLockRecordPenaltyList;
@property (nonatomic, assign) int monthlyDeleteLockRecordTimes;
@property (nonatomic, assign) BOOL lockEnabled; //是否开启即时锁
@property (nonatomic, assign) BOOL allowOpenHardcoreMode; //是否允许打开硬核模式
@property (nonatomic, strong) NSDictionary *locationLockInfo;
@property (nonatomic, copy) NSString *locationLockRecordId;
@property (nonatomic, assign) int masterConnectStatus; //主人设备连接状态 1.连接 2.断开
@property (nonatomic, assign) int servantConnectStatus; //佩戴者设备连接状态 1.连接 2.断开
@property (nonatomic, assign) BOOL allowServantUnlock; //是否允许佩戴者开锁 true:允许 false:
@property (nonatomic, assign) BOOL isDeleteLockRecordPenalty;  //判断是否处于强制删除开锁记
@end

NS_ASSUME_NONNULL_END
