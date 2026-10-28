//
//  MHBehaviorReporter.m
//  BlueEquipProject
//
//  用户行为上报 —— POST /behavior/report
//

#import "MHBehaviorReporter.h"
#import "requestUrlRFile.h"
#import "requestToolClass.h"
#import "LYUserDefault.h"
#import <AFNetworking.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

#pragma mark - Type Constants

NSString *const MHBTApp     = @"app";
NSString *const MHBTPage    = @"page";
NSString *const MHBTAction   = @"action";
NSString *const MHBTFlow    = @"flow";
NSString *const MHBTError   = @"error";
NSString *const MHBTPerf     = @"perf";

#pragma mark - NSUserDefaults Keys

static NSString *kClientIdKey       = @"mh_behavior_client_id";
static NSString *kSessionIdKey      = @"mh_behavior_session_id";
static NSString *kSessionStartKey   = @"mh_behavior_session_start";   // last foreground time ms
static NSString *kCacheQueueKey     = @"mh_behavior_cache_queue";
static NSString *kInitedKey         = @"mh_behavior_inited";

#pragma mark - Limits

static const int kBatchThreshold    = 20;
static const int kFlushIntervalSec  = 30;
static const int kMaxCache          = 1000;
static const int kSessionTimeoutSec = 30 * 60;   // 后台 30 分钟切新 session
static const int kMaxEventExtBytes  = 1024;

#pragma mark - Reporter

@interface MHBehaviorReporter ()

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *queue;        // 待上报事件
@property (nonatomic, strong) NSTimer *flushTimer;                          // 定时 flush
@property (nonatomic, strong) dispatch_queue_t workQueue;                  // 串行队列保证线程安全
@property (nonatomic, assign) BOOL isFlushing;                              // 防重入

// session 管理
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, assign) NSTimeInterval sessionStartMs;                // 本次 session 开始时间

@end

@implementation MHBehaviorReporter

#pragma mark - Singleton

+ (instancetype)shared {
    static MHBehaviorReporter *inst;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[MHBehaviorReporter alloc] init];
    });
    return inst;
}

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = [NSMutableArray array];
        _workQueue = dispatch_queue_create("com.lockink.behavior", DISPATCH_QUEUE_SERIAL);
        _isFlushing = NO;
    }
    return self;
}

#pragma mark - Public: Start

- (void)start {
    // 恢复 clientId 或生成新的
    NSString *cid = [[NSUserDefaults standardUserDefaults] objectForKey:kClientIdKey];
    if (cid.length == 0) {
        cid = [MHBehaviorReporter uuidString];
        [[NSUserDefaults standardUserDefaults] setObject:cid forKey:kClientIdKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // 恢复 sessionId + 检查是否需要新 session
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *prevSid = [ud objectForKey:kSessionIdKey];
    NSTimeInterval prevStart = [ud doubleForKey:kSessionStartKey];
    NSTimeInterval nowMs = [[NSDate date] timeIntervalSince1970] * 1000;
    BOOL needNewSession = (prevSid.length == 0) || (prevStart > 0 && (nowMs - prevStart) > kSessionTimeoutSec * 1000);
    
    if (needNewSession) {
        if (prevSid.length > 0 && prevStart > 0) {
            // 上报 session_end（旧 session）
            NSInteger durationSec = (nowMs - prevStart) / 1000;
            [self _enqueueEventWithType:MHBTApp
                                    key:@"session_end"
                                   page:nil
                               fromPage:nil
                             targetType:nil
                               targetId:nil
                                    ext:@{@"durationMs": @((NSInteger)(nowMs - prevStart))}
                                 result:1
                               errorCode:nil
                              durationMs:nil
                                 costMs:nil];
        }
        self.sessionId = [MHBehaviorReporter uuidString];
        self.sessionStartMs = nowMs;
        [ud setObject:self.sessionId forKey:kSessionIdKey];
        [ud setDouble:nowMs forKey:kSessionStartKey];
        [ud synchronize];
        
        // session_start
        [self _enqueueEventWithType:MHBTApp
                                key:@"session_start"
                               page:nil
                           fromPage:nil
                         targetType:nil
                           targetId:nil
                                ext:@{@"reason": @"cold"}
                             result:1
                           errorCode:nil
                          durationMs:nil
                             costMs:nil];
    } else {
        self.sessionId = prevSid;
        self.sessionStartMs = prevStart;
    }
    
    // 恢复离线缓存
    NSArray *cached = [ud objectForKey:kCacheQueueKey];
    if ([cached isKindOfClass:[NSArray class]] && cached.count > 0) {
        dispatch_sync(self.workQueue, ^{
            [self.queue addObjectsFromArray:cached];
        });
        [ud removeObjectForKey:kCacheQueueKey];
        [ud synchronize];
        NSLog(@"[Behavior] restored %lu cached events", (unsigned long)cached.count);
    }
    
    // 启动定时器
    [self _startTimer];
    
    // app_start 埋点（启动耗时暂取不到精确值，只打 rt=cold）
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self _enqueueEventWithType:MHBTApp
                                key:@"app_start"
                               page:nil
                           fromPage:nil
                         targetType:nil
                           targetId:nil
                                ext:@{@"rt": @"cold"}
                             result:1
                           errorCode:nil
                          durationMs:nil
                             costMs:nil];
    });
    
    NSLog(@"[Behavior] reporter started, clientId=%@ sessionId=%@", cid, self.sessionId);
}

#pragma mark - Public: Foreground / Background

- (void)markAppForeground {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSTimeInterval prevStart = [ud doubleForKey:kSessionStartKey];
    NSTimeInterval nowMs = [[NSDate date] timeIntervalSince1970] * 1000;
    BOOL needNewSession = (prevStart > 0 && (nowMs - prevStart) > kSessionTimeoutSec * 1000);
    
    if (needNewSession) {
        // session_end
        [self _enqueueEventWithType:MHBTApp
                                key:@"session_end"
                               page:nil
                           fromPage:nil
                         targetType:nil
                           targetId:nil
                                ext:@{@"durationMs": @((NSInteger)(nowMs - prevStart))}
                             result:1
                           errorCode:nil
                          durationMs:nil
                             costMs:nil];
        self.sessionId = [MHBehaviorReporter uuidString];
        self.sessionStartMs = nowMs;
        [ud setObject:self.sessionId forKey:kSessionIdKey];
        [ud setDouble:nowMs forKey:kSessionStartKey];
        [ud synchronize];
        
        [self _enqueueEventWithType:MHBTApp
                                key:@"session_start"
                               page:nil
                           fromPage:nil
                         targetType:nil
                           targetId:nil
                                ext:@{@"reason": @"timeout"}
                             result:1
                           errorCode:nil
                          durationMs:nil
                             costMs:nil];
    } else {
        self.sessionStartMs = nowMs;
        [ud setDouble:nowMs forKey:kSessionStartKey];
        [ud synchronize];
    }
    
    // app_resume
    [self _enqueueEventWithType:MHBTApp
                            key:@"app_resume"
                           page:nil
                       fromPage:nil
                     targetType:nil
                       targetId:nil
                            ext:@{@"stayBgMs": @((NSInteger)nowMs)}  // TODO: 精确计算后台停留
                         result:1
                       errorCode:nil
                      durationMs:nil
                         costMs:nil];
    
    [self _startTimer];
}

- (void)markAppBackground {
    // app_background
    [self _enqueueEventWithType:MHBTApp
                            key:@"app_background"
                           page:nil
                       fromPage:nil
                     targetType:nil
                       targetId:nil
                            ext:@{@"fgMs": @((NSInteger)([[NSDate date] timeIntervalSince1970] * 1000 - self.sessionStartMs))}
                         result:1
                       errorCode:nil
                      durationMs:nil
                         costMs:nil];
    
    [self _stopTimer];
    
    // 立即 flush + 保存离线缓存
    [self flushNow];
}

#pragma mark - Public: Track

- (void)trackWithType:(NSString *)type
                  key:(NSString *)key
                 page:(NSString *)page
             fromPage:(NSString *)fromPage
           targetType:(NSString *)targetType
             targetId:(NSString *)targetId
                  ext:(NSDictionary *)ext
               result:(NSInteger)result
             errorCode:(NSString *)errorCode
            durationMs:(NSNumber *)durationMs
               costMs:(NSNumber *)costMs {
    if (key.length == 0) return;
    
    dispatch_async(self.workQueue, ^{
        [self _enqueueEventWithType:type
                                key:key
                               page:page
                           fromPage:fromPage
                         targetType:targetType
                           targetId:targetId
                                ext:ext
                             result:result
                           errorCode:errorCode
                          durationMs:durationMs
                             costMs:costMs];
        
        // 满量触发
        if (self.queue.count >= kBatchThreshold) {
            [self _flush];
        }
    });
}

- (void)trackWithType:(NSString *)type key:(NSString *)key ext:(NSDictionary *)ext {
    [self trackWithType:type key:key page:nil fromPage:nil targetType:nil targetId:nil ext:ext result:1 errorCode:nil durationMs:nil costMs:nil];
}

- (void)trackAction:(NSString *)key page:(NSString *)page ext:(NSDictionary *)ext {
    [self trackWithType:MHBTAction key:key page:page fromPage:nil targetType:nil targetId:nil ext:ext result:1 errorCode:nil durationMs:nil costMs:nil];
}

- (void)trackPageView:(NSString *)page fromPage:(NSString *)fromPage {
    [self trackWithType:MHBTPage key:@"page_view" page:page fromPage:fromPage targetType:nil targetId:nil ext:nil result:1 errorCode:nil durationMs:nil costMs:nil];
}

- (void)trackPageLeave:(NSString *)page durationMs:(NSInteger)durationMs {
    [self trackWithType:MHBTPage key:@"page_leave" page:page fromPage:nil targetType:nil targetId:nil ext:nil result:1 errorCode:nil durationMs:@(durationMs) costMs:nil];
}

- (void)trackError:(NSString *)key ext:(NSDictionary *)ext {
    [self trackWithType:MHBTError key:key page:nil fromPage:nil targetType:nil targetId:nil ext:ext result:2 errorCode:nil durationMs:nil costMs:nil];
}

- (void)trackPerf:(NSString *)key costMs:(NSInteger)costMs ext:(NSDictionary *)ext {
    [self trackWithType:MHBTPerf key:key page:nil fromPage:nil targetType:nil targetId:nil ext:ext result:1 errorCode:nil durationMs:nil costMs:@(costMs)];
}

#pragma mark - Public: Flush

- (void)flushNow {
    dispatch_async(self.workQueue, ^{
        [self _flush];
    });
}

#pragma mark - Timer

- (void)_startTimer {
    [self _stopTimer];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.flushTimer = [NSTimer scheduledTimerWithTimeInterval:kFlushIntervalSec target:self selector:@selector(_timerTick) userInfo:nil repeats:YES];
    });
}

- (void)_stopTimer {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.flushTimer invalidate];
        self.flushTimer = nil;
    });
}

- (void)_timerTick {
    dispatch_async(self.workQueue, ^{
        [self _flush];
    });
}

#pragma mark - Internal: Enqueue

/// 兜底：找当前顶层 VC，page 为空时自动填充
+ (UIViewController *)_topViewController {
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if ([scene isKindOfClass:[UIWindowScene class]]) {
                UIWindowScene *ws = (UIWindowScene *)scene;
                for (UIWindow *w in ws.windows) {
                    if (w.isKeyWindow) { window = w; break; }
                }
            }
        }
    }
    if (!window) window = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = window.rootViewController;
    while (vc.presentedViewController) vc = vc.presentedViewController;
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = ((UITabBarController *)vc).selectedViewController;
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = ((UINavigationController *)vc).visibleViewController;
    }
    return vc;
}

- (void)_enqueueEventWithType:(NSString *)type
                          key:(NSString *)key
                         page:(NSString *)page
                     fromPage:(NSString *)fromPage
                   targetType:(NSString *)targetType
                     targetId:(NSString *)targetId
                          ext:(NSDictionary *)ext
                       result:(NSInteger)result
                     errorCode:(NSString *)errorCode
                    durationMs:(NSNumber *)durationMs
                       costMs:(NSNumber *)costMs {
    NSMutableDictionary *event = [NSMutableDictionary dictionary];
    
    // 兜底：page 为空时自动取当前 topVC
    if (page.length == 0) {
        UIViewController *topVC = [MHBehaviorReporter _topViewController];
        if (topVC) page = NSStringFromClass([topVC class]);
    }
    
    // 必填
    event[@"eventId"]     = [MHBehaviorReporter uuidString];
    event[@"type"]        = type;
    event[@"key"]         = key;
    event[@"clientTime"]  = @((NSInteger)([[NSDate date] timeIntervalSince1970] * 1000));
    
    // 可选
    if (page.length > 0)         event[@"page"]       = page;
    if (fromPage.length > 0)     event[@"fromPage"]   = fromPage;
    if (targetType.length > 0)   event[@"targetType"] = targetType;
    if (targetId.length > 0)     event[@"targetId"]   = targetId;
    if (durationMs)              event[@"durationMs"] = durationMs;
    if (costMs)                  event[@"costMs"]     = costMs;
    if (errorCode.length > 0)    event[@"errorCode"]  = errorCode;
    if (result != 0)             event[@"result"]     = @(result);
    
    // ext：必须 ≤ 1024 字节，超出整条丢弃
    if (ext.count > 0) {
        NSError *serr;
        NSData *jdata = [NSJSONSerialization dataWithJSONObject:ext options:0 error:&serr];
        if (!serr && jdata.length <= kMaxEventExtBytes) {
            event[@"ext"] = ext;
        } else if (!serr) {
            NSLog(@"[Behavior] ext too large (%lu bytes), dropping event %@", (unsigned long)jdata.length, key);
            return;
        }
    }
    
    @synchronized (self) {
        if (self.queue.count >= kMaxCache) {
            [self.queue removeObjectsInRange:NSMakeRange(0, self.queue.count - kMaxCache + 1)];
        }
        [self.queue addObject:[event copy]];
    }
    
    NSLog(@"[Behavior] +%@:%@ (queue=%lu)", type, key, (unsigned long)self.queue.count);
}

#pragma mark - Internal: Flush

- (void)_flush {
    if (self.isFlushing) return;
    
    NSArray *batch;
    @synchronized (self) {
        if (self.queue.count == 0) return;
        batch = [self.queue subarrayWithRange:NSMakeRange(0, MIN(self.queue.count, 50))];
        [self.queue removeObjectsInRange:NSMakeRange(0, batch.count)];
    }
    self.isFlushing = YES;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *clientId = [ud objectForKey:kClientIdKey] ?: @"";
    NSString *sid = self.sessionId ?: [ud objectForKey:kSessionIdKey] ?: @"";
    
    NSDictionary *payload = @{
        @"clientId": clientId,
        @"sessionId": sid,
        @"common":   [self _commonParams],
        @"events":   batch ?: @[]
    };
    
    NSLog(@"[Behavior] flushing %lu events → %@", (unsigned long)batch.count, payload);
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    [session.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // token 可选
    NSString *token = TOKEN;
    if (token.length > 0) {
        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [session.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", INTERFACEADDRESS, @"behavior/report"];
    
    [session POST:url parameters:payload headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.isFlushing = NO;
        
        // 防御性解析：responseObject 可能是 NSDictionary 也可能是 NSData/NSString
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *root = (NSDictionary *)responseObject;
            NSDictionary *data = [root[@"data"] isKindOfClass:[NSDictionary class]] ? root[@"data"] : nil;
            NSInteger accepted = data ? [data[@"accepted"] integerValue] : 0;
            NSInteger rejected = data ? [data[@"rejected"] integerValue] : 0;
            NSLog(@"[Behavior] flushed → accepted=%ld rejected=%ld", (long)accepted, (long)rejected);
        } else if ([responseObject isKindOfClass:[NSData class]]) {
            // AFJSONResponseSerializer 可能失效，手动解析
            NSError *je;
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:&je];
            if (!je && [root isKindOfClass:[NSDictionary class]]) {
                NSDictionary *data = [root[@"data"] isKindOfClass:[NSDictionary class]] ? root[@"data"] : nil;
                NSInteger accepted = data ? [data[@"accepted"] integerValue] : 0;
                NSInteger rejected = data ? [data[@"rejected"] integerValue] : 0;
                NSLog(@"[Behavior] flushed (manual parse) → accepted=%ld rejected=%ld", (long)accepted, (long)rejected);
            } else {
                NSLog(@"[Behavior] flushed but response not JSON dict: %@", [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding]);
            }
        } else {
            NSLog(@"[Behavior] flushed but responseObject type unexpected: %@", [responseObject class]);
        }
        
        // rejected > 0 不重试（文档明确要求）
        [self _persistCache];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.isFlushing = NO;
        
        NSLog(@"[Behavior] flush failed: %@", error.localizedDescription);
        // 把失败的事件放回去（保留原 eventId 方便重试）
        @synchronized (self) {
            // 插到队头，下次优先上报
            self.queue = [[batch arrayByAddingObjectsFromArray:self.queue] mutableCopy];
            if (self.queue.count > kMaxCache) {
                [self.queue removeObjectsInRange:NSMakeRange(kMaxCache, self.queue.count - kMaxCache)];
            }
        }
        // 存离线缓存
        [self _persistCache];
    }];
}

- (void)_persistCache {
    NSArray *snapshot;
    @synchronized (self) {
        snapshot = [self.queue copy];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (snapshot.count == 0) {
        [ud removeObjectForKey:kCacheQueueKey];
    } else {
        [ud setObject:snapshot forKey:kCacheQueueKey];
    }
    [ud synchronize];
}

#pragma mark - Common Params

- (NSDictionary *)_commonParams {
    UIDevice *dev = [UIDevice currentDevice];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    AFNetworkReachabilityStatus rStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    NSString *network = @"none";
    if (rStatus == AFNetworkReachabilityStatusReachableViaWiFi)      network = @"wifi";
    else if (rStatus == AFNetworkReachabilityStatusReachableViaWWAN) network = @"4g";   // 粗粒度，iOS 难精确区分 4g/5g
    
    NSString *model;
    struct utsname systemInfo;
    uname(&systemInfo);
    model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if (model.length == 0) model = @"unknown";
    
    return @{
        @"platform":    @"iOS",
        @"appVersion":  [requestToolClass appVersionString] ?: @"",
        @"osVersion":   dev.systemVersion ?: @"",
        @"deviceModel": model,
        @"network":     network,
        @"screen":      [NSString stringWithFormat:@"%.0fx%.0f", screenSize.width, screenSize.height],
        @"channel":     @"AppStore"
    };
}

#pragma mark - UUID

+ (NSString *)uuidString {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString *s = [(__bridge_transfer NSString *)uuidStr lowercaseString];
    // 去掉 '-'，服务端只要求唯一即可
    return [s stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
