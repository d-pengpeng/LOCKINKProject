//
//  eSocketRocketUtility.m
//  yunbaolive
//
//  东莞梦幻网络科技有限公司 注 on 2020/8/18.
//  Copyright © 2020 cat. All rights reserved.
//

#import "eSocketRocketUtility.h"
#import <SocketRocket.h>

@interface eSocketRocketUtility()<SRWebSocketDelegate>
{
    int _index;
    NSTimer * heartBeat;
    NSTimeInterval reConnectTime;
}

@property (nonatomic,strong) SRWebSocket *socket;
@property (nonatomic, assign) BOOL isBOpen;
@end

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
    
    }
    return self;
}

- (BOOL)getSocketCloseBoo
{
    return !self.isBOpen;
}

//开启连接
-(void)SRWebSocketOpenWithURLString:(NSString *)urlString {
    if(self.isBOpen) {
        return;
    }
    if (self.socket) {
        return;
    }

    if (!urlString) {
        return;
    }
    self.urlSSt = urlString;
    //SRWebSocketUrlString 就是websocket的地址 写入自己后台的地址
    
    NSURLRequest *urlRquest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    urlRquest.allHTTPHeaderFields = @{@"token":TOKEN};
    NSMutableURLRequest *mutableRequest = [urlRquest mutableCopy];
    [mutableRequest setValue:TOKEN forHTTPHeaderField:@"token"];
    [mutableRequest setValue:@"zh-CN" forHTTPHeaderField:@"Accept-Language"];
    //3.把值覆给request
    urlRquest = [mutableRequest copy];
    
    NSLog(@"%@", urlRquest.allHTTPHeaderFields);
    self.socket = [[SRWebSocket alloc] initWithURLRequest:urlRquest];
    
    self.socket.delegate = self;   //SRWebSocketDelegate 协议
    
    [self.socket open];     //开始连接
}

- (void)SRWebSocketSendJsonDic:(NSDictionary *)jsonDic
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonSt = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self sendData:jsonSt];
}

//MARK: 重新连接
- (void)SRWebSocketOpen {
    
    if (self.urlSSt) {
        
        self.socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlSSt]]];
        self.socket.delegate = self;   //SRWebSocketDelegate 协议
        [self.socket open];
    }
}

//关闭连接
- (void)SRWebSocketClose {
    if (self.socket){
        [self.socket close];
        self.socket = nil;
        //断开连接时销毁心跳
        [self destoryHeartBeat];
    }
}

#pragma mark - socket delegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"连接成功，可以与服务器交流了,同时需要开启心跳");
    //每次正常连接的时候清零重连时间
    reConnectTime = 0;
    self.isBOpen = YES;
    //开启心跳 心跳是发送pong的消息 我这里根据后台的要求发送data给后台
    [self initHeartBeat];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"连接失败，这里可以实现掉线自动重连，%@", error);
    NSLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    NSLog(@"2.判断调用层是否需要连接，例如用户都没在聊天界面，连接上去浪费流量");
    _socket = nil;
    self.isBOpen = NO;
    //连接失败就重连
    [self reConnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",code,reason,wasClean);
    //断开连接 同时销毁心跳
    [self SRWebSocketClose];
    self.isBOpen = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNeedChangeGoodsUploginNote object:@""];
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
    [self SRWebSocketClose];
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64) {
        return;
    }
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.socket = nil;
        [self SRWebSocketOpen];
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
                [self reConnect];
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

    WeakSelf(ws);
    dispatch_queue_t queue =  dispatch_queue_create("zy", NULL);
    
    dispatch_async(queue, ^{
        if (weakSelf.socket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法，不然要崩
            if (weakSelf.socket.readyState == SR_OPEN) {
//                [weakSelf.socket send:data];    // 发送数据
                [weakSelf.socket sendString:data error:nil];
            } else if (weakSelf.socket.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                [self reConnect];
                
            } else if (weakSelf.socket.readyState == SR_CLOSING || weakSelf.socket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                [self reConnect];
            }
        } else {
            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
        }
    });
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
