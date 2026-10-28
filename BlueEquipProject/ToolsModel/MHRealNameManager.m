//
//  MHRealNameManager.m
//  BlueEquipProject
//

#import "MHRealNameManager.h"
#import "requestUrlRFile.h"
#import "requestToolClass.h"
#import "LYUserDefault.h"
#import <AFNetworking.h>

@implementation MHRealNameInfo
@end

@interface MHRealNameManager ()
@property (nonatomic, assign) MHRealNameStatus cached;
@end

@implementation MHRealNameManager

+ (instancetype)shared {
    static MHRealNameManager *inst;
    static dispatch_once_t once;
    dispatch_once(&once, ^{ inst = [[MHRealNameManager alloc] init]; inst.cached = MHRealNameStatusUnknown; });
    return inst;
}

- (MHRealNameStatus)cachedStatus {
    return self.cached;
}

#pragma mark - 2.1 查询实名状态

- (void)fetchStatus:(MHRealNameStatusBlock)completion {
    [requestToolClass getNetworkWithUrl:request_realname_status andParameter:nil success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        if (code != 200) {
            NSError *err = [NSError errorWithDomain:@"MHRealName" code:code userInfo:@{NSLocalizedDescriptionKey: msg ?: @""}];
            !completion ?: completion(NO, MHRealNameStatusUnknown, nil, err);
            return;
        }
        NSDictionary *data = [info isKindOfClass:[NSDictionary class]] ? info : nil;
        if (!data) {
            !completion ?: completion(NO, MHRealNameStatusUnknown, nil, nil);
            return;
        }
        MHRealNameInfo *ri = [[MHRealNameInfo alloc] init];
        ri.required = [data[@"required"] boolValue];
        ri.status = [data[@"status"] integerValue];
        ri.statusText = data[@"statusText"] ?: @"";
        ri.idCardMasked = data[@"idCardMasked"] ?: @"";
        ri.rejectReason = data[@"rejectReason"] ?: @"";
        ri.submitTime = data[@"submitTime"];
        ri.auditTime = data[@"auditTime"];
        self.cached = ri.status;
        !completion ?: completion(ri.required, ri.status, ri, nil);
    } fail:^(NSString * _Nonnull errorStr) {
        NSError *err = [NSError errorWithDomain:@"MHRealName" code:-1 userInfo:@{NSLocalizedDescriptionKey: errorStr ?: @""}];
        !completion ?: completion(NO, MHRealNameStatusUnknown, nil, err);
    }];
}

#pragma mark - 2.3 未实名提示文案

- (void)fetchPrompt:(void(^)(NSString * _Nullable, NSError * _Nullable))completion {
    [requestToolClass getNetworkWithUrl:request_realname_prompt andParameter:nil success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        if (code != 200) {
            !completion ?: completion(nil, [NSError errorWithDomain:@"MHRealName" code:code userInfo:@{NSLocalizedDescriptionKey: msg ?: @""}]);
            return;
        }
        NSString *text = [info isKindOfClass:[NSString class]] ? info : nil;
        !completion ?: completion(text, nil);
    } fail:^(NSString * _Nonnull errorStr) {
        !completion ?: completion(nil, [NSError errorWithDomain:@"MHRealName" code:-1 userInfo:@{NSLocalizedDescriptionKey: errorStr ?: @""}]);
    }];
}

#pragma mark - 2.2 提交实名认证

- (void)submitWithRealName:(NSString *)realName
                 idCardNo:(NSString *)idCardNo
                    phone:(NSString *)phone
               idCardFront:(NSString *)frontURL
                idCardBack:(NSString *)backURL
                completion:(void(^)(BOOL, MHRealNameStatus, NSString * _Nullable, NSError * _Nullable))completion {
    NSMutableDictionary *body = @{
        @"realName": realName ?: @"",
        @"idCardNo": idCardNo ?: @"",
        @"idCardFront": frontURL ?: @"",
        @"idCardBack": backURL ?: @"",
    }.mutableCopy;
    if (phone.length > 0) body[@"phone"] = phone;

    [requestToolClass postNetworkWithUrl:request_realname_submit andParameter:body success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        if (code != 200) {
            !completion ?: completion(NO, MHRealNameStatusUnknown, msg, [NSError errorWithDomain:@"MHRealName" code:code userInfo:@{NSLocalizedDescriptionKey: msg ?: @""}]);
            return;
        }
        NSDictionary *data = [info isKindOfClass:[NSDictionary class]] ? info : nil;
        MHRealNameStatus st = MHRealNameStatusUnknown;
        if (data[@"status"]) st = [data[@"status"] integerValue];
        !completion ?: completion(YES, st, msg, nil);
    } fail:^(NSString * _Nonnull errorStr) {
        !completion ?: completion(NO, MHRealNameStatusUnknown, nil, [NSError errorWithDomain:@"MHRealName" code:-1 userInfo:@{NSLocalizedDescriptionKey: errorStr ?: @""}]);
    }];
}

@end
