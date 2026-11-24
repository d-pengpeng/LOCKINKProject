//
//  LHDeviceModel.m
//  BlueEquipProject
//

#import "LHDeviceModel.h"

#pragma mark - functions.code 常量集合

/// 只有震动模式（CLASSIC/BERSERK/RANDOM） — AA-A1013 电击按摩垫片特征
static NSSet<NSString *> *kVibrateOnlyCodes(void) {
    static NSSet *s = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s = [NSSet setWithArray:@[
            @"METHOD_CLASSIC_MODE",
            @"METHOD_BERSERK_MODE",
            @"METHOD_RANDOM_MODE",
        ]];
    });
    return s;
}

/// 锁相关功能 — 有这些就是贞操锁类
static NSSet<NSString *> *kLockCodes(void) {
    static NSSet *s = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s = [NSSet setWithArray:@[
            @"METHOD_OPEN_LOCK",
            @"METHOD_CLOSE_LOCK",
        ]];
    });
    return s;
}

/// 本地硬编码已知型号（跟 LHDeviceRegistry.m LHLocalKnownModels 保持一致）
static NSSet<NSString *> *LHModel_LocalKnownModels(void) {
    static NSSet *s = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s = [NSSet setWithArray:@[
            @"AA-A1001", @"AA-A1002", @"AA-A1003", @"AA-A1004",
            @"AA-A1005", @"AA-A1006", @"AA-A1007", @"AA-A1008",
            @"AA-A1009", @"AA-A1010", @"AA-A1011", @"AA-A1012",
            @"AA-A1013", @"AA-A1014", @"AA-A1015", @"AA-A1016",
            @"AA-A1017",
        ]];
    });
    return s;
}

@implementation LHDeviceFunction

+ (instancetype)modelWithJSON:(NSDictionary *)json {
    if (![json isKindOfClass:[NSDictionary class]]) return nil;
    LHDeviceFunction *f = [[LHDeviceFunction alloc] init];
    f.code  = [json[@"code"] isKindOfClass:[NSString class]] ? json[@"code"] : @"";
    f.name  = [json[@"name"] isKindOfClass:[NSString class]] ? json[@"name"] : @"";
    f.value = [json[@"value"] isKindOfClass:[NSNumber class]] ? [json[@"value"] intValue] : 0;
    return f;
}

@end

@interface LHDeviceModel ()
@property (nonatomic, assign, readwrite) LHInferredProtocol inferredProtocol;
@property (nonatomic, assign, readwrite) LHInferredRoute inferredRoute;
@property (nonatomic, assign, readwrite) BOOL inferredPauseSupported;
@property (nonatomic, assign, readwrite) BOOL inferredIsLockType;
@end

@implementation LHDeviceModel

+ (instancetype)modelWithJSON:(NSDictionary *)json {
    if (![json isKindOfClass:[NSDictionary class]]) return nil;
    LHDeviceModel *m = [[LHDeviceModel alloc] init];
    m.deviceId  = [json[@"id"] isKindOfClass:[NSNumber class]] ? [json[@"id"] intValue] : 0;
    m.model     = [json[@"model"] isKindOfClass:[NSString class]] ? json[@"model"] : @"";
    m.name      = [json[@"name"] isKindOfClass:[NSString class]] ? json[@"name"] : @"";
    m.img       = [json[@"img"] isKindOfClass:[NSString class]] ? json[@"img"] : @"";
    m.languages = [json[@"languages"] isKindOfClass:[NSDictionary class]] ? json[@"languages"] : @{};

    NSArray *funcs = [json[@"functions"] isKindOfClass:[NSArray class]] ? json[@"functions"] : @[];
    NSMutableArray<LHDeviceFunction *> *arr = [NSMutableArray array];
    for (NSDictionary *f in funcs) {
        LHDeviceFunction *obj = [LHDeviceFunction modelWithJSON:f];
        if (obj) [arr addObject:obj];
    }
    m.functions = [arr copy];

    // 服务端只给了 functions，推断层自动算出缺失的字段
    [m recalcInferredFields];

    return m;
}

- (void)recalcInferredFields {
    // 收集所有 function.code 到一个 set
    NSMutableSet<NSString *> *codes = [NSMutableSet set];
    for (LHDeviceFunction *f in self.functions) {
        if (f.code.length > 0) [codes addObject:f.code];
    }

    // —— 推断蓝牙协议 ——
    // 只有 CLASSIC/BERSERK/RANDOM（震动），没有其他任何功能 → Qiui 协议
    // 依据：AA-A1013 电击按摩垫片 = 震动-only + Qiui 协议
    BOOL hasElectric     = [codes containsObject:@"METHOD_ELECTRIC"];
    BOOL hasLock         = [codes intersectsSet:kLockCodes()];
    BOOL hasOnlyVibrate  = YES;
    for (NSString *c in codes) {
        if (![kVibrateOnlyCodes() containsObject:c]) {
            hasOnlyVibrate = NO;
            break;
        }
    }

    if (hasOnlyVibrate && !hasElectric && !hasLock) {
        self.inferredProtocol = LHInferredProtocolQiui;
    } else {
        self.inferredProtocol = LHInferredProtocolDefault;
    }

    // —— 推断控制页路由 ——
    if (hasLock) {
        self.inferredRoute = LHInferredRouteRoleOneLock;
    } else if (hasOnlyVibrate && !hasElectric) {
        self.inferredRoute = LHInferredRouteFourthRole;
    } else if (codes.count > 0) {
        // 有 ELECTRIC 或 TIMER 或 LIGHT_CONTROL 等 → 通用 RoleOne
        self.inferredRoute = LHInferredRouteRoleOne;
    } else {
        self.inferredRoute = LHInferredRouteUnknown;
    }

    // —— 推断锁类型 ——
    self.inferredIsLockType = hasLock;

    // —— 推断暂停支持 ——
    // CLASSIC/BERSERK/RANDOM 模式的产品都支持暂停（UI 上会显示暂停按钮）
    self.inferredPauseSupported = [codes containsObject:@"METHOD_CLASSIC_MODE"] ||
                                  [codes containsObject:@"METHOD_BERSERK_MODE"] ||
                                  [codes containsObject:@"METHOD_RANDOM_MODE"];
}

- (BOOL)isLocalKnownModel {
    return [LHModel_LocalKnownModels() containsObject:self.model];
}

- (NSString *)displayName {
    // 优先取当前语言
    NSString *langCode = [NSLocale preferredLanguages].firstObject ?: @"zh";
    langCode = [[langCode componentsSeparatedByString:@"-"] firstObject]; // "zh-Hans" → "zh"
    NSString *localized = nil;
    if ([self.languages isKindOfClass:[NSDictionary class]]) {
        localized = self.languages[langCode];
        if (!localized) localized = self.languages[@"en"];
        if (!localized) localized = self.languages[@"zh"];
    }
    return (localized.length > 0) ? localized : self.name;
}

@end
