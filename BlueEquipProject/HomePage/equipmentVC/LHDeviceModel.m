//
//  LHDeviceModel.m
//  BlueEquipProject
//

#import "LHDeviceModel.h"

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

    return m;
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
