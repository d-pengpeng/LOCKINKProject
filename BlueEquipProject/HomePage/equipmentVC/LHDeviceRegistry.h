//
//  LHDeviceRegistry.h
//  BlueEquipProject
//
//  蓝牙设备型号注册表（单例）
//
//  为什么需要它？
//  --------------
//  目前 SceneDelegate.m L304 有一个 17 个宏的超长 OR 链：
//    if (([perName isEqualToString:kCharactName] || [perName isEqualToString:kCharactName2] || ... || [perName isEqualToString:kCharactName17]) && peripheral)
//  本地加一个新型号要改 PrefixHeader + SceneDelegate。
//  服务端新增的型号（如 AA-A1017 樱桃肛塞）客户端完全识别不了。
//
//  现在把"哪些字符串是我认识的蓝牙设备名"这件事集中到这里：
//    1. init 时自动把 PrefixHeader.pch 里的所有 kCharactName* 宏注册进去（本地兜底）
//    2. +loadFromServer 拉 /square/listProduct，把服务端 model 合并进去（重复的 model 服务端覆盖）
//    3. isKnownModel: 替代 SceneDelegate 里的超长 OR 链
//
//  注意：本 registry 只管"型号识别"和"展示信息"。
//  控制页面路由（RoleOne / RoleThrJDMS / FourthRole）和蓝牙指令下发
//  后端还没下发协议，暂时保持原硬编码不动。
//

#import <Foundation/Foundation.h>
#import "LHDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString * const LHDeviceRegistryDidUpdateNotification;

@interface LHDeviceRegistry : NSObject

+ (instancetype)shared;

/// 当前已知型号集合（本地宏 + 服务端合并），用于扫描匹配
@property (nonatomic, strong, readonly) NSSet<NSString *> *knownModels;

/// 服务端返回的设备模型字典 { model: LHDeviceModel }
@property (nonatomic, strong, readonly) NSDictionary<NSString *, LHDeviceModel *> *serverModels;

/// 服务端上次拉取时间戳（本地缓存用）
@property (nonatomic, assign, readonly) NSTimeInterval lastServerFetchTime;

/// 判断某个广播名是不是我们认识的设备 → 替代 SceneDelegate 里的超长 OR 链
- (BOOL)isKnownModel:(NSString *)model;

/// 根据型号取设备模型（优先服务端，服务端没有返回 nil）
- (nullable LHDeviceModel *)deviceModelForModel:(NSString *)model;

/// 该型号是否支持某个功能（METHOD_BERSERK_MODE / METHOD_RANDOM_MODE ...）
/// 本地硬编码老设备默认返回 YES（保持原有 UI 不变）
/// 服务端新增型号严格按 functions 判断，没返回就是不支持
- (BOOL)model:(NSString *)model supportsFunctionCode:(NSString *)code;

/// 服务端新增的"玩具类"型号（非本地硬编码、非锁类、非 Qiui 协议）
/// 用于把它们并入 devicNameArr3，从而复用三期玩具控制页（经典模式/摇一摇/语音控制）
- (NSArray<NSString *> *)serverOnlyToyModels;

/// 从本地 UserDefaults 恢复服务端缓存（App 启动时先 restore 一次，再异步拉新）
- (void)restoreFromCache;

/// 拉 /square/listProduct 合并到 registry。
/// 成功后发 LHDeviceRegistryDidUpdateNotification，cache 持久化到 UserDefaults。
/// 失败不影响本地型号识别。
- (void)loadFromServerWithCompletion:(nullable void (^)(BOOL success))completion;

@end

NS_ASSUME_NONNULL_END
