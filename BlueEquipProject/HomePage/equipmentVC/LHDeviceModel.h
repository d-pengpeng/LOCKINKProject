//
//  LHDeviceModel.h
//  BlueEquipProject
//
//  蓝牙设备数据模型 —— 来自 /square/listProduct 的服务端返回
//  本地硬编码设备（PrefixHeader.pch 里的 kCharactName1..17）不经过此模型，
//  直接作为已知 model 字符串注册进 LHDeviceRegistry。
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHDeviceFunction : NSObject

@property (nonatomic, copy) NSString *code;   // e.g. "METHOD_ELECTRIC"
@property (nonatomic, copy) NSString *name;   // e.g. "电击模式"
@property (nonatomic, assign) int value;      // e.g. 1

+ (instancetype)modelWithJSON:(NSDictionary *)json;

@end

/// 推断出的蓝牙协议类型
typedef NS_ENUM(NSInteger, LHInferredProtocol) {
    LHInferredProtocolDefault = 0,  ///< 默认协议 kServiceUUID
    LHInferredProtocolQiui   = 1,  ///< Qiui 协议 kServiceQiuiUUID（电击按摩垫片专用）
};

/// 推断出的控制页路由
typedef NS_ENUM(NSInteger, LHInferredRoute) {
    LHInferredRouteUnknown      = 0, ///< 无法推断（应该走本地硬编码的 model）
    LHInferredRouteRoleOne      = 1, ///< MHRoleOneController（通用贞操锁/马眼棒/震动棒/肛塞）
    LHInferredRouteRoleOneLock  = 2, ///< MHRoleOneController 锁类（有 OPEN_LOCK/CLOSE_LOCK）
    LHInferredRouteFourthRole   = 3, ///< MHFourthRole（电击按摩垫片，无 ELECTRIC）
};

@interface LHDeviceModel : NSObject

+ (instancetype)modelWithJSON:(NSDictionary *)json;

/// 服务端 id
@property (nonatomic, assign) int deviceId;
/// 型号 = 蓝牙广播名（匹配用，e.g. "AA-A1017"）
@property (nonatomic, copy) NSString *model;
/// 默认名称（服务端给的）
@property (nonatomic, copy) NSString *name;
/// 图片 URL
@property (nonatomic, copy) NSString *img;
/// 本地化名称字典 { "zh": "...", "en": "..." }
@property (nonatomic, copy) NSDictionary *languages;
/// 支持的功能列表
@property (nonatomic, strong) NSArray<LHDeviceFunction *> *functions;

#pragma mark - 推断字段（从 functions 推断，无需后端额外下发）

/// 推断出的蓝牙协议（哪个 Service UUID）
@property (nonatomic, assign, readonly) LHInferredProtocol inferredProtocol;
/// 推断出的控制页路由
@property (nonatomic, assign, readonly) LHInferredRoute inferredRoute;
/// 是否需要暂停功能按钮
@property (nonatomic, assign, readonly) BOOL inferredPauseSupported;
/// 是否有开锁/关锁（贞操锁类）
@property (nonatomic, assign, readonly) BOOL inferredIsLockType;

/// 当前语言下的显示名（zh/en 优先，找不到 fallback 到 self.name）
- (NSString *)displayName;

/// 重新根据 functions 计算所有推断字段
/// （modelWithJSON: 自动调用；外部修改 functions 后手动调）
- (void)recalcInferredFields;

/// 判断此 model 是否在本地硬编码（PrefixHeader.pch kCharactName1..17）中
- (BOOL)isLocalKnownModel;

@end

NS_ASSUME_NONNULL_END
