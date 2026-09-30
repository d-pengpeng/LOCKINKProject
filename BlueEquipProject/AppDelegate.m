//
//  AppDelegate.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/9/8.
//

#import "AppDelegate.h"
#import "TUIKit.h"
#import "TUILoginCache.h"
#import <Bugly/Bugly.h>
#import <QCloudCOSXML/QCloudCOSXMLTransfer.h>

#import <JPUSHService.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "AppVersionManager.h"

@interface AppDelegate ()<QCloudSignatureProvider, QCloudCredentailFenceQueueDelegate, JPUSHRegisterDelegate>
@property (nonatomic, assign) int IMgin;
@property (nonatomic) QCloudCredentailFenceQueue* credentialFenceQueue;
@end

@implementation AppDelegate

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    if (self.allowRotation == YES) {
        //横屏
        return UIInterfaceOrientationMaskLandscape;
    }else{
        //竖屏
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[SwichLanguage shareInstance] setUserlanguage:@""];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents]; //锁屏情况控制播放
    [Bugly startWithAppId:buglyAppIDId];
    [[TUIKit sharedInstance] setupWithAppId:txIMAppId_int];
    if([LYUserDefault userDefault].isLoginBoo) {
        
        [self loginMethodImMethod];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginMethodImMethod) name:@"LoginImNotifFF" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginOutIMIMisLoginOutIMIM) name:@"LogoutImNotifFF" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoginOutIMIMisLoginOutIMIM) name:@"LogoutImNotifFFTwo" object:nil];
    
    [self thridMethodM:launchOptions];

    // 启动网络操作完成后静默检测版本更新（延迟3秒，确保启动流程全部完成）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [AppVersionManager silentCheckAppStoreVersionWithAppId:@"6615071633"];
    });

    return YES;
}


- (void)thridMethodM:(NSDictionary *)launchOptions
{
    //4.8.1 【注册通知】通知回调代理（可选）
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSLog(@"-registrationID--%@", registrationID);
//        [LYUserDefault saveUserRegisterId:registrationID];
    }];

    [JPUSHService setupWithOption:launchOptions appKey:bascicJGAppKey channel:nil apsForProduction:YES advertisingIdentifier:nil];
    
    
//MARK: 存储桶
    QCloudServiceConfiguration* configuration = [QCloudServiceConfiguration new];
    QCloudCOSXMLEndPoint* endpoint = [[QCloudCOSXMLEndPoint alloc] init];

    // 替换为用户的 region，已创建桶归属的region可以在控制台查看，https://console.cloud.tencent.com/cos5/bucket
    // COS支持的所有region列表参见https://www.qcloud.com/document/product/436/6224
    endpoint.regionName = @"eu-frankfurt";//@"ap-guangzhou";
    // 使用 HTTPS
    endpoint.useHTTPS = true;
    configuration.appID = @"1324404581";
    configuration.endpoint = endpoint;
    // 密钥提供者为自己
    configuration.signatureProvider = self;
    // 初始化 COS 服务示例
    [QCloudCOSXMLService registerDefaultCOSXMLWithConfiguration:configuration];
    [QCloudCOSTransferMangerService registerDefaultCOSTransferMangerWithConfiguration:
        configuration];

    // 初始化临时密钥脚手架
    self.credentialFenceQueue = [QCloudCredentailFenceQueue new];
    self.credentialFenceQueue.delegate = self;
    
}

- (void)fenceQueue:(QCloudCredentailFenceQueue *)queue requestCreatorWithContinue:(QCloudCredentailFenceQueueContinue)continueBlock
{
    QCloudCredential* credential = [QCloudCredential new];
    // 临时密钥 SecretId
    // sercret_id替换为用户的 SecretId，登录访问管理控制台查看密钥，https://console.cloud.tencent.com/cam/capi
    credential.secretID = [LYUserDefault userDefault].tmpSecretId;
    // 临时密钥 SecretKey
    // sercret_key替换为用户的 SecretKey，登录访问管理控制台查看密钥，https://console.cloud.tencent.com/cam/capi
    credential.secretKey = [LYUserDefault userDefault].tmpSecretKey;
    // 临时密钥 Token
    // 如果使用永久密钥不需要填入token，如果使用临时密钥需要填入，临时密钥生成和使用指引参见https://cloud.tencent.com/document/product/436/14048
    credential.token = [LYUserDefault userDefault].sessionToken;
    /** 强烈建议返回服务器时间作为签名的开始时间, 用来避免由于用户手机本地时间偏差过大导致的签名不正确(参数startTime和expiredTime单位为秒)
    */
    credential.startDate = [NSDate dateWithTimeIntervalSince1970:[LYUserDefault userDefault].startTime]; // 单位是秒
//    credential.expirationDate = [NSDate dateWithTimeIntervalSince1970:expiredTime]];// 单位是秒
    
    QCloudAuthentationV5Creator* creator = [[QCloudAuthentationV5Creator alloc] initWithCredential:credential];
    continueBlock(creator, nil);

}

- (void)signatureWithFields:(QCloudSignatureFields*)fileds request:(QCloudBizHTTPRequest*)request urlRequest:(NSMutableURLRequest*)urlRequst compelete:(QCloudHTTPAuthentationContinueBlock)continueBlock
{
    NSLog(@"--数据09--%@", [LYUserDefault userDefault].tmpSecretId);
    QCloudCredential* credential = [QCloudCredential new];
    credential.secretID  = [LYUserDefault userDefault].tmpSecretId;
    credential.secretKey = [LYUserDefault userDefault].tmpSecretKey;
    credential.token = [LYUserDefault userDefault].sessionToken;
    credential.startDate = [NSDate dateWithTimeIntervalSince1970:[LYUserDefault userDefault].startTime]; // 单位是秒
    QCloudAuthentationV5Creator* creator = [[QCloudAuthentationV5Creator alloc] initWithCredential:credential];
    QCloudSignature* signature =  [creator signatureForData:urlRequst];
    continueBlock(signature, nil);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    //sdk注册DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//iOS 7 Remote Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

  // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
  completionHandler(UIBackgroundFetchResultNewData);
}

#pragma mark- JPUSHRegisterDelegate // 2.1.9 版新增JPUSHRegisterDelegate,需实现以下两个方法

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
  // Required
  NSDictionary * userInfo = notification.request.content.userInfo;
  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  }
  else {
     // 本地通知
  }
  /*completionHandler(UNNotificationPresentationOptionAlert);*/ // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    completionHandler(UNNotificationPresentationOptionList | UNNotificationPresentationOptionBanner);
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
      [JPUSHService handleRemoteNotification:userInfo];
    }
    else {
       // 本地通知
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
  if (notification) {
    //从通知界面直接进入应用
  }else{
    //从通知设置界面进入应用
  }
}
- (void)jpushNotificationAuthorization:(JPAuthorizationStatus)status withInfo:(NSDictionary *)info
{
    
}


//MARK: 登录IM
- (void)loginMethodImMethod
{
    [JPUSHService setAlias:[LYUserDefault userDefault].t_id completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {

        NSLog(@"--alias--%@", iAlias);
    } seq:0];
    
    if([LYUserDefault userDefault].imUserSig.length>0) {
        [self login:[LYUserDefault userDefault].t_id userSig:[LYUserDefault userDefault].imUserSig succ:nil fail:nil];
    }else {

        [requestToolClass getNetworkWithUrl:request_user_getUserSig andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

            [LYUserDefault saveUIimUserSig:minStr(info)];
            [self login:[LYUserDefault userDefault].t_id userSig:minStr(info) succ:nil fail:nil];
        } fail:^(NSString * _Nonnull msg) {

        }];
    }
}

- (void)login:(NSString *)identifier userSig:(NSString *)sig succ:(TSucc)succ fail:(TFail)fail
{
    [[TUIKit sharedInstance] login:identifier userSig:sig succ:^{
        NSLog(@"-----> 登录成功");
        [[TUILoginCache sharedInstance] saveLogin:identifier withAppId:txIMAppId_int withUserSig:sig];
        
        V2TIMUserFullInfo *info = [[V2TIMUserFullInfo alloc] init];
        info.nickName = [LYUserDefault userDefault].user_nickname;
        info.faceURL = [LYUserDefault userDefault].avatar;
        info.allowType = V2TIM_FRIEND_NEED_CONFIRM;
        [[V2TIMManager sharedInstance] setSelfInfo:info succ:^{
            NSLog(@"更新 IM昵称 成功");
        } fail:^(int code, NSString *desc) {
            NSLog(@"更新 IM昵称 失败");
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadIMListNotif" object:nil];
    } fail:^(int code, NSString *msg) {
        NSLog(@"-----> 登录失败");
        [self getImSignMehtod];
    }];
}

- (void)getImSignMehtod
{
    if(self.IMgin > 1) {
        return;
    }
    self.IMgin = self.IMgin + 1;
    NSString *url_url = [NSString stringWithFormat:@"%@?userId=%@", request_user_getUserSig, [LYUserDefault userDefault].t_id];
    [requestToolClass getNetworkWithUrl:url_url andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [LYUserDefault saveUIimUserSig:minStr(info)];
        [self login:[LYUserDefault userDefault].t_id userSig:minStr(info) succ:nil fail:nil];
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)isLoginOutIMIMisLoginOutIMIM
{
    [[TUIKit sharedInstance] logout:^{
            
        [[TUILoginCache sharedInstance] logout];
        NSLog(@"IM退出成功");
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadIMListNotif" object:nil];
//        });
        
    } fail:^(int code, NSString *msg) {
        NSLog(@"IM退出失败--%@", msg);
    }];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    
    return YES;
}


#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
