//
//  eSocketRocketUtility.m
//  yunbaolive
//
//  东莞梦幻网络科技有限公司 注 on 2020/8/18.
//  Copyright © 2020 cat. All rights reserved.
//

#import "eSocketRocketUtility.h"
#import <SocketRocket.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>

@interface eSocketRocketUtility()<SRWebSocketDelegate>
{
    int _index;
    NSTimer * heartBeat;
    NSTimeInterval reConnectTime;
}

@property (nonatomic,strong) SRWebSocket *socket;
@property (nonatomic, assign) BOOL isBOpen;
@property (nonatomic, strong) NSMutableArray<NSDictionary *> *pendingMessages;

//调用层是否需要 socket（进入控制页/首页时置 YES，主动关闭时置 NO）
@property (nonatomic, assign) BOOL needConnect;
//当前网络是否可用
@property (nonatomic, assign) BOOL isNetworkReachable;
//鉴权失败（401/403），暂停自动重连，避免无意义刷流量
@property (nonatomic, assign) BOOL isAuthFailed;
@property (nonatomic, strong) AFNetworkReachabilityManager *reachabilityManager;
@end

static const NSTimeInterval kMHPendingMessageMaxAge = 5.0;
static const NSInteger kMHPendingMessageMaxCount = 20;

@implementation eSocketRocketUtility

+ (instancetype)sharedInstance
{
    static eSocketRocketUtility *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[eSocketRocketUtility alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始按有网处理，真实状态由网络监听回调纠正
        _isNetworkReachable = YES;
        [self mh_startNetworkMonitor];
    }
    return self;
}

//MARK: 监听网络状态：断网不重连，网络恢复后自动重连
- (void)mh_startNetworkMonitor
{
    //使用独立实例，避免与 HistoryRecordModel 里的 sharedManager 回调互相覆盖
    self.reachabilityManager = [AFNetworkReachabilityManager manager];
    __weak typeof(self) weakSelf = self;
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        __strong typeof(weakSelf) self = weakSelf;
        if (!self) {
            return;
        }
        BOOL reachable = (status != AFNetworkReachabilityStatusNotReachable);
        BOOL wasReachable = self.isNetworkReachable;
        self.isNetworkReachable = reachable;
        
        if (!reachable) {
            NSLog(@"socket--当前无网络，暂停连接与重连");
        }else if (!wasReachable) {
            NSLog(@"socket--网络已恢复，准备重连");
            if (self.needConnect && self.socket.readyState != SR_OPEN) {
                reConnectTime = 0;
                [self reConnect];
            }
        }
    }];
    [self.reachabilityManager startMonitoring];
}

- (BOOL)getSocketCloseBoo
{
    return !(self.isBOpen && self.socket.readyState == SR_OPEN);
}

- (NSMutableArray<NSDictionary *> *)pendingMessages
{
    if (!_pendingMessages) {
        _pendingMessages = [NSMutableArray array];
    }
    return _pendingMessages;
}

//开启连接（调用层表示「需要 socket」）
-(void)SRWebSocketOpenWithURLString:(NSString *)urlString {
    if (!urlString) {
        return;
    }
    self.urlSSt = urlString;
    self.needConnect = YES;
    //调用层主动要求连接时，允许重新尝试鉴权
    self.isAuthFailed = NO;
    
    if (!self.isNetworkReachable) {
        NSLog(@"socket--当前无网络，暂不建立连接，等待网络恢复");
        return;
    }
    if (self.socket) {
        return;
    }
    [self mh_openSocket];
}

- (void)SRWebSocketSendJsonDic:(NSDictionary *)jsonDic
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonSt = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self sendData:jsonSt];
}

//MARK: 真正建立连接（统一带上 token，重连也必须走这里）
- (void)mh_openSocket {
    if (!self.urlSSt) {
        return;
    }
    if (!self.isNetworkReachable) {
        NSLog(@"socket--当前无网络，跳过建立连接");
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlSSt]];
    [request setValue:TOKEN forHTTPHeaderField:@"token"];
    [request setValue:@"zh-CN" forHTTPHeaderField:@"Accept-Language"];
    //注意：服务端对带 Origin 的握手一律返回 403，已在 Podfile 的 post_install 中移除 SocketRocket 自动补的 Origin 头
    NSLog(@"socket--请求头--%@", request.allHTTPHeaderFields);
    
    self.socket = [[SRWebSocket alloc] initWithURLRequest:request];
    self.socket.delegate = self;   //SRWebSocketDelegate 协议
    [self.socket open];     //开始连接
}

//关闭连接（调用层明确不再需要 socket）
- (void)SRWebSocketClose {
    self.needConnect = NO;
    [self mh_closeSocket];
}

//MARK: 仅关闭连接，不改变「调用层是否需要连接」的意图
- (void)mh_closeSocket {
    if (self.socket){
        self.socket.delegate = nil;
        [self.socket close];
        self.socket = nil;
    }
    self.isBOpen = NO;
    //断开连接时销毁心跳
    [self destoryHeartBeat];
}

#pragma mark - socket delegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"连接成功，可以与服务器交流了,同时需要开启心跳");
    //每次正常连接的时候清零重连时间
    reConnectTime = 0;
    self.isBOpen = YES;
    //开启心跳 心跳是发送pong的消息 我这里根据后台的要求发送data给后台
    [self initHeartBeat];
    //连接成功后补发断线期间积压的指令
    [self flushPendingMessages];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"连接失败，这里可以实现掉线自动重连，%@", error);
    _socket = nil;
    self.isBOpen = NO;
    [self destoryHeartBeat];
    
    NSInteger statusCode = [error.userInfo[@"HTTPResponseStatusCode"] integerValue];
    if (statusCode == 401 || statusCode == 403) {
        //鉴权失败，重试也不会成功，等调用层下次主动连接
        self.isAuthFailed = YES;
        NSLog(@"socket--鉴权失败(%ld)，暂停自动重连", (long)statusCode);
        return;
    }
    if (!self.isNetworkReachable) {
        NSLog(@"socket--当前无网络，等待网络恢复后重连");
        return;
    }
    [self reConnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",code,reason,wasClean);
    //断开连接 同时销毁心跳
    self.socket = nil;
    self.isBOpen = NO;
    [self destoryHeartBeat];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNeedChangeGoodsUploginNote object:@""];
    
    //服务端主动断开时，只有调用层仍需要连接才重连
    if (self.needConnect && self.isNetworkReachable) {
        [self reConnect];
    }
}

/*
 该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 我的理解就是建立一个定时器，每隔十秒或者十五秒向服务端发送一个ping消息，这个消息可是是空的
 */
-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {

    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply===%@",reply);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message  {
    //收到服务器发过来的数据 这里的数据可以和后台约定一个格式 我约定的就是一个字符串 收到以后发送通知到外层 根据类型 实现不同的操作
    NSLog(@"%@",message);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNeedChangeGoodsNote object:message];
}

#pragma mark - methods
//重连机制
- (void)reConnect
{
    //调用层已不需要连接（用户没在控制页等），不重连，省流量
    if (!self.needConnect) {
        NSLog(@"socket--调用层无需连接，跳过重连");
        return;
    }
    //断网时不重连，等网络恢复回调触发
    if (!self.isNetworkReachable) {
        NSLog(@"socket--当前无网络，跳过重连");
        return;
    }
    //鉴权失败时重试无意义，等调用层下次主动连接
    if (self.isAuthFailed) {
        NSLog(@"socket--鉴权失败状态，跳过重连");
        return;
    }
    
    [self mh_closeSocket];
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64) {
        NSLog(@"socket--重连次数已达上限，停止重连");
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.needConnect || !self.isNetworkReachable || self.isAuthFailed) {
            return;
        }
        if (self.socket) {
            return;
        }
        self.socket = nil;
        [self mh_openSocket];
        NSLog(@"重连");
    });
    
    //重连时间2的指数级增长
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    }
}

//初始化心跳
- (void)initHeartBeat
{
    if(self->heartBeat) {
        return;
    }
    [self destoryHeartBeat];
    dispatch_main_async_safe((^{
        self->heartBeat = [NSTimer scheduledTimerWithTimeInterval:15 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"-心跳-");
            if(self.socket.readyState == SR_OPEN) {
                
                NSData *hearData = [[NSData alloc] initWithBase64EncodedString:@"heartbeat" options:NSUTF8StringEncoding];
                [self.socket sendPing:hearData error:NULL]; //发送心跳ping
            }else if (self.socket.readyState == SR_CONNECTING) {
                //连接中，等待连接结果，避免反复关闭重开
            }else if (self.socket.readyState == SR_CLOSED || self.socket.readyState == SR_CLOSING) {
                [self reConnect];
            }else {
                NSLog(@"没有网络, 发送失败");
            }
        }];
        [[NSRunLoop currentRunLoop]addTimer:self->heartBeat forMode:NSRunLoopCommonModes];
    }));
    
//    if (@available(iOS 10.0, *)) {
//        dispatch_main_async_safe((^{
//            
//            NSDictionary *dicJson = @{@"type":@"register"};
//            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:NSJSONWritingPrettyPrinted error:nil];
//            [self sendData:jsonData];
//            
//            [self destoryHeartBeat];
//            __weak typeof(self) weakSelf = self;
//            //心跳设置为3分钟，NAT超时一般为5分钟
//            
//            self->heartBeat = [NSTimer scheduledTimerWithTimeInterval:50 repeats:YES block:^(NSTimer * _Nonnull timer) {
//                NSLog(@"-心跳-");
//                //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
//                NSDictionary *dicJson = @{@"type":@"heartbeat"};
//                
//                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicJson options:NSJSONWritingPrettyPrinted error:nil];
//                
//                NSString *jsonSt = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//                
//                [weakSelf sendData:jsonSt];
//            }];
//            [[NSRunLoop currentRunLoop]addTimer:self->heartBeat forMode:NSRunLoopCommonModes];
//        }))
//    } else {
//        // Fallback on earlier versions
//    }
}

//取消心跳
- (void)destoryHeartBeat
{
    dispatch_main_async_safe(^{
        if (self->heartBeat) {
            [self-> heartBeat invalidate];
            self->heartBeat = nil;
        }
    })
}

#define WeakSelf(ws) __weak __typeof(&*self)weakSelf = self
//- (void)sendData:(id)data {
- (void)sendData:(NSString *)data {

    if (data.length == 0) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.socket.readyState == SR_OPEN) {
            [self.socket sendString:data error:nil];
            return;
        }

        //未连接时先缓存，连接成功后由 flushPendingMessages 补发（5 秒内有效，避免过期指令延后执行）
        [self enqueueMessage:data];
        
        if (!self.isNetworkReachable) {
            NSLog(@"socket--当前无网络，指令暂存，等待网络恢复：%@", data);
            return;
        }
        if (self.isAuthFailed) {
            NSLog(@"socket--鉴权失败，指令暂存，等待下次主动连接：%@", data);
            return;
        }
        
        if (self.socket == nil) {
            NSString *url = self.urlSSt.length > 0 ? self.urlSSt : socketWSUrl;
            NSLog(@"socket 未连接，指令暂存并重新建立连接：%@", data);
            [self SRWebSocketOpenWithURLString:url];
        } else if (self.socket.readyState == SR_CLOSING || self.socket.readyState == SR_CLOSED) {
            NSLog(@"socket 已关闭，指令暂存并重连：%@", data);
            //重置退避时间，保证用户操作时立即发起重连
            reConnectTime = 0;
            [self reConnect];
        } else {
            //SR_CONNECTING：等待 webSocketDidOpen 后统一发送
            NSLog(@"socket 连接中，指令暂存待发送：%@", data);
        }
    });
}

- (void)enqueueMessage:(NSString *)data
{
    NSMutableArray<NSDictionary *> *queue = self.pendingMessages;
    [queue addObject:@{@"data": data, @"time": @([[NSDate date] timeIntervalSince1970])}];
    while (queue.count > kMHPendingMessageMaxCount) {
        [queue removeObjectAtIndex:0];
    }
}

- (void)flushPendingMessages
{
    if (self.socket.readyState != SR_OPEN || self.pendingMessages.count == 0) {
        return;
    }
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSArray<NSDictionary *> *queue = [self.pendingMessages copy];
    [self.pendingMessages removeAllObjects];
    for (NSDictionary *item in queue) {
        NSString *message = item[@"data"];
        NSTimeInterval sendTime = [item[@"time"] doubleValue];
        if (message.length > 0 && now - sendTime <= kMHPendingMessageMaxAge) {
            [self.socket sendString:message error:nil];
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
