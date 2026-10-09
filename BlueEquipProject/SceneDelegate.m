//
//  SceneDelegate.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/9/8.
//

#import "SceneDelegate.h"
#import "RootViewController.h"
#import "CJNavigationController.h"
#import "MHwelcomLoginController.h"
#import "MHGuideViewController.h"

#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "MHEquipmentModel.h"
#import "AESCipher.h"

@interface SceneDelegate ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, assign) BOOL isBackgroundBoo; //Yes 前台 No后台
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CBCentralManager *myCentralManager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBCharacteristic *characteristic;
@property (nonatomic, strong) CBCharacteristic *characteristic2;

@property (nonatomic, assign) CBCharacteristicProperties characteristicType;
@property (strong, nonatomic) NSString *blue_tokenKey; //刚连接设备更新token
@property (nonatomic, assign) NSInteger isFirstMAC;
@property (nonatomic, assign) BOOL isAddEquip;
@property (nonatomic, assign) BOOL isListBle;
@property (nonatomic, assign) BOOL bluetoothBtn;
@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    [FloatingWindowModel shareInstance].isEnableBluetooth = NO;
    self.blue_tokenKey = @"";
    self.isBackgroundBoo = YES;
    
    [FloatingWindowModel shareInstance].macStMMM = @"";
    [FloatingWindowModel shareInstance].macStMMM2 = @"";
    [FloatingWindowModel shareInstance].namStMMM = @"";
    [FloatingWindowModel shareInstance].ElecStr = @"0";
    
    if([LYUserDefault userDefault].isFirstStart) {
        [NSThread sleepForTimeInterval:1.0]; //增加启动图停留时间
        
        if([LYUserDefault userDefault].isLoginBoo) {
            
            if([LYUserDefault userDefault].adListArr.count > 0) {

                MHGuideViewController *root = [[MHGuideViewController alloc] init];
                self.window.rootViewController = root;
            }else {
                
                RootViewController *root = [[RootViewController alloc] init];
                self.window.rootViewController = root;
            }
        }else {
            
            MHwelcomLoginController *root = [[MHwelcomLoginController alloc] init];
            CJNavigationController *nav = [[CJNavigationController alloc]initWithRootViewController:root];
            self.window.rootViewController = nav;
        }
        
    }else {
        MHwelcomLoginController *root = [[MHwelcomLoginController alloc] init];
        CJNavigationController *nav = [[CJNavigationController alloc]initWithRootViewController:root];
        self.window.rootViewController = nav;
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChagneMethodNotif) name:@"languageChagneMethodNotif" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotifMethodNotif) name:@"loginNotifMethod" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LogoutImNotifFFMethodNotif) name:@"LogoutImNotifFF" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifStartScanBlueServiceNameMethodNotif) name:@"notifStartScanBlueServiceName" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PostbluuConnectedNotifTwoEthod) name:@"bluuConnectedNotifTwo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadBluoothNotifMMMEthod:) name:@"uploadBluoothNotifMMM" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PostNotifServiceNotifNameMEthod:) name:@"PostNotifServiceNotifName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(app_sendCustomNotifNameMMethodUIUI:) name:app_sendCustomNotifName object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closePeripheralNameNotifNotif:) name:@"closePeripheralNameNotif" object:nil];
    
}

- (void)LogoutImNotifFFMethodNotif
{
    MHwelcomLoginController *root = [[MHwelcomLoginController alloc] init];
    CJNavigationController *nav = [[CJNavigationController alloc]initWithRootViewController:root];
    self.window.rootViewController = nav;
}

- (void)loginNotifMethodNotif
{
    
    
    
    RootViewController *root = [[RootViewController alloc]init];
    self.window.rootViewController = root;
    [root setSelectedIndex:0];
}

- (void)languageChagneMethodNotif
{
  
    RootViewController *root = [[RootViewController alloc]init];
    self.window.rootViewController = root;
    [root setSelectedIndex:0];
}

- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNeedEnterForegroundNote object:@"1"];

    self.isBackgroundBoo = YES;
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    self.isBackgroundBoo = NO;
    NSLog(@"应用进入后台");
    
    if (self.bluetoothBtn) {
        // 创建后台任务以保持蓝牙连接
        __block UIBackgroundTaskIdentifier backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            // 后台任务即将结束时的处理
            [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskIdentifier];
            backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        }];
        
        // 在后台持续发送数据的示例
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            while (backgroundTaskIdentifier != UIBackgroundTaskInvalid) {
                // 每5秒发送一次数据
                if (!self.isBackgroundBoo) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self getElectricQuantityMethod];
                        NSLog(@"应用进入后台 --发指令");
                    });
                    
                    [NSThread sleepForTimeInterval:5.0];
                }else {
                    backgroundTaskIdentifier = UIBackgroundTaskInvalid;
                }
            }
        });
    }
    
    if ([FloatingWindowModel shareInstance].device_namL && [[FloatingWindowModel shareInstance].device_namL isEqualToString:kCharactName7]) {
        
    }else {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNeedEnterForegroundNote object:@"2"];
    }
    
}

- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts
{
//    UIOpenURLContext *urlCC = URLContexts.allObjects.firstObject;
//    if(urlCC.URL != nil) {
//        [[spotifyRemoteConfigModel shareInstance] spotifyAuthorizationParametUrl:urlCC.URL];
//    }
}

- (void)notifStartScanBlueServiceNameMethodNotif
{
    
    [self.myCentralManager stopScan];
    if (self.peripheral) {
        [self.myCentralManager cancelPeripheralConnection:self.peripheral];
    }
    self.myCentralManager = nil;
    self.peripheral = nil;
    self.characteristic = nil;
    
    [FloatingWindowModel shareInstance].isEnableBluetooth = NO;
    self.blue_tokenKey = @"";
    self.isBackgroundBoo = YES;
    
    [FloatingWindowModel shareInstance].macStMMM = @"";
    [FloatingWindowModel shareInstance].macStMMM2 = @"";
    [FloatingWindowModel shareInstance].namStMMM = @"";
    [FloatingWindowModel shareInstance].ElecStr = @"0";
    [[FloatingWindowModel shareInstance].serviceArrs removeAllObjects];
    [[FloatingWindowModel shareInstance].idArrs removeAllObjects];
    
    
    [self startBlueToothisBooMethod];
}

- (void)startBlueToothisBooMethod
{
    NSDictionary *options = @{CBCentralManagerOptionShowPowerAlertKey: @YES}; //弹窗
    self.myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue() options:options];
}

//MARK:  扫面的结果会通过CBCentralManagerDelegate回调
- (void)centralManagerDidUpdateState:(CBCentralManager*)central
{
    [FloatingWindowModel shareInstance].isEnableBluetooth = NO;
    NSString *strMessage = @"";
    switch (central.state) {
        case CBManagerStatePoweredOn: {
            
            [FloatingWindowModel shareInstance].isEnableBluetooth = YES;
            [self.myCentralManager scanForPeripheralsWithServices:nil options:nil];
            return;
        }
            break;
        case CBManagerStateUnknown: {
            strMessage = eLocalizedString(@"toys_all8");
        }
            break;
        case CBManagerStateResetting: {
            strMessage = eLocalizedString(@"toys_all9");
        }
            break;
        case CBManagerStateUnsupported: {
            strMessage = @"手机不支持蓝牙功能，请更换手机。";
        }
            break;
        case CBManagerStatePoweredOff: {
            strMessage = eLocalizedString(@"toys_all10");
        }
            break;
        case CBManagerStateUnauthorized: {
            strMessage = eLocalizedString(@"toys_all11");
        }
            break;
        default:
            break;
    }
    if (strMessage.length > 0) {
//        [self __broadAlertMessage:strMessage];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"blueMsgBlueMsgNotiffName" object:strMessage];
    }
}


- (void)centralManager:(CBCentralManager*)central didDiscoverPeripheral:(CBPeripheral*)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber*)RSSI
{
    NSString *perName = peripheral.name;
    if(perName == nil){
        return;
    }
    NSLog(@"-蓝牙设备名----%@", perName); // RSSI 是信号强度 可以通过强度选择最近的设备
    
    //MARK: 蓝牙连接设备
    if (([perName isEqualToString:kCharactName] || [perName isEqualToString:kCharactName2] || [perName isEqualToString:kCharactName3] || [perName isEqualToString:kCharactName4] || [perName isEqualToString:kCharactName5] || [perName isEqualToString:kCharactName6] || [perName isEqualToString:kCharactName7] || [perName isEqualToString:kCharactName8] || [perName isEqualToString:kCharactName9] || [perName isEqualToString:kCharactName10] || [perName isEqualToString:kCharactName11] || [perName isEqualToString:kCharactName12] || [perName isEqualToString:kCharactName13] || [perName isEqualToString:kCharactName14] || [perName isEqualToString:kCharactName15]|| [perName isEqualToString:kCharactName16] || [perName isEqualToString:kCharactName17]) && peripheral) {

        NSData *dataMac = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
        NSString *mac = @"";
        
        if ([perName isEqualToString:kCharactName5]) {
            mac = [self getMacMethodUIModel4:dataMac];
        }else {
            if ([perName isEqualToString:kCharactName13]) {
                mac = [self getThreethMacMethodUI:dataMac];
            }else {
                mac = [self getMacMethodUI:dataMac];
            }
        }
        
        NSLog(@"-Mac值OK-- %@ -- %@", minStr(dataMac), mac);
        if(mac.length>0) {
            
            if(![[FloatingWindowModel shareInstance].idArrs containsObject:mac]) {
                [[FloatingWindowModel shareInstance].idArrs addObject:mac];
                [[FloatingWindowModel shareInstance].serviceArrs addObject:peripheral];
                
                if (self.peripheral != nil) { //注释掉 就可以自动连接

                }else {
                    
                    if([[FloatingWindowModel shareInstance].datasMut2 containsObject:mac]) {
//                        _oneNumLab.text = eLocalizedString(@"home_nam2");
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffName" object:eLocalizedString(@"home_nam2")];
                        
                        [FloatingWindowModel shareInstance].macStMMM = mac;
                        [FloatingWindowModel shareInstance].namStMMM = peripheral.name;
                        self.isAddEquip = YES;
                        self.peripheral = peripheral;
                        [self.myCentralManager connectPeripheral:peripheral options:nil];
                    }
                }
            }else {
                int ll_n = -1;
                for (int i=0; i<[FloatingWindowModel shareInstance].idArrs.count; i++) {
                    if([minStr([FloatingWindowModel shareInstance].idArrs[i]) isEqualToString:mac]) {
                        ll_n = i;
                    }
                }
                if(ll_n >= 0) {
                    [[FloatingWindowModel shareInstance].idArrs removeObjectAtIndex:ll_n];
                    [[FloatingWindowModel shareInstance].serviceArrs removeObjectAtIndex:ll_n];
                }
                
                [[FloatingWindowModel shareInstance].idArrs addObject:mac];
                [[FloatingWindowModel shareInstance].serviceArrs addObject:peripheral];
                
                if (self.peripheral != nil) {
                   
                }else {
                    if([[FloatingWindowModel shareInstance].datasMut2 containsObject:mac]) {
//                        _oneNumLab.text = eLocalizedString(@"home_nam2");
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffName" object:eLocalizedString(@"home_nam2")];
                        
                        [FloatingWindowModel shareInstance].macStMMM = mac;
                        [FloatingWindowModel shareInstance].namStMMM = peripheral.name;
                        self.isAddEquip = YES;
                        self.peripheral = peripheral;
                        [self.myCentralManager connectPeripheral:peripheral options:nil];
                    }
                }
            }
        }
        
        if ([FloatingWindowModel shareInstance].bleLBooThr) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bleServicesNotif" object:nil userInfo:@{@"sericeArr":[FloatingWindowModel shareInstance].serviceArrs, @"macsArr":[FloatingWindowModel shareInstance].idArrs}];
        }
    }
}
    
- (void)PostbluuConnectedNotifTwoEthod
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"bleServicesNotif" object:nil userInfo:@{@"sericeArr":[FloatingWindowModel shareInstance].serviceArrs, @"macsArr":[FloatingWindowModel shareInstance].idArrs}];
}

- (void)uploadBluoothNotifMMMEthod:(NSNotification *)notifNNN
{
    BOOL isEEEqq = [[FloatingWindowModel shareInstance].macStMMM compare:minStr(notifNNN.object) options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        [[FloatingWindowModel shareInstance].datasMut2 removeObject:[minStr(notifNNN.object) uppercaseString]];
//        _oneNumLab.text = eLocalizedString(@"home_nam1");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffName" object:eLocalizedString(@"home_nam1")];
        
        [self DeviceMethodUploadKZ];
        if (self.peripheral != nil) {
            self.isListBle = YES;
            [self.myCentralManager cancelPeripheralConnection:self.peripheral];
            self.peripheral = nil;
        }
        self.isFirstMAC = 0;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffNameUploadData" object:nil]; //更新数据列表
//    [self RequestListData];
}
    
- (void)PostNotifServiceNotifNameMEthod:(NSNotification *)noitfNN
{
    NSDictionary *dicMMM = noitfNN.userInfo;
    NSArray *sericeArrW = dicMMM[@"sericeArr"];
    NSString *serRow = minStr(dicMMM[@"rowN"]);
    
    if(sericeArrW.count > [serRow intValue]) {
        
        CBPeripheral *pppperal = sericeArrW[[serRow intValue]];
        NSString *mac_ss = minStr(dicMMM[@"mac"]);
        self.isAddEquip = YES;
        if(pppperal) {
            
            if(self.isFirstMAC>0) {
                if (self.peripheral != pppperal) {
//                    _oneNumLab.text = eLocalizedString(@"home_nam2");
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffName" object:eLocalizedString(@"home_nam2")];
                    
                    if (self.peripheral != nil) {
                        self.isListBle = YES;
                        [self.myCentralManager cancelPeripheralConnection:self.peripheral];
                    }
                    
                    [FloatingWindowModel shareInstance].macStMMM = mac_ss;
                    [FloatingWindowModel shareInstance].namStMMM = pppperal.name;
                    self.peripheral = pppperal;
                    [self.myCentralManager connectPeripheral:pppperal options:nil];
                }
            }else {
                
//                _oneNumLab.text = eLocalizedString(@"home_nam2");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffName" object:eLocalizedString(@"home_nam2")];
                
                if (self.peripheral != nil) {
                    self.isListBle = YES;
                    [self.myCentralManager cancelPeripheralConnection:self.peripheral];
                }
                
                [FloatingWindowModel shareInstance].macStMMM = mac_ss;
                [FloatingWindowModel shareInstance].namStMMM = pppperal.name;
                self.peripheral = pppperal;
                [self.myCentralManager connectPeripheral:pppperal options:nil];
            }
        }
    
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bluuConnectedNotif" object:@{@"status":@"2", @"mac":[FloatingWindowModel shareInstance].macStMMM2}];
    }
}

//MARK: 连接代理
- (void)centralManager:(CBCentralManager*)central didConnectPeripheral:(CBPeripheral*)peripheral
{
    NSLog(@"连接成功");
    if(self.peripheral && (self.peripheral != nil)) {
        self.peripheral.delegate = self;
        //外围设备开始寻找服务
        if ([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName13]) {
            self.blue_tokenKey = @"";
            [self.peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceQiuiUUID]]];
        }else {
            [self.peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceUUID]]];
        }
        
    }else {
        NSLog(@"连接成功--无效外设");
    }
}

//MARK: 连接失败
- (void)centralManager:(CBCentralManager*)central didFailToConnectPeripheral:(CBPeripheral*)peripheral error:(nullable NSError*)error
{
//    _oneNumLab.text = eLocalizedString(@"home_nam1");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffName" object:eLocalizedString(@"home_nam1")];
    
    NSLog(@"连接失败");
    [self DeviceMethodUploadKZ];
    
    if(self.peripheral == peripheral) {
        if([FloatingWindowModel shareInstance].isWWWWBoo) {
            NSString *sssM = @"";
            for (int i=0; i<[FloatingWindowModel shareInstance].datasMut.count; i++) {
                MHEquipmentModel *model = [FloatingWindowModel shareInstance].datasMut[i];
                if([[model.mac uppercaseString] isEqualToString:[FloatingWindowModel shareInstance].macStMMM2]) {
                    sssM = minIntStr(model.id);
                }
            }
            if(sssM.length > 0) {
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":sssM, @"operate":@"2"}];
            }
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bluuConnectedNotif" object:@{@"status":@"2", @"mac":[FloatingWindowModel shareInstance].macStMMM2}];
        }
    }
    
    self.bluetoothBtn = NO;
    [FloatingWindowModel shareInstance].bluetoothBtn_bo = NO;
    self.isListBle = YES;
    [LYUserDefault saveMacName:@""];
    
    if(self.peripheral == peripheral) {
        if ([FloatingWindowModel shareInstance].serviceArrs.count > 0) {
            
            self.isFirstMAC = 0;
            [[FloatingWindowModel shareInstance].serviceArrs removeAllObjects];
            [[FloatingWindowModel shareInstance].idArrs removeAllObjects];
            if ([FloatingWindowModel shareInstance].bleLBooThr) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"bleServicesNotif" object:nil userInfo:@{@"sericeArr":[FloatingWindowModel shareInstance].serviceArrs, @"macsArr":[FloatingWindowModel shareInstance].idArrs}];
            }
        }else {
            if ([FloatingWindowModel shareInstance].bleLBooThr) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"bleServicesNotif" object:nil userInfo:@{@"sericeArr":[FloatingWindowModel shareInstance].serviceArrs, @"macsArr":[FloatingWindowModel shareInstance].idArrs}];
            }
            self.isFirstMAC = 0;
        }
    }else {
    
        int yy_y = -1;
        for (int i=0; i<[FloatingWindowModel shareInstance].serviceArrs.count; i++) {
            CBPeripheral *pprr = [FloatingWindowModel shareInstance].serviceArrs[i];
            if(pprr == peripheral) {
                [[FloatingWindowModel shareInstance].idArrs removeObjectAtIndex:i];
                yy_y = i;
            }
        }
        if(yy_y >= 0) {
            [[FloatingWindowModel shareInstance].serviceArrs removeObjectAtIndex:yy_y];
        }

        if ([FloatingWindowModel shareInstance].bleLBooThr) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bleServicesNotif" object:nil userInfo:@{@"sericeArr":[FloatingWindowModel shareInstance].serviceArrs, @"macsArr":[FloatingWindowModel shareInstance].idArrs}];
        }
    }
    [self.myCentralManager scanForPeripheralsWithServices:nil options:nil];
    
    [FloatingWindowModel shareInstance].macStMMM2 = @"";
    for (MHEquipmentModel *model in [FloatingWindowModel shareInstance].datasMut) {
        model.isShowLinks = NO;
    }
//    [self.appTableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"1" userInfo:nil];
    
    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"ble_fail")];
}

//MARK: 断开连接结果
- (void)centralManager:(CBCentralManager*)central didDisconnectPeripheral:(CBPeripheral*)peripheral error:(nullable NSError*)error
{
//    _oneNumLab.text = eLocalizedString(@"home_nam1");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffName" object:eLocalizedString(@"home_nam1")];
    
    [self DeviceMethodUploadKZ];
    NSLog(@"断开连接");
    if(self.peripheral == peripheral) {
        
        if([FloatingWindowModel shareInstance].isWWWWBoo) {
            NSString *sssM = @"";
            for (int i=0; i<[FloatingWindowModel shareInstance].datasMut.count; i++) {
                MHEquipmentModel *model = [FloatingWindowModel shareInstance].datasMut[i];
                if([[model.mac uppercaseString] isEqualToString:[FloatingWindowModel shareInstance].macStMMM2]) {
                    sssM = minIntStr(model.id);
                }
            }
            if(sssM.length > 0) {
                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"DEVICE-CONNECT", @"deviceId":sssM, @"operate":@"2"}]; //MARK: 是否连接设备 反馈给后台
            }
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bluuConnectedNotif" object:@{@"status":@"2", @"mac":[FloatingWindowModel shareInstance].macStMMM2}];
        }
    }
    
    [LYUserDefault saveMacName:@""];
    self.bluetoothBtn = NO;
    [FloatingWindowModel shareInstance].bluetoothBtn_bo = NO;

    if(self.peripheral == peripheral) {
        if ([FloatingWindowModel shareInstance].serviceArrs.count > 0) {
            
            self.isFirstMAC = 0;
            [[FloatingWindowModel shareInstance].serviceArrs removeAllObjects];
            [[FloatingWindowModel shareInstance].idArrs removeAllObjects];
            if ([FloatingWindowModel shareInstance].bleLBooThr) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"bleServicesNotif" object:nil userInfo:@{@"sericeArr":[FloatingWindowModel shareInstance].serviceArrs, @"macsArr":[FloatingWindowModel shareInstance].idArrs}];
            }
            
        }else {
            if ([FloatingWindowModel shareInstance].bleLBooThr) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"bleServicesNotif" object:nil userInfo:@{@"sericeArr":[FloatingWindowModel shareInstance].serviceArrs, @"macsArr":[FloatingWindowModel shareInstance].idArrs}];
            }
            self.isFirstMAC = 0;
        }
    }else {
        int yy_y = -1;
        for (int i=0; i<[FloatingWindowModel shareInstance].serviceArrs.count; i++) {
            CBPeripheral *pprr = [FloatingWindowModel shareInstance].serviceArrs[i];
            if(pprr == peripheral) {
                [[FloatingWindowModel shareInstance].idArrs removeObjectAtIndex:i];
                yy_y = i;
            }
        }
        if(yy_y >= 0) {
            [[FloatingWindowModel shareInstance].serviceArrs removeObjectAtIndex:yy_y];
        }
        if ([FloatingWindowModel shareInstance].bleLBooThr) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bleServicesNotif" object:nil userInfo:@{@"sericeArr":[FloatingWindowModel shareInstance].serviceArrs, @"macsArr":[FloatingWindowModel shareInstance].idArrs}];
        }
    }
    
    [self.myCentralManager scanForPeripheralsWithServices:nil options:nil];
    
    [FloatingWindowModel shareInstance].macStMMM2 = @"";
    for (MHEquipmentModel *model in [FloatingWindowModel shareInstance].datasMut) {
        model.isShowLinks = NO;
    }
    
//    [self.appTableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"1" userInfo:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    NSLog(@"已发现可用服务...");
    if (error) {
        NSLog(@"外围设备寻找服务过程中发生错误，错误信息：%@",error.localizedDescription);
    }
     
    //遍历查找到的服务
    if ([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName13]) {
        
        CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceQiuiUUID];
        CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicQiuiUUID];
        CBUUID *characteristicUUID2 = [CBUUID UUIDWithString:kCharacteristicQiuiUUID2];
        for (CBService *service in peripheral.services){
            if ([service.UUID isEqual:serviceUUID]) {
                //外围设备查找指定服务中的特征
                [self.peripheral discoverCharacteristics:@[characteristicUUID, characteristicUUID2] forService:service];
            }
        }
    }else {
        
        CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
        CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
        CBUUID *characteristicUUID2 = [CBUUID UUIDWithString:kCharacteristicUUID2];
        for (CBService *service in peripheral.services){
            if ([service.UUID isEqual:serviceUUID]) {
                //外围设备查找指定服务中的特征
                [self.peripheral discoverCharacteristics:@[characteristicUUID, characteristicUUID2] forService:service];
            }
        }
    }
}

//MARK: 外围设备寻找到特征后
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    NSLog(@"已发现可用特征....");
    if (error) {
        NSLog(@"外围设备寻找特征过程中发生错误，错误信息：%@",error.localizedDescription);
    }
    
    //遍历服务中的特征
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    CBUUID *characteristicUUID2 = [CBUUID UUIDWithString:kCharacteristicUUID2];
    if ([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName13]) {
        
        serviceUUID = [CBUUID UUIDWithString:kServiceQiuiUUID];
        characteristicUUID = [CBUUID UUIDWithString:kCharacteristicQiuiUUID];
        characteristicUUID2 = [CBUUID UUIDWithString:kCharacteristicQiuiUUID2];
    }
    
    BOOL wwM = NO;
    if ([service.UUID isEqual:serviceUUID]) {
        
        for (CBCharacteristic *characteristic in service.characteristics){
            
            if ([characteristic.UUID isEqual:characteristicUUID]) {
                self.characteristic = characteristic;
                wwM = YES;
                
                self.characteristicType = characteristic.properties;
                
            }if ([characteristic.UUID isEqual:characteristicUUID2]) {
                self.characteristic2 = characteristic;
            }
        }
    }
    if(wwM) {
        
        self.isFirstMAC = 1;
        [FloatingWindowModel shareInstance].macStMMM2 = [FloatingWindowModel shareInstance].macStMMM;
        self.bluetoothBtn = YES;
        [FloatingWindowModel shareInstance].bluetoothBtn_bo = YES;
        
        self.isListBle = NO;
        if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName2] || [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName13]) {
            
            [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic2];
            [self.peripheral discoverDescriptorsForCharacteristic:self.characteristic2];
            
        }else {
            
            if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName5] || [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName6] || [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName7] || [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName8] || [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName9] || [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName10] || [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName11] || [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName14]|| [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName16]|| [[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName17]) {
                
                [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic2];
                
            }else {
                [self.peripheral discoverDescriptorsForCharacteristic:self.characteristic];
                [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic];
                [self.peripheral discoverDescriptorsForCharacteristic:self.characteristic2];
                [self.peripheral setNotifyValue:YES forCharacteristic:self.characteristic2];
    
            }
            
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getElectricQuantityMethod];
            if(![[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName13]) {
                [self uiuiuNewElectricMMM];
            }
        });
        
    }else {
//        _oneNumLab.text = eLocalizedString(@"home_nam1");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffName" object:eLocalizedString(@"home_nam1")];
        
        [self DeviceMethodUploadKZ];
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"ble_fail3")];
    }
}

//MARK: 循环发送 电量指令
- (void)uiuiuNewElectricMMM
{
    if(self.bluetoothBtn) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.isBackgroundBoo) {
                [self getElectricQuantityMethod];
            }
            [self uiuiuNewElectricMMM];
        });
    }
}

//MARK: 获取电量
- (void)getElectricQuantityMethod
{
    NSLog(@"发送电池模式--电量");
    if(self.peripheral && (self.peripheral != nil)) {
        if(self.characteristic && (self.characteristic != nil)) {
 
            if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName2]) {
                
                Byte byteArray[] = {0xAA, 0x03};
                NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                }else {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                }
                [LYUserDefault saveMacId:[FloatingWindowModel shareInstance].macStMMM2];
            }else if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName5]) {
                
                Byte byteArray[] = {0xAA, 0x00};
                NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                }else {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                }
                
                [LYUserDefault saveMacId:[FloatingWindowModel shareInstance].macStMMM2];
            }else if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName13]) {
                
                NSString *originalString = [HistoryRecordModel getNowThreethTimeInterval];
                NSString *blue_str = [NSString stringWithFormat:@"00E10100%@0000000000000000", originalString];
                
                NSData *cipherData = [AESCipher aes128ECBEncrypt:blue_str keyHex:blue_EncryptionKey];
                NSString *encryptedCommand = [AESCipher dataToHexString:cipherData];

                if (encryptedCommand) {
                    
                    NSLog(@"指令加密-- 前%@ --后%@", blue_str, encryptedCommand);
                    NSData *param = [self functionUnsend:encryptedCommand]; //[encryptedCommand dataUsingEncoding:NSUTF8StringEncoding];
            
                    if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    }else {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    }
               
                    [LYUserDefault saveMacId:[FloatingWindowModel shareInstance].macStMMM2];
                } else {
                    NSLog(@"加密失败");
                }
            }
            else {
                
                Byte byteArray[] = {0xAA, 0x09, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF};
                NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                if([self.namStMMM isEqualToString:kCharactName12] || [self.namStMMM isEqualToString:kCharactName6]) {   //kCharactName3 新设备也是 CBCharacteristicWriteWithoutResponse 待确定
//                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                }else {
//
//                }
                
                if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                }else {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                }
                
                [LYUserDefault saveMacId:[FloatingWindowModel shareInstance].macStMMM2];
            }
        }
    }
}


- (void)app_sendCustomNotifNameMMethodUIUI:(NSNotification *)notifff
{
    NSDictionary *notiDic = notifff.userInfo;

    if([minStr(notiDic[@"motor"]) isEqualToString:@"2"]) {
        
        //电击
        [self ControlAutomaticTypeMethodMotor:[minStr(notiDic[@"strong"]) intValue] strong:[minStr(notiDic[@"strong2"]) intValue] strong2:[minStr(notiDic[@"strong3"]) intValue] strong3:[minStr(notiDic[@"strong4"]) intValue]];
    }else if([minStr(notiDic[@"motor"]) isEqualToString:@"1"]) {
        
        //开锁
        [self kaiSuoDianji:[minStr(notiDic[@"strong"]) intValue] dianji:[minStr(notiDic[@"strong2"]) intValue]];
    }else if([minStr(notiDic[@"motor"]) isEqualToString:@"3"]) {
        
        //定时锁
        [self dingShiFadaojishi:[minStr(notiDic[@"strong"]) intValue] zhendong:[minStr(notiDic[@"strong2"]) intValue] changdianji:[minStr(notiDic[@"strong3"]) intValue] qiangdu:[minStr(notiDic[@"strong4"]) intValue] DJShichang:-1];
    }else if([minStr(notiDic[@"motor"]) isEqualToString:@"4"]) {
        
        //定时锁  二期
        //strong2 类型、 strong3 是否长电击 、 strong4 电击强度 、 strong5 电击时长
        [self dingShiFadaojishi:[minStr(notiDic[@"strong"]) intValue] zhendong:[minStr(notiDic[@"strong2"]) intValue] changdianji:[minStr(notiDic[@"strong3"]) intValue] qiangdu:[minStr(notiDic[@"strong4"]) intValue] DJShichang:[minStr(notiDic[@"strong5"]) intValue]];
    }else if([minStr(notiDic[@"motor"]) isEqualToString:@"31"]) {
        
        
        //  三期 马眼棒 经典
        if ([minStr(notiDic[@"inBerserkMode"]) isEqualToString:@"1"]) {
            NSLog(@"--经典数据 狂暴---%@", notiDic);
            //狂暴
            [self fouQiModelKuangBaoTypeMEthod];
        }else {
            if ([minStr(notiDic[@"inRandomMode"]) isEqualToString:@"1"]) {
                NSLog(@"--经典数据 随机---%@", notiDic);
                //随机
                [self fouQiModelSuiJiTypeOnethr:[minStr(notiDic[@"minVoltage"]) intValue] fou:[minStr(notiDic[@"maxVoltage"]) intValue]];
            }else {
//                NSLog(@"--经典数据---%@", notiDic);
                [self fouQiModelTypeOne:[minStr(notiDic[@"shakeIntensity"]) intValue] two:[minStr(notiDic[@"shakeFrequency"]) intValue] thr:[minStr(notiDic[@"voltage"]) intValue] fou:[minStr(notiDic[@"electricFrequency"]) intValue]];
            }
        }
        
    }else if([minStr(notiDic[@"motor"]) isEqualToString:@"32"]) {
        
        if ([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName5]) {
            
            if ([minStr(notiDic[@"inSpinMode"]) isEqualToString:@"1"]) {
                
                if ([minStr(notiDic[@"inElectricMode"]) isEqualToString:@"1"]) {
                    [self YaoYiYaoModelTypeOne:[minStr(notiDic[@"shakeIntensity"]) intValue] two:[minStr(notiDic[@"spinDirection"]) intValue] thr:[minStr(notiDic[@"voltage"]) intValue]];
                }else {
                    [self YaoYiYaoModelTypeOne:[minStr(notiDic[@"shakeIntensity"]) intValue] two:[minStr(notiDic[@"spinDirection"]) intValue] thr:0];
                }
            }else {
                if ([minStr(notiDic[@"inElectricMode"]) isEqualToString:@"1"]) {
                    [self YaoYiYaoModelTypeOne:0 two:[minStr(notiDic[@"spinDirection"]) intValue] thr:[minStr(notiDic[@"voltage"]) intValue]];
                }else {
                    [self YaoYiYaoModelTypeOne:0 two:[minStr(notiDic[@"spinDirection"]) intValue] thr:0];
                }
            }
            
        }else {
            NSLog(@"-接收123- %@", notiDic);
            //  三期 马眼棒  摇一摇、语音
//            {"deviceId":39072,"mac":"C6:52:96:39:9E:96","realName":"AA-A1014","inSpinMode":false,"spinIntensity":5,"spinDirection":1,"inElectricMode":true,"voltage":5,"shakeIntensity":5,"type":"AIRPLANE-BOTTLE-SENSOR-MODE"} iOS发安卓
            
            
//            {
//                inElectricMode = 1;
//                inSpinMode = 1;
//                motor = 32;
//                shakeFrequency = 1;
//                shakeIntensity = 48;
//                spinDirection = 0;
//                spinIntensity = "(null)";
//                voltage = 48;
//            }安卓发iOS
            
            
            NSLog(@"---- %@", notiDic);
            
            if ([minStr(notiDic[@"inSpinMode"]) isEqualToString:@"1"]) {
                
                if ([minStr(notiDic[@"inElectricMode"]) isEqualToString:@"1"]) {
                    [self fouQiModelTypeOne:[minStr(notiDic[@"shakeIntensity"]) intValue] two:1 thr:[minStr(notiDic[@"voltage"]) intValue] fou:1];
                }else {
                    [self fouQiModelTypeOne:[minStr(notiDic[@"shakeIntensity"]) intValue] two:1 thr:0 fou:0];
                }
            }else {
                if ([minStr(notiDic[@"inElectricMode"]) isEqualToString:@"1"]) {
                    [self fouQiModelTypeOne:0 two:0 thr:[minStr(notiDic[@"voltage"]) intValue] fou:1];
                }else {
                    [self fouQiModelTypeOne:0 two:0 thr:0 fou:0];
                }
            }
        }
        
    }else if([minStr(notiDic[@"motor"]) isEqualToString:@"33"]) {
        
        NSLog(@"--手动数据---%@", notiDic);
        //  三期 马眼棒 手动
        
        [self fouQiModelTypeOne:[minStr(notiDic[@"shakeIntensity"]) intValue] two:[minStr(notiDic[@"frequency"]) intValue] thr:[minStr(notiDic[@"voltage"]) intValue] fou:[minStr(notiDic[@"frequency"]) intValue]];
        
    }else if([minStr(notiDic[@"motor"]) isEqualToString:@"34"]) {
                NSLog(@"--七彩灯---%@", notiDic);
        [self qiCaiDengModelKuangBaoTypeMEthod:[minStr(notiDic[@"inLantern"]) intValue]];
        
    }else if([minStr(notiDic[@"motor"]) isEqualToString:@"35"]) {
                
        //MARK: 电击 垫片 发送指令
        NSString *chann_str = minStr(notiDic[@"channel"]);
//        if ([minStr(notiDic[@"channel"]) intValue] < 10) {
//            chann_str = [NSString stringWithFormat:@"0%x", [minStr(notiDic[@"channel"]) intValue]];
//        }
        NSString *frequency_str = minStr(notiDic[@"frequency"]);
        if ([minStr(notiDic[@"frequency"]) intValue] < 10) {
            frequency_str = [NSString stringWithFormat:@"0%x", [minStr(notiDic[@"frequency"]) intValue]];
        }
        NSString *voltage_str = minStr(notiDic[@"voltage"]);
        if ([minStr(notiDic[@"voltage"]) intValue] < 10) {
            voltage_str = [NSString stringWithFormat:@"0%x", [minStr(notiDic[@"voltage"]) intValue]];
        }
        
        NSLog(@"-电击板指令send-- %@", notiDic);
        if ([voltage_str intValue] == 0) {
            
            NSString *blue_str = [NSString stringWithFormat:@"00E104%@%@%@%@000000000000", self.blue_tokenKey, @"01", @"00", voltage_str];
            if(self.peripheral && (self.peripheral != nil)) {
                if(self.characteristic && (self.characteristic != nil)) {
                    NSData *cipherData = [AESCipher aes128ECBEncrypt:blue_str keyHex:blue_EncryptionKey];
                    NSString *encryptedCommand = [AESCipher dataToHexString:cipherData];
                    
                    if (encryptedCommand) {
                        
                        NSData *commandData = [self functionUnsend:encryptedCommand];
                        [self.peripheral writeValue:commandData forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    } else {
                        NSLog(@"加密失败");
                    }
                }
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                NSString *blue_str2 = [NSString stringWithFormat:@"00E104%@%@%@%@000000000000", self.blue_tokenKey, @"02", @"00", voltage_str];
                if(self.peripheral && (self.peripheral != nil)) {
                    if(self.characteristic && (self.characteristic != nil)) {
                        NSData *cipherData2 = [AESCipher aes128ECBEncrypt:blue_str2 keyHex:blue_EncryptionKey];
                        NSString *encryptedCommand2 = [AESCipher dataToHexString:cipherData2];

                        if (encryptedCommand2) {

                            NSData *commandData2 = [self functionUnsend:encryptedCommand2];
                            [self.peripheral writeValue:commandData2 forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                        } else {
                            NSLog(@"加密失败");
                        }
                    }
                }
            });
            
        }else {
            
            switch ([chann_str intValue]) {
                case 1:
                {
                    NSString *blue_str = [NSString stringWithFormat:@"00E104%@%@%@%@000000000000", self.blue_tokenKey, @"01", frequency_str, voltage_str];
                    if(self.peripheral && (self.peripheral != nil)) {
                        if(self.characteristic && (self.characteristic != nil)) {
                            NSData *cipherData = [AESCipher aes128ECBEncrypt:blue_str keyHex:blue_EncryptionKey];
                            NSString *encryptedCommand = [AESCipher dataToHexString:cipherData];
                            
                            if (encryptedCommand) {
                                
                                NSData *commandData = [self functionUnsend:encryptedCommand];
                                [self.peripheral writeValue:commandData forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                            } else {
                                NSLog(@"加密失败");
                            }
                        }
                    }
                    
                }
                    break;
                case 2:
                {
                    NSString *blue_str = [NSString stringWithFormat:@"00E104%@%@%@%@000000000000", self.blue_tokenKey, @"02", frequency_str, voltage_str];
                    if(self.peripheral && (self.peripheral != nil)) {
                        if(self.characteristic && (self.characteristic != nil)) {
                            NSData *cipherData = [AESCipher aes128ECBEncrypt:blue_str keyHex:blue_EncryptionKey];
                            NSString *encryptedCommand = [AESCipher dataToHexString:cipherData];
                            
                            if (encryptedCommand) {
                                
                                NSData *commandData = [self functionUnsend:encryptedCommand];
                                [self.peripheral writeValue:commandData forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                            } else {
                                NSLog(@"加密失败");
                            }
                        }
                    }
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        NSString *blue_str2 = [NSString stringWithFormat:@"00E104%@%@%@%@000000000000", self.blue_tokenKey, @"01", @"00", @"00"];
                        if(self.peripheral && (self.peripheral != nil)) {
                            if(self.characteristic && (self.characteristic != nil)) {
                                NSData *cipherData2 = [AESCipher aes128ECBEncrypt:blue_str2 keyHex:blue_EncryptionKey];
                                NSString *encryptedCommand2 = [AESCipher dataToHexString:cipherData2];
                                
                                if (encryptedCommand2) {
                                    
                                    NSData *commandData2 = [self functionUnsend:encryptedCommand2];
                                    [self.peripheral writeValue:commandData2 forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                                } else {
                                    NSLog(@"加密失败");
                                }
                            }
                        }
                    });
                }
                    break;
                case 3:
                {
                    NSString *blue_str = [NSString stringWithFormat:@"00E104%@%@%@%@000000000000", self.blue_tokenKey, @"01", frequency_str, voltage_str];
                    if(self.peripheral && (self.peripheral != nil)) {
                        if(self.characteristic && (self.characteristic != nil)) {
                            NSData *cipherData = [AESCipher aes128ECBEncrypt:blue_str keyHex:blue_EncryptionKey];
                            NSString *encryptedCommand = [AESCipher dataToHexString:cipherData];
                            
                            if (encryptedCommand) {
                                
                                NSData *commandData = [self functionUnsend:encryptedCommand];
                                [self.peripheral writeValue:commandData forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                            } else {
                                NSLog(@"加密失败");
                            }
                        }
                    }
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        NSString *blue_str2 = [NSString stringWithFormat:@"00E104%@%@%@%@000000000000", self.blue_tokenKey, @"02", frequency_str, voltage_str];
                        if(self.peripheral && (self.peripheral != nil)) {
                            if(self.characteristic && (self.characteristic != nil)) {
                                NSData *cipherData2 = [AESCipher aes128ECBEncrypt:blue_str2 keyHex:blue_EncryptionKey];
                                NSString *encryptedCommand2 = [AESCipher dataToHexString:cipherData2];
                                
                                if (encryptedCommand2) {
                                    
                                    NSData *commandData2 = [self functionUnsend:encryptedCommand2];
                                    [self.peripheral writeValue:commandData2 forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                                } else {
                                    NSLog(@"加密失败");
                                }
                            }
                        }
                    });
                }
                    break;
                    
                default:
                {
                    NSString *blue_str = [NSString stringWithFormat:@"00E104%@%@%@%@000000000000", self.blue_tokenKey, @"01", @"00", @"00"];
                    if(self.peripheral && (self.peripheral != nil)) {
                        if(self.characteristic && (self.characteristic != nil)) {
                            NSData *cipherData = [AESCipher aes128ECBEncrypt:blue_str keyHex:blue_EncryptionKey];
                            NSString *encryptedCommand = [AESCipher dataToHexString:cipherData];
                            
                            if (encryptedCommand) {
                                
                                NSData *commandData = [self functionUnsend:encryptedCommand];
                                [self.peripheral writeValue:commandData forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                            } else {
                                NSLog(@"加密失败");
                            }
                        }
                    }
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        NSString *blue_str2 = [NSString stringWithFormat:@"00E104%@%@%@%@000000000000", self.blue_tokenKey, @"02", @"00", @"00"];
                        if(self.peripheral && (self.peripheral != nil)) {
                            if(self.characteristic && (self.characteristic != nil)) {
                                NSData *cipherData2 = [AESCipher aes128ECBEncrypt:blue_str2 keyHex:blue_EncryptionKey];
                                NSString *encryptedCommand2 = [AESCipher dataToHexString:cipherData2];
                                
                                if (encryptedCommand2) {
                                    
                                    NSData *commandData2 = [self functionUnsend:encryptedCommand2];
                                    [self.peripheral writeValue:commandData2 forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                                } else {
                                    NSLog(@"加密失败");
                                }
                            }
                        }
                    });
                }
                    break;
            }
            
        }
        
    }

}

- (void)qiCaiDengModelKuangBaoTypeMEthod:(int)isLantern
{
    if(self.isFirstMAC > 0) {

        if(self.peripheral && (self.peripheral != nil)) {
            if(self.characteristic && (self.characteristic != nil)) {
                
                Byte byteArray[] = {0xAA, 0x09, 0x0E, isLantern, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF};
                NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                }else {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                }
            }
        }
    }
}



- (void)YaoYiYaoModelTypeOne:(int)spinIntensity two:(int)fangxiang thr:(int)voltage
{
    
    if(self.isFirstMAC > 0) {
       
        NSLog(@"摇一摇ppt -- %d -- %d -- %d", spinIntensity, voltage, fangxiang);
        if(self.peripheral && (self.peripheral != nil)) {
            if(self.characteristic && (self.characteristic != nil)) {
                
                Byte byteArray[] = {0xAA, 0x04, spinIntensity, voltage, fangxiang};  //旋转强度、电击强度、旋转方向 1顺时针 2逆时针
                NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                }else {
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                }
            }
        }
    }
}

//MARK:  三期 马眼棒
- (void)fouQiModelTypeOne:(int)spinIntensity two:(int)spinFrequency thr:(int)voltage fou:(int)electricFrequency
{
//    1、振动强度spinIntensity  2、振动模式spinFrequency  3、电击强度voltage  4、电击模式electricFrequency
    
    if(self.isFirstMAC > 0) {

        if(self.peripheral && (self.peripheral != nil)) {
            if(self.characteristic && (self.characteristic != nil)) {
                
                NSLog(@"经典滑动ppt -- %d -- %d -- %d -- %d", spinFrequency, spinIntensity, electricFrequency, voltage);
                if ([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName5]) {
                    
                    Byte byteArray[] = {0xAA, 0x01, spinFrequency, spinIntensity, electricFrequency, voltage};
                    NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    }else {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    }
                    
                }else {
                    if (electricFrequency<=0 || voltage<=2) {
                        voltage = 0;
                    }
                    if (spinFrequency<=0 || spinIntensity<=2) {
                        spinIntensity = 0;
                    }
                    Byte byteArray[] = {0xAA, 0x09, 0x06, spinFrequency, spinIntensity, electricFrequency, voltage, 0x00, 0x00, 0xFF};
//                    Byte byteArray[] = {0xAA, 0x09, 0x07, spinFrequency, spinIntensity, electricFrequency, voltage, 0x00, 0x00, 0xFF};
                    NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                    if([self.namStMMM isEqualToString:kCharactName12] || [self.namStMMM isEqualToString:kCharactName6]) {
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                    }else {
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                    }
                    if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    }else {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    }
                    
                }
            }
        }
    }
}

- (void)fouQiModelKuangBaoTypeMEthod
{
    if(self.isFirstMAC > 0) {


        if(self.peripheral && (self.peripheral != nil)) {
            if(self.characteristic && (self.characteristic != nil)) {
                
                if ([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName5]) {
                    
                    Byte byteArray[] = {0xAA, 0x02, 0x01};
                    NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    }else {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    }
                }else {
                    
                    Byte byteArray[] = {0xAA, 0x09, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF};
                    NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                    if([self.namStMMM isEqualToString:kCharactName12] || [self.namStMMM isEqualToString:kCharactName6]) {
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                    }else {
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                    }
                    
                    if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    }else {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    }
                }
            }
        }
    }
}

- (void)fouQiModelSuiJiTypeOnethr:(int)voltage fou:(int)electricFrequency
{
    if(self.isFirstMAC > 0) {


        if(self.peripheral && (self.peripheral != nil)) {
            if(self.characteristic && (self.characteristic != nil)) {
                
                if ([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName5]) {
                    
                    Byte byteArray[] = {0xAA, 0x03, 0x01, voltage, electricFrequency};
                    NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    }else {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    }
                }else {
                    Byte byteArray[] = {0xAA, 0x09, 0x09, 0x01, voltage, electricFrequency, 0x00, 0x00, 0x00, 0xFF};
                    NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                    if([self.namStMMM isEqualToString:kCharactName12] || [self.namStMMM isEqualToString:kCharactName6]) {
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                    }else {
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                    }
                    
                    if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    }else {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    }
                    
                }
            }
        }
    }
}



//MARK:  定时 模式
- (void)dingShiFadaojishi:(int)time_Len zhendong:(int)time_Len2 changdianji:(int)time_Len3 qiangdu:(int)time_Len4  DJShichang:(int)time_Len5
{
    if(self.isFirstMAC > 0) {
    
        if(self.peripheral && (self.peripheral != nil)) {
            if(self.characteristic && (self.characteristic != nil)) {
                
                if (time_Len5 >= 0) {
                    //二期 定时电击
//                    NSLog(@"--二期定时值--%d--%d--%d--%d--%d", time_Len, time_Len2, time_Len3, time_Len4, time_Len5);
                    
                    NSString *m_time = [HistoryRecordModel DecTohex:time_Len];
                    if(m_time.length>2) {
                        
                        NSArray *ar_ar = [HistoryRecordModel separateString:m_time];
                        NSString *on_str = @"";
                        NSString *on_str2 = @"";
                        if(ar_ar.count==3) {
                            on_str = [NSString stringWithFormat:@"%@", ar_ar[0]];
                            on_str2 = [NSString stringWithFormat:@"%@%@", ar_ar[1], ar_ar[2]];
                        }else if (ar_ar.count >= 4) {
                            on_str = [NSString stringWithFormat:@"%@%@", ar_ar[0], ar_ar[1]];
                            on_str2 = [NSString stringWithFormat:@"%@%@", ar_ar[2], ar_ar[3]];
                        }
                        
                        int tim_ss = [HistoryRecordModel hexToDec:on_str];
                        int tim_ss2 = [HistoryRecordModel hexToDec:on_str2];
                        
                        
                        
                        NSString *m_time_two = [HistoryRecordModel DecTohex:time_Len5]; //电击时长
                        if(m_time_two.length>2) {
                            
                            NSArray *ar_ar_two = [HistoryRecordModel separateString:m_time_two];
                            NSString *on_str_two = @"";
                            NSString *on_str2_two = @"";
                            if(ar_ar_two.count==3) {
                                on_str_two = [NSString stringWithFormat:@"%@", ar_ar_two[0]];
                                on_str2_two = [NSString stringWithFormat:@"%@%@", ar_ar_two[1], ar_ar_two[2]];
                            }else if (ar_ar_two.count >= 4) {
                                on_str_two = [NSString stringWithFormat:@"%@%@", ar_ar_two[0], ar_ar_two[1]];
                                on_str2_two = [NSString stringWithFormat:@"%@%@", ar_ar_two[2], ar_ar_two[3]];
                            }
                            
                            int tim_ss_two = [HistoryRecordModel hexToDec:on_str_two];
                            int tim_ss2_two = [HistoryRecordModel hexToDec:on_str2_two];
                            
                            Byte byteArray[] = {0xAA, 0x09, 0x04, tim_ss, tim_ss2, time_Len2, time_Len4, tim_ss_two, tim_ss2_two, 0xFF};
                            NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                            if([self.namStMMM isEqualToString:kCharactName12]) {
//                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                            }else {
//                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                            }
                            
                            if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                            }else {
                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                            }
                            
                        }else {
                            
                            int tim_ss_two = [HistoryRecordModel hexToDec:m_time_two];
                            Byte byteArray[] = {0xAA, 0x09, 0x04, tim_ss, tim_ss2, time_Len2, time_Len4, 0x00, tim_ss_two, 0xFF};
                            NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                            if([self.namStMMM isEqualToString:kCharactName12]) {
//                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                            }else {
//                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                            }
                            
                            if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                            }else {
                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                            }
                            
                        }
                        
                    }else {
                        
                        int tim_ss = [HistoryRecordModel hexToDec:m_time];

                        NSString *m_time_two = [HistoryRecordModel DecTohex:time_Len5];
                        if(m_time_two.length>2) {
                            
                            NSArray *ar_ar = [HistoryRecordModel separateString:m_time_two];
                            NSString *on_str = @"";
                            NSString *on_str2 = @"";
                            if(ar_ar.count==3) {
                                on_str = [NSString stringWithFormat:@"%@", ar_ar[0]];
                                on_str2 = [NSString stringWithFormat:@"%@%@", ar_ar[1], ar_ar[2]];
                            }else if (ar_ar.count >= 4) {
                                on_str = [NSString stringWithFormat:@"%@%@", ar_ar[0], ar_ar[1]];
                                on_str2 = [NSString stringWithFormat:@"%@%@", ar_ar[2], ar_ar[3]];
                            }
                            
                            int tim_ss_two = [HistoryRecordModel hexToDec:on_str];
                            int tim_ss2_two = [HistoryRecordModel hexToDec:on_str2];
                            
                            Byte byteArray[] = {0xAA, 0x09, 0x04, 0x00, tim_ss, time_Len2, time_Len4, tim_ss_two, tim_ss2_two, 0xFF};
                            NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                            if([self.namStMMM isEqualToString:kCharactName12]) {
//                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                            }else {
//                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                            }
                            
                            if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                            }else {
                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                            }
                            
                        }else {
                            
                            int tim_ss_two = [HistoryRecordModel hexToDec:m_time_two];
                            Byte byteArray[] = {0xAA, 0x09, 0x04, 0x00, tim_ss, time_Len2, time_Len4, 0x00, tim_ss_two, 0xFF};
                            NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                            if([self.namStMMM isEqualToString:kCharactName12]) {
//                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                            }else {
//                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                            }
                            
                            if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                            }else {
                                [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                            }
                        }
                        
                    }
                }else {
                    
                    NSString *m_time = [HistoryRecordModel DecTohex:time_Len];
                    if(m_time.length>2) {
                        
                        NSArray *ar_ar = [HistoryRecordModel separateString:m_time];
                        NSString *on_str = @"";
                        NSString *on_str2 = @"";
                        if(ar_ar.count==3) {
                            on_str = [NSString stringWithFormat:@"%@", ar_ar[0]];
                            on_str2 = [NSString stringWithFormat:@"%@%@", ar_ar[1], ar_ar[2]];
                        }else if (ar_ar.count >= 4) {
                            on_str = [NSString stringWithFormat:@"%@%@", ar_ar[0], ar_ar[1]];
                            on_str2 = [NSString stringWithFormat:@"%@%@", ar_ar[2], ar_ar[3]];
                        }
                        
                        int tim_ss = [HistoryRecordModel hexToDec:on_str];
                        int tim_ss2 = [HistoryRecordModel hexToDec:on_str2];
                        NSLog(@"定时--%@---%d---%d", ar_ar, tim_ss, tim_ss2);
                        
                        Byte byteArray[] = {0xAA, 0x09, 0x04, tim_ss, tim_ss2, time_Len2, time_Len3, time_Len4, 0x02, 0xFF};
                        NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                        if([self.namStMMM isEqualToString:kCharactName12]) {
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                        }else {
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                        }
                        if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                        }else {
                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                        }
                        
                    }else {
                        
                        int tim_ss = [HistoryRecordModel hexToDec:m_time];
                        NSLog(@"定时2--%@--%d", m_time, tim_ss);
                        
                        Byte byteArray[] = {0xAA, 0x09, 0x04, 0x00, tim_ss, time_Len2, time_Len3, time_Len4, 0x02, 0xFF};
                        NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                        if([self.namStMMM isEqualToString:kCharactName12]) {
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                        }else {
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                        }
                        
                        if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                        }else {
                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                        }
                        
                    }
                    //                Byte byteArray[] = {0xAA, 0x09, 0x04, 0x00, 0x01, 0x03, 0x16, 0x02, 0x00, 0xFF}; //1、发送 2、字节长度 3、方法名 4、定时时间高位字节 5、定时时间低位字节 6、电击方式 7、电击强度  8、电击时长  9、开锁02 关锁03 10、结束
                }
            }
        }
    }
}

//MARK:  开锁模式
- (void)kaiSuoDianji:(int)isKaisuo dianji:(int)dianji
{
    NSLog(@"开锁--%d--%d", isKaisuo, dianji);
    if(self.isFirstMAC > 0) {
       
        
        if(self.peripheral && (self.peripheral != nil)) {
            if(self.characteristic && (self.characteristic != nil)) {
                if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName2]) {
                    
                    Byte byteArray[] = {0xAA, 0x01, isKaisuo, dianji};
                    NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                }else {
                    
                    if(isKaisuo==1) {
                        Byte byteArray[] = {0xAA, 0x09, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF};
                        NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                        if([self.namStMMM isEqualToString:kCharactName12]) {
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                        }else {
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                        }
                        
                        if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                        }else {
                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                        }
                        
                    }else {
                        Byte byteArray[] = {0xAA, 0x09, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF};
                        NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                        if([self.namStMMM isEqualToString:kCharactName12]) {
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                        }else {
//                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                        }
                        
                        if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                        }else {
                            [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                        }
                        
                    }
                }
            }
        }
    }
}

//MARK:  电击模式
- (void)ControlAutomaticTypeMethodMotor:(int)strongL strong:(int)strongL2 strong2:(int)strong3 strong3:(int)strong4
{
    NSLog(@"电击击模式--%d--%d--%d--%d", strongL, strongL2, strong3, strong4);
    if(self.isFirstMAC > 0) {

        // strong(1长电击、2短电击)、 strong2(1.震动 2.震颤 3.针刺)、 strong3(电压)、 strong4(时长)
        if(self.peripheral && (self.peripheral != nil)) {
            if(self.characteristic && (self.characteristic != nil)) {
                
                if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName2]) {
                    
                    Byte byteArray[] = {0xAA, 0x02, strongL, strongL2, strong3, strong4};
                    NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    }else {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    }
                }else {
                    
                    Byte byteArray[] = {0xAA, 0x09, 0x01, strongL2, strongL, strong3, strong4, 0x00, 0x00, 0xFF};
                    NSData *param = [NSData dataWithBytes:byteArray length:sizeof(byteArray)];
//                    [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                    if([self.namStMMM isEqualToString:kCharactName12]) {
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
//                    }else {
//                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
//                    }
                    
                    if (self.characteristicType == CBCharacteristicPropertyWriteWithoutResponse) {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
                    }else {
                        [self.peripheral writeValue:param forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
                    }
                }
            }
        }
    }
}

- (void)closePeripheralNameNotifNotif:(NSNotification *)notiff
{
    if ([minStr(notiff.object) intValue] == 2) {
        if (self.peripheral != nil) {
            self.isListBle = YES;
            [self.myCentralManager cancelPeripheralConnection:self.peripheral];
            self.peripheral = nil;
        }
        self.isFirstMAC = 0;
    }else {
        if (self.peripheral != nil) {
            self.isListBle = YES;
            [self.myCentralManager cancelPeripheralConnection:self.peripheral];
            self.peripheral = nil;
        }
    }
}


/***
 清空缓存设备值
 */
- (void)DeviceMethodUploadKZ
{
    [FloatingWindowModel shareInstance].choose_numW = 0;
    [FloatingWindowModel shareInstance].JingDian_one_strong = 0;
    [FloatingWindowModel shareInstance].JingDian_one_model = 0;
    [FloatingWindowModel shareInstance].JingDian_two_strong = 0;
    [FloatingWindowModel shareInstance].JingDian_two_model = 0;
    [FloatingWindowModel shareInstance].JingDian_thr = 0;
    [FloatingWindowModel shareInstance].JingDian_thr_strong = 0;
    [FloatingWindowModel shareInstance].JingDian_thr_strong2 = 0;
    
    [FloatingWindowModel shareInstance].yaoyiyao_one = 0;
    [FloatingWindowModel shareInstance].yaoyiyao_two = 0;
    [FloatingWindowModel shareInstance].yaoyiyao_thr = 0;
    
    [FloatingWindowModel shareInstance].yuyin_play = 0;
    [FloatingWindowModel shareInstance].yuyin_one = 0;
    [FloatingWindowModel shareInstance].yuyin_two = 0;
    [FloatingWindowModel shareInstance].yuyin_thr = 0;
    
    [FloatingWindowModel shareInstance].shoudong_one = 0;
    [FloatingWindowModel shareInstance].shoudong_two = 0;
    [FloatingWindowModel shareInstance].shoudong_oneStrong = 0;
    [FloatingWindowModel shareInstance].shoudong_twoStrong = 0;
    [FloatingWindowModel shareInstance].shoudong_model = 0;
    [FloatingWindowModel shareInstance].boxing_play = 0;
}

//- (void)request_saveAddEquipMethodTwo
//{
//    if(self.oneIn > 30) {
//        self.oneIn = 0;
//        if(self.macStMMM2.length > 0) {
//            [requestToolClass postNetworkWithUrl:request_device_saveOrUpdate andParameter:@{@"realName":self.namStMMM, @"mac":self.macStMMM2, @"model":@"", @"remainingCharge":self.ElecStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//                
//            } fail:^(NSString * _Nonnull msg) {
//                
//            }];
//        }
//    }else {
//        self.oneIn = self.oneIn + 1;
//    }
//}

//MARK: 发送数据结果回调
- (void)peripheral:(CBPeripheral*)peripheral didWriteValueForCharacteristic:(CBCharacteristic*)characteristic error:(nullable NSError*)error;
{
    if (error) {
        NSLog(@"11写入失败bb：%@",error.localizedDescription);
        return;
    }
    if(![[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName2] && ![[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName13]) {
        
        if (characteristic.value) {
            
            NSData *rech_data = characteristic.value;
            NSString *hexString = [self hexadecimalString:rech_data];
            if (hexString.length > 5) {
                
                if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName5]) {
                    
                    NSString *mm_one = [hexString substringWithRange:NSMakeRange(2, 2)];
                    if([mm_one isEqualToString:@"00"]) {
                        NSString *el_str = [hexString substringWithRange:NSMakeRange(4, 2)];
                        [LYUserDefault saveMacElec:[NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]];
                        NSLog(@"--电量--%@", [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]);
                        [FloatingWindowModel shareInstance].ElecStr = [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)];
                        if(!self.isAddEquip) {
                            NSInteger row_row = 0;
                            for (int i=0; i<[FloatingWindowModel shareInstance].datasMut.count; i++) {
                                MHEquipmentModel *model = [FloatingWindowModel shareInstance].datasMut[i];
                                if([FloatingWindowModel shareInstance].macStMMM2.length > 0) {
                                    BOOL isEEEqq = [model.mac compare:[FloatingWindowModel shareInstance].macStMMM2 options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                                    if(isEEEqq) {
                                        model.isShowLinks = YES;
                                        model.remainingCharge = [FloatingWindowModel shareInstance].ElecStr;
                                        row_row = i;
                                    }
                                }
                            }
//                            [self.appTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row_row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                            [self request_saveAddEquipMethodTwo];
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"2" userInfo:@{@"rowRow":[NSString stringWithFormat:@"%ld", row_row]}];
                            
                        }
                    }

                }else {
                    
                    NSString *mm_one = [hexString substringWithRange:NSMakeRange(4, 2)];
                    if([mm_one isEqualToString:@"05"]) {
                        if (hexString.length > 7) {
                            NSString *el_str = [hexString substringWithRange:NSMakeRange(6, 2)];
                            [LYUserDefault saveMacElec:[NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]];
                            NSLog(@"--电量--%@", [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]);
                            [FloatingWindowModel shareInstance].ElecStr = [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)];
                            if(!self.isAddEquip) {
                                NSInteger row_row = 0;
                                for (int i=0; i<[FloatingWindowModel shareInstance].datasMut.count; i++) {
                                    MHEquipmentModel *model = [FloatingWindowModel shareInstance].datasMut[i];
                                    if([FloatingWindowModel shareInstance].macStMMM2.length > 0) {
                                        BOOL isEEEqq = [model.mac compare:[FloatingWindowModel shareInstance].macStMMM2 options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                                        if(isEEEqq) {
                                            model.isShowLinks = YES;
                                            model.remainingCharge = [FloatingWindowModel shareInstance].ElecStr;
                                            row_row = i;
                                        }
                                    }
                                }
//                                [self.appTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row_row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                                [self request_saveAddEquipMethodTwo];
                                
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"2" userInfo:@{@"rowRow":[NSString stringWithFormat:@"%ld", row_row]}];
                            }
                        }
                        
                    }
                }
                
            }
            
            self.isFirstMAC = 1;
            if(self.isAddEquip) {
//                [self request_saveAddEquipMethod];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"3" userInfo:@{}];
            }
            [LYUserDefault saveMacName:[FloatingWindowModel shareInstance].macStMMM2];
            if([FloatingWindowModel shareInstance].bleLBooThr) {

//                [self RequestListData];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffNameUploadData" object:nil]; //更新数据列表
            }
            self.isAddEquip = NO;
            
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bluuConnectedNotif5" object:@{@"status":@"2", @"mac":[FloatingWindowModel shareInstance].macStMMM2}];
            NSLog(@"未发现特征值.aa");
        }
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bluuConnectedNotif5" object:@{@"status":@"2", @"mac":[FloatingWindowModel shareInstance].macStMMM2}];
        return;
    }
    
    if (characteristic.value) {
        
        if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName13]) {
            
            BOOL boo_boo = NO;
            NSData *rech_data = characteristic.value;
            
            // 转换为十六进制字符串便于查看
            NSString *hexString = [self hexadecimalString:rech_data];
            
            NSData *cipherData = [AESCipher aes128ECBDecrypt:hexString keyHex:blue_EncryptionKey];
            NSString *encryptedCommand = [AESCipher dataToHexString:cipherData];
            
            if (encryptedCommand.length > 30) {
                
                NSString *one_sub1 = [encryptedCommand substringWithRange:NSMakeRange(4, 2)];
                NSString *one_sub2 = [encryptedCommand substringFromIndex:30];
                
//                接收值-- {length = 16, bytes = 0x75264aaf5e384bf41561ca5ecd1361bf} ---解密  00 E1 01 00 0534EB8D 01002107000000 64
                if([one_sub1 isEqualToString:@"01"]) {
                    self.blue_tokenKey = [encryptedCommand substringWithRange:NSMakeRange(8, 8)];
                    NSLog(@"指令接收值-- %@ --- %@ -- %@ -- %@  -- %@", hexString, encryptedCommand, one_sub1, one_sub2, self.blue_tokenKey);
                    boo_boo = YES;
                    
                    NSString *elec_str = [NSString stringWithFormat:@"%lu", strtoul(one_sub2.UTF8String, 0, 16)];
                    NSLog(@"--电量--%@", elec_str);
                    
                    [LYUserDefault saveMacElec:elec_str];
                    [FloatingWindowModel shareInstance].ElecStr = elec_str;
                    if(!self.isAddEquip) {
                        NSInteger row_row = 0;
                        for (int i=0; i<[FloatingWindowModel shareInstance].datasMut.count; i++) {
                            MHEquipmentModel *model = [FloatingWindowModel shareInstance].datasMut[i];
                            if([FloatingWindowModel shareInstance].macStMMM2.length > 0) {
                                BOOL isEEEqq = [model.mac compare:[FloatingWindowModel shareInstance].macStMMM2 options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                                if(isEEEqq) {
                                    model.isShowLinks = YES;
                                    model.remainingCharge = [FloatingWindowModel shareInstance].ElecStr;
                                    row_row = i;
                                }
                            }
                        }
//                        [self.appTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row_row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                        [self request_saveAddEquipMethodTwo];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"2" userInfo:@{@"rowRow":[NSString stringWithFormat:@"%ld", row_row]}];
                    }
                }
                if([one_sub1 isEqualToString:@"04"]) {
                    
                    NSLog(@"接收QiuI 指令返回值-- %@ --- %@ -- %@ -- 电量值:%@  -- %@", hexString, encryptedCommand, one_sub1, one_sub2, self.blue_tokenKey);
                    NSLog(@"发送电压等级 成功");
                    NSString *elec_str = [NSString stringWithFormat:@"%lu", strtoul(one_sub2.UTF8String, 0, 16)];
                    NSLog(@"--电量--%@", elec_str);
                    
                    [FloatingWindowModel shareInstance].ElecStr = elec_str;
                }
                
                if (boo_boo) {
                    self.isFirstMAC = 1;
                    if(self.isAddEquip) {
//                        [self request_saveAddEquipMethod];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"3" userInfo:@{}];
                    }
                    [LYUserDefault saveMacName:[FloatingWindowModel shareInstance].macStMMM2];
                    if([FloatingWindowModel shareInstance].bleLBooThr) {
    
//                        [self RequestListData];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffNameUploadData" object:nil]; //更新数据列表
                    }
                    
                    self.isAddEquip = NO;
                }
            }
        }else if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName2]) {
            
            NSData *rech_data = characteristic.value;
            NSString *rech_st =  [self hexadecimalString:rech_data];
            
            if(rech_st.length > 5) {
                NSString *mm_one = [rech_st substringWithRange:NSMakeRange(2, 2)];
                if([mm_one isEqualToString:@"03"]) {
                    NSString *el_str = [rech_st substringWithRange:NSMakeRange(4, 2)];
                    [LYUserDefault saveMacElec:[NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]];
                    NSLog(@"--电量--%@", [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]);
                    [FloatingWindowModel shareInstance].ElecStr = [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)];
                    if(!self.isAddEquip) {
                        NSInteger row_row = 0;
                        for (int i=0; i<[FloatingWindowModel shareInstance].datasMut.count; i++) {
                            MHEquipmentModel *model = [FloatingWindowModel shareInstance].datasMut[i];
                            if([FloatingWindowModel shareInstance].macStMMM2.length > 0) {
                                BOOL isEEEqq = [model.mac compare:[FloatingWindowModel shareInstance].macStMMM2 options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                                if(isEEEqq) {
                                    model.isShowLinks = YES;
                                    model.remainingCharge = [FloatingWindowModel shareInstance].ElecStr;
                                    row_row = i;
                                }
                            }
                        }
//                        [self.appTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row_row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                        [self request_saveAddEquipMethodTwo];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"2" userInfo:@{@"rowRow":[NSString stringWithFormat:@"%ld", row_row]}];
                    }
                }
            }
            
            self.isFirstMAC = 1;
            if(self.isAddEquip) {
//                [self request_saveAddEquipMethod];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"3" userInfo:@{}];
            }
            [LYUserDefault saveMacName:[FloatingWindowModel shareInstance].macStMMM2];
            if([FloatingWindowModel shareInstance].bleLBooThr) {

//                [self RequestListData];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffNameUploadData" object:nil]; //更新数据列表
            }
            self.isAddEquip = NO;
        }else {
            
            BOOL boo_boo = YES;
            
            NSData *rech_data = characteristic.value;
            NSString *rech_st =  [self hexadecimalString:rech_data];
            if(rech_st.length > 5) {
                
                /*
                 --蓝牙反馈--{length = 20, bytes = 0x0101000500011132000211000003113200041100}
                 --蓝牙反馈--{length = 6, bytes = 0x010200051153}
                 
                 --蓝牙反馈--{length = 20, bytes = 0x0101000500011132000211000003113200041100}
                 --蓝牙反馈--{length = 6, bytes = 0x010200051151}
                 
                 {length = 10, bytes = 0xbb0905620000000000ff}
                 */
                
                if([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName5]) {
                    
                    // aa 00 32
                    NSString *mm_one = [rech_st substringWithRange:NSMakeRange(2, 2)];
                    if([mm_one isEqualToString:@"00"]) {
                        NSString *el_str = [rech_st substringWithRange:NSMakeRange(4, 2)];
                        [LYUserDefault saveMacElec:[NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]];
                        NSLog(@"--电量--%@", [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]);
                        [FloatingWindowModel shareInstance].ElecStr = [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)];
                        if(!self.isAddEquip) {
                            NSInteger row_row = 0;
                            for (int i=0; i<[FloatingWindowModel shareInstance].datasMut.count; i++) {
                                MHEquipmentModel *model = [FloatingWindowModel shareInstance].datasMut[i];
                                if([FloatingWindowModel shareInstance].macStMMM2.length > 0) {
                                    BOOL isEEEqq = [model.mac compare:[FloatingWindowModel shareInstance].macStMMM2 options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                                    if(isEEEqq) {
                                        model.isShowLinks = YES;
                                        model.remainingCharge = [FloatingWindowModel shareInstance].ElecStr;
                                        row_row = i;
                                    }
                                }
                            }
//                            [self.appTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row_row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                            [self request_saveAddEquipMethodTwo];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"2" userInfo:@{@"rowRow":[NSString stringWithFormat:@"%ld", row_row]}];
                        }
                    }
                    
                }else {
                    NSString *mm_one = [rech_st substringWithRange:NSMakeRange(4, 2)];
                    if([mm_one isEqualToString:@"05"]) {
                        
                        boo_boo = YES;
                        if (rech_st.length > 7) {
                            NSString *el_str = [rech_st substringWithRange:NSMakeRange(6, 2)];
                            [LYUserDefault saveMacElec:[NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]];
                            NSLog(@"--电量--%@", [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)]);
                            [FloatingWindowModel shareInstance].ElecStr = [NSString stringWithFormat:@"%lu", strtoul(el_str.UTF8String, 0, 16)];
                            if(!self.isAddEquip) {
                                NSInteger row_row = 0;
                                for (int i=0; i<[FloatingWindowModel shareInstance].datasMut.count; i++) {
                                    MHEquipmentModel *model = [FloatingWindowModel shareInstance].datasMut[i];
                                    if([FloatingWindowModel shareInstance].macStMMM2.length > 0) {
                                        BOOL isEEEqq = [model.mac compare:[FloatingWindowModel shareInstance].macStMMM2 options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
                                        if(isEEEqq) {
                                            model.isShowLinks = YES;
                                            model.remainingCharge = [FloatingWindowModel shareInstance].ElecStr;
                                            row_row = i;
                                        }
                                    }
                                }
//                                [self.appTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row_row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//                                [self request_saveAddEquipMethodTwo];
                                [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"2" userInfo:@{@"rowRow":[NSString stringWithFormat:@"%ld", row_row]}];
                            }
                        }
                        
                    }
                }
            }

            if (boo_boo) {
                self.isFirstMAC = 1;
                if(self.isAddEquip) {
//                    [self request_saveAddEquipMethod];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadTableViewNameNotif" object:@"3" userInfo:@{}];
                }
                [LYUserDefault saveMacName:[FloatingWindowModel shareInstance].macStMMM2];
                if([FloatingWindowModel shareInstance].bleLBooThr) {
           
//                    [self RequestListData];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"blueNameStatusNotiffNameUploadData" object:nil]; //更新数据列表
                }
                
                self.isAddEquip = NO;
            }
        }
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"bluuConnectedNotif5" object:@{@"status":@"2", @"mac":[FloatingWindowModel shareInstance].macStMMM2}];
        NSLog(@"未发现特征值.aa");
    }
}

- (NSString *)getMacMethodUI:(NSData *)macStr
{
    NSLog(@"--mac值--- %@", macStr);
    NSString *hexString = [self hexadecimalString:macStr];
    if (hexString.length>25) {
        NSString *mac_str = [hexString substringWithRange:NSMakeRange(14, 12)];
        
        NSMutableString *mutableString = [NSMutableString stringWithString:mac_str];
        [mutableString insertString:@":" atIndex:2];
        [mutableString insertString:@":" atIndex:5];
        [mutableString insertString:@":" atIndex:8];
        [mutableString insertString:@":" atIndex:11];
        [mutableString insertString:@":" atIndex:14];
        return [mutableString uppercaseString];
    }else {
        return @"";
    }
}

- (NSString *)getMacMethodUIModel4:(NSData *)macStr
{
    NSLog(@"--mac值--- %@", macStr);
    NSString *hexString = [self hexadecimalString:macStr];
    if (hexString.length>37) {
        NSString *mac_str = [hexString substringWithRange:NSMakeRange(26, 12)];
        
        NSMutableString *mutableString = [NSMutableString stringWithString:mac_str];
        [mutableString insertString:@":" atIndex:2];
        [mutableString insertString:@":" atIndex:5];
        [mutableString insertString:@":" atIndex:8];
        [mutableString insertString:@":" atIndex:11];
        [mutableString insertString:@":" atIndex:14];
        return [mutableString uppercaseString];
    }else {
        return @"";
    }
}

- (NSString *)getThreethMacMethodUI:(NSData *)macData
{
    
    NSString *hexString = [self hexadecimalString:macData];
    NSLog(@"接收值mac-- %@ --- %@", macData, hexString);
//    {length = 8, bytes = 0x35bf e5c5a1700011}
    if (hexString.length>=16) {
        NSString *mac_str = [hexString substringWithRange:NSMakeRange(4, 12)];
        
        NSMutableString *mutableString = [NSMutableString stringWithString:mac_str];
        [mutableString insertString:@":" atIndex:2];
        [mutableString insertString:@":" atIndex:5];
        [mutableString insertString:@":" atIndex:8];
        [mutableString insertString:@":" atIndex:11];
        [mutableString insertString:@":" atIndex:14];
        
        return [mutableString uppercaseString];
    }else {
        return @"";
    }
    
}

- (NSString *)hexadecimalString:(NSData *)data {
    const unsigned char *dataBuffer = (const unsigned char *)[data bytes];
    NSMutableString *hexString = [NSMutableString string];
    
    for (NSUInteger i = 0; i < data.length; i++) {
        [hexString appendFormat:@"%02lx", (unsigned long)dataBuffer[i]];
    }
    return [hexString copy];
}

-(NSData *)functionUnsend:(NSString *)message
{
    NSData *data = [self hexToBytes:message];
    return data;
}
-(NSData*)hexToBytes:(NSString*)str {
    
    NSString *string = str;
    const char *buf = [string UTF8String];
    NSMutableData *data = [NSMutableData data];
    if (buf){
        long len = strlen(buf);
        
        char singleNumberString[3] = {'\0', '\0', '\0'};
        uint32_t singleNumber = 0;
        for(uint32_t i = 0 ; i < len; i+=2) {
            if ( ((i+1) < len) && isxdigit(buf[i]) && (isxdigit(buf[i+1]))) {
                singleNumberString[0] = buf[i];
                singleNumberString[1] = buf[i + 1];
                sscanf(singleNumberString, "%x", &singleNumber);
                uint8_t tmp = (uint8_t)(singleNumber & 0x000000FF);
                [data appendBytes:(void *)(&tmp)length:1];
            } else {
                break;
            }
        }
    }
    
    return data;
}

@end
