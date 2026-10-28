//
//  MHBehaviorReporter.h
//  BlueEquipProject
//
//  用户行为上报 —— POST /behavior/report
//  文档：behavior/report 接口 v1.1 2026-10-28
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Event Types

/// 事件 type 常量
FOUNDATION_EXPORT NSString *const MHBTApp;     // app 生命周期
FOUNDATION_EXPORT NSString *const MHBTPage;    // page 页面/曝光
FOUNDATION_EXPORT NSString *const MHBTAction;   // action 功能操作
FOUNDATION_EXPORT NSString *const MHBTFlow;    // flow 流程步骤
FOUNDATION_EXPORT NSString *const MHBTError;   // error 失败
FOUNDATION_EXPORT NSString *const MHBTPerf;     // perf 性能

#pragma mark - Reporter

@interface MHBehaviorReporter : NSObject

/// 单例
+ (instancetype)shared;

#pragma mark - 初始化（AppDelegate didFinishLaunching 调用）

/// 启动 reporter：生成/恢复 clientId、sessionId、启动定时 flush
- (void)start;

#pragma mark - 会话管理

/// 标记前后台切换（AppDelegate 调用）
- (void)markAppForeground;
- (void)markAppBackground;

#pragma mark - 核心上报 API

/**
 *  上报一条事件（自动加入 batch 队列）
 *  @param type     事件 type：app / page / action / flow / error / perf
 *  @param key      事件名（如 page_view / login_success）
 *  @param page     当前页面类名（可传 NSStringFromClass）
 *  @param fromPage 来源页面类名（可空）
 *  @param targetType  对象类型（可空，如 user/device/group）
 *  @param targetId    对象 ID（可空）
 *  @param ext      扩展字典（可空，序列化后 ≤ 1024 字节）
 *  @param result   1=成功(default) 2=失败
 *  @param errorCode 失败业务码（可空）
 *  @param durationMs 停留毫秒（page_leave 用，可空）
 *  @param costMs   耗时毫秒（接口/连接/启动，可空）
 */
- (void)trackWithType:(NSString *)type
                  key:(NSString *)key
                 page:(nullable NSString *)page
             fromPage:(nullable NSString *)fromPage
           targetType:(nullable NSString *)targetType
             targetId:(nullable NSString *)targetId
                  ext:(nullable NSDictionary *)ext
               result:(NSInteger)result
             errorCode:(nullable NSString *)errorCode
            durationMs:(nullable NSNumber *)durationMs
               costMs:(nullable NSNumber *)costMs;

/// 便捷：只有 type + key + ext
- (void)trackWithType:(NSString *)type key:(NSString *)key ext:(nullable NSDictionary *)ext;

/// 便捷：action 事件（简版）
- (void)trackAction:(NSString *)key page:(nullable NSString *)page ext:(nullable NSDictionary *)ext;

/// 便捷：action 事件（完整版，fromPage/targetType/targetId 可传）
- (void)trackAction:(NSString *)key
               page:(nullable NSString *)page
           fromPage:(nullable NSString *)fromPage
         targetType:(nullable NSString *)targetType
           targetId:(nullable NSString *)targetId
                ext:(nullable NSDictionary *)ext;

/// 便捷：page_view
- (void)trackPageView:(NSString *)page fromPage:(nullable NSString *)fromPage;

/// 便捷：page_leave
- (void)trackPageLeave:(NSString *)page durationMs:(NSInteger)durationMs;

/// 便捷：error
- (void)trackError:(NSString *)key ext:(nullable NSDictionary *)ext;

/// 便捷：perf
- (void)trackPerf:(NSString *)key costMs:(NSInteger)costMs ext:(nullable NSDictionary *)ext;

#pragma mark - 立即 flush

/// 立即上报（切后台/紧急情况）
- (void)flushNow;

#pragma mark - 仅供内部：生成 UUID
+ (NSString *)uuidString;

@end

NS_ASSUME_NONNULL_END
