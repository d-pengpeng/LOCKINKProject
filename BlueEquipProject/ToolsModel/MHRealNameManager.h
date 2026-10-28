//
//  MHRealNameManager.h
//  BlueEquipProject
//
//  进入 IM 前查询实名状态 / 提交实名认证
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 实名认证状态码（与后端约定）
typedef NS_ENUM(NSInteger, MHRealNameStatus) {
    MHRealNameStatusUnknown  = -1,
    MHRealNameStatusPending  = 0,  // 待审核
    MHRealNameStatusApproved = 1,  // 通过
    MHRealNameStatusRejected = 2,  // 驳回
    MHRealNameStatusNone     = 3,  // 未提交
};

@interface MHRealNameInfo : NSObject
@property (nonatomic, assign) BOOL required;
@property (nonatomic, assign) MHRealNameStatus status;
@property (nonatomic, copy)   NSString *statusText;
@property (nonatomic, copy)   NSString *idCardMasked;
@property (nonatomic, copy)   NSString *rejectReason;
@property (nonatomic, copy, nullable) NSString *submitTime;
@property (nonatomic, copy, nullable) NSString *auditTime;
@end

typedef void(^MHRealNameStatusBlock)(BOOL required, MHRealNameStatus status, MHRealNameInfo * _Nullable info, NSError * _Nullable error);

@interface MHRealNameManager : NSObject

+ (instancetype)shared;

/// 查询实名状态（2.1 接口）
- (void)fetchStatus:(MHRealNameStatusBlock)completion;

/// 返回上次成功查询到的状态（同步，可能为 MHRealNameStatusUnknown）
- (MHRealNameStatus)cachedStatus;

/// 获取未实名提示文案（2.3 接口）
- (void)fetchPrompt:(void(^)(NSString * _Nullable text, NSError * _Nullable error))completion;

/// 提交实名认证（2.2 接口）
- (void)submitWithRealName:(NSString *)realName
                 idCardNo:(NSString *)idCardNo
                    phone:(nullable NSString *)phone
                idCardFront:(NSString *)frontURL
                idCardBack:(NSString *)backURL
                completion:(void(^)(BOOL success, MHRealNameStatus status, NSString * _Nullable msg, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
