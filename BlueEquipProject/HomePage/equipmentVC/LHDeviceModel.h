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

/// 当前语言下的显示名（zh/en 优先，找不到 fallback 到 self.name）
- (NSString *)displayName;

@end

NS_ASSUME_NONNULL_END
