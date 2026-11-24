//
//  LHDeviceRegistry.m
//  BlueEquipProject
//

#import "LHDeviceRegistry.h"
#import "requestToolClass.h"
#import "requestUrlRFile.h"

NSString * const LHDeviceRegistryDidUpdateNotification = @"LHDeviceRegistryDidUpdateNotification";

static NSString * const kLHDeviceRegistryCacheKey = @"LHDeviceRegistry_CachedListProduct";
static NSString * const kLHDeviceRegistryCacheTimeKey = @"LHDeviceRegistry_CacheTime";

/// 本地已知蓝牙型号（PrefixHeader.pch 里的 kCharactName1..17 宏）
/// 这些是硬编码兜底，保证服务端拉不到（网络断、接口挂）时也能正常扫描识别。
static NSSet<NSString *> *LHLocalKnownModels(void) {
    static NSSet *s = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s = [NSSet setWithArray:@[
            @"AA-A1001", // kCharactName   微智贞操锁
            @"AA-A1002", // kCharactName2  钥匙盒（老设备协议）
            @"AA-A1003", // kCharactName3  电鳗贞操锁
            @"AA-A1004", // kCharactName4  马眼棒
            @"AA-A1005", // kCharactName5  飞机杯
            @"AA-A1006", // kCharactName6  震动棒
            @"AA-A1007", // kCharactName7  偷心电击款
            @"AA-A1008", // kCharactName8  震动肛塞
            @"AA-A1009", // kCharactName9  心形肛塞
            @"AA-A1010", // kCharactName10 圆形震动肛塞
            @"AA-A1011", // kCharactName11 心形震动肛塞
            @"AA-A1012", // kCharactName12 刺蜂贞操锁（蜂刺）
            @"AA-A1013", // kCharactName13 电击按摩垫片（4个片）
            @"AA-A1014", // kCharactName14 男性训练器（震动+电击）
            @"AA-A1015", // kCharactName15 锋刺长款贞操锁
            @"AA-A1016", // kCharactName16
            @"AA-A1017", // kCharactName17
        ]];
    });
    return s;
}

@interface LHDeviceRegistry ()
@property (nonatomic, strong, readwrite) NSMutableSet<NSString *> *knownModelsMutable;
@property (nonatomic, strong, readwrite) NSMutableDictionary<NSString *, LHDeviceModel *> *serverModelsMutable;
@property (nonatomic, assign, readwrite) NSTimeInterval lastServerFetchTime;
@end

@implementation LHDeviceRegistry

+ (instancetype)shared {
    static LHDeviceRegistry *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[LHDeviceRegistry alloc] init];
    });
    return inst;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 本地型号兜底：copy 一份可变集合
        _knownModelsMutable = [LHLocalKnownModels() mutableCopy];
        _serverModelsMutable = [NSMutableDictionary dictionary];
        _lastServerFetchTime = 0;
    }
    return self;
}

- (NSSet<NSString *> *)knownModels {
    return [self.knownModelsMutable copy];
}

- (NSDictionary<NSString *, LHDeviceModel *> *)serverModels {
    return [self.serverModelsMutable copy];
}

- (BOOL)isKnownModel:(NSString *)model {
    if (model.length == 0) return NO;
    return [self.knownModelsMutable containsObject:model];
}

- (nullable LHDeviceModel *)deviceModelForModel:(NSString *)model {
    return self.serverModelsMutable[model];
}

#pragma mark - 缓存

- (void)restoreFromCache {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    NSArray *cached = [ud arrayForKey:kLHDeviceRegistryCacheKey];
    if ([cached isKindOfClass:[NSArray class]] && cached.count > 0) {
        [self.serverModelsMutable removeAllObjects];
        for (NSDictionary *json in cached) {
            LHDeviceModel *m = [LHDeviceModel modelWithJSON:json];
            if (m.model.length > 0) {
                self.serverModelsMutable[m.model] = m;
                [self.knownModelsMutable addObject:m.model];
            }
        }
    }

    self.lastServerFetchTime = [ud doubleForKey:kLHDeviceRegistryCacheTimeKey];
}

- (void)_saveCache {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSMutableArray *arr = [NSMutableArray array];
    for (LHDeviceModel *m in self.serverModelsMutable.allValues) {
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        d[@"id"]        = @(m.deviceId);
        d[@"model"]     = m.model ?: @"";
        d[@"name"]      = m.name ?: @"";
        d[@"img"]       = m.img ?: @"";
        d[@"languages"] = m.languages ?: @{};
        NSMutableArray *farr = [NSMutableArray array];
        for (LHDeviceFunction *f in m.functions) {
            [farr addObject:@{ @"code": f.code ?: @"", @"name": f.name ?: @"", @"value": @(f.value) }];
        }
        d[@"functions"] = farr;
        [arr addObject:d];
    }
    [ud setObject:arr forKey:kLHDeviceRegistryCacheKey];
    [ud setDouble:self.lastServerFetchTime forKey:kLHDeviceRegistryCacheTimeKey];
    [ud synchronize];
}

#pragma mark - 服务端拉取

- (void)loadFromServerWithCompletion:(nullable void (^)(BOOL success))completion {
    [requestToolClass getNetworkWithUrl:request_square_listProduct
                            andParameter:@{}
                                 success:^(int code, id _Nonnull info, NSString * _Nonnull msg) {
        if (code != 200 || ![info isKindOfClass:[NSArray class]]) {
            NSLog(@"[LHDeviceRegistry] listProduct 异常: code=%d msg=%@ infoType=%@", code, msg, NSStringFromClass([info class]));
            if (completion) completion(NO);
            return;
        }

        NSMutableDictionary<NSString *, LHDeviceModel *> *newServer = [NSMutableDictionary dictionary];
        NSMutableSet<NSString *> *newFromServer = [NSMutableSet set];

        for (NSDictionary *json in info) {
            LHDeviceModel *m = [LHDeviceModel modelWithJSON:json];
            if (m.model.length == 0) continue;
            newServer[m.model] = m;
            [newFromServer addObject:m.model];
        }

        // 合并到 registry（服务端覆盖同 model 的本地旧值）
        self.serverModelsMutable = newServer;
        [self.knownModelsMutable unionSet:newFromServer];
        self.lastServerFetchTime = [[NSDate date] timeIntervalSince1970];

        [self _saveCache];

        NSLog(@"[LHDeviceRegistry] 合并完成：本地=%lu 服务端=%lu 总已知型号=%lu",
              (unsigned long)LHLocalKnownModels().count,
              (unsigned long)newServer.count,
              (unsigned long)self.knownModelsMutable.count);

        [[NSNotificationCenter defaultCenter] postNotificationName:LHDeviceRegistryDidUpdateNotification object:nil];
        if (completion) completion(YES);

    } fail:^(NSString * _Nonnull msg) {
        NSLog(@"[LHDeviceRegistry] listProduct 失败: %@", msg);
        // 失败不影响本地已知型号，不发通知
        if (completion) completion(NO);
    }];
}

@end
