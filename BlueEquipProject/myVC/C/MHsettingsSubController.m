//
//  MHsettingsSubController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import "MHsettingsSubController.h"
#import "MHRedoPasswordController.h"
#import "LYUserDefault.h"
#import "requestUrlRFile.h"
#import "MHWeChatHandler.h"
#import <AuthenticationServices/AuthenticationServices.h>

@interface MHsettingsSubController () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>
@end

@interface MHsettingsSubController ()

@end

@implementation MHsettingsSubController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    
    [self setupSocialBindingsRows];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleName.text = eLocalizedString(@"my_settings1");
    self.navView.backgroundColor = RGB(247, 247, 247);

    // 注册微信授权结果通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_onWechatAuthReceived:) name:@"MHWeChatDidReceiveCodeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_onWechatAuthFailed) name:@"MHWeChatDidFailNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_onWechatAuthCanceled) name:@"MHWeChatDidCancelNotification" object:nil];

    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
     
    NSArray *namsAr = @[@"my_settings11", @"my_settings12"];
    
    for (int i=0; i<namsAr.count; i++) {
        UIView *subVVV = [[UIView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+i*54, _window_width, 54)];
        subVVV.backgroundColor = UIColor.whiteColor;
        [self.view addSubview:subVVV];
        
        UILabel *labLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        labLab.frame = CGRectMake(12, 0, subVVV.width-100, subVVV.height);
        labLab.text = eLocalizedString(namsAr[i]);
        [subVVV addSubview:labLab];
        
        UIImageView *nexIV = [HistoryRecordModel createImgImgView];
        nexIV.image = [UIImage imageNamed:@"next_Img2"];
        [subVVV addSubview:nexIV];
        [nexIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(subVVV.mas_right).offset(-12);
            make.centerY.equalTo(subVVV.mas_centerY);
            make.width.height.offset(16);
        }];
        
        UIButton *cliBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, subVVV.width, subVVV.height-10)];
        cliBBtn.tag = 500+i;
        [cliBBtn addTarget:self action:@selector(clicListTagsMethod:) forControlEvents:UIControlEventTouchUpInside];
        [subVVV addSubview:cliBBtn];
        
        if(i == 0) {
            UIView *linV = [HistoryRecordModel createLineViewUIUI];
            linV.frame = CGRectMake(0, subVVV.height-1, _window_width, 1);
            [subVVV addSubview:linV];
        }
    }
    
    [self setupSocialBindingsRows];
}

- (void)setupSocialBindingsRows {
    for (UIView *v in self.view.subviews) {
        if (v.tag >= 9001 && v.tag < 9100) {
            [v removeFromSuperview];
        }
    }
    
    // section header 标签（tag=9000，每次刷新不删，只更新文案）
    // 字体 14pt，与上方基础设置区间距 32pt（原 22 +10）
    CGFloat startY = NAVHEIGHT + 2 * 54 + 32;
    UIView *oldHeader = [self.view viewWithTag:9000];
    if (!oldHeader) {
        UILabel *sectionLab = [HistoryRecordModel createLabLabTextColor:RGB(153, 153, 153) fontFloat:14 textAlignment:NSTextAlignmentLeft];
        sectionLab.text = @"第三方登录方式";
        sectionLab.frame = CGRectMake(12, startY - 18, _window_width - 24, 18);
        sectionLab.tag = 9000;
        [self.view addSubview:sectionLab];
    }
    
    NSDictionary *bindings = [LYUserDefault userDefault].socialBindings;
    if (![bindings isKindOfClass:[NSDictionary class]]) {
        bindings = @{};
    }
    
    NSArray *platforms = @[
        @{@"key": @"wechat", @"name": @"微信", @"icon": @"wechat_bound"},
        @{@"key": @"apple",  @"name": @"Apple", @"icon": @"apple_bound"}
    ];
    
    // row 起始 y = header.bottom(=NAVHEIGHT+2*54+32) + 4pt gap
    startY = NAVHEIGHT + 2 * 54 + 36;
    
    for (int i = 0; i < platforms.count; i++) {
        NSDictionary *plat = platforms[i];
        NSString *key = plat[@"key"];
        NSDictionary *info = bindings[key];
        BOOL bound = NO;
        if ([info isKindOfClass:[NSDictionary class]]) {
            id boundObj = info[@"bound"];
            if (boundObj && ![boundObj isKindOfClass:[NSNull class]]) {
                bound = [boundObj boolValue];
            }
        }
        
        UIView *row = [[UIView alloc] initWithFrame:CGRectMake(0, startY + i * 54, _window_width, 54)];
        row.backgroundColor = UIColor.whiteColor;
        row.tag = 9000 + i;
        [self.view addSubview:row];
        
        // 平台图标
        UIImageView *iconIV = [UIImageView new];
        iconIV.contentMode = UIViewContentModeScaleAspectFit;
        iconIV.image = [UIImage imageNamed:plat[@"icon"]];
        [row addSubview:iconIV];
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(row.mas_left).offset(12);
            make.centerY.equalTo(row.mas_centerY);
            make.width.height.offset(24);
        }];
        
        // 标签
        UILabel *nameLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        nameLab.frame = CGRectMake(44, 0, 120, row.height);
        nameLab.text = plat[@"name"];
        [row addSubview:nameLab];
        
        // 绑定状态（已绑定显示 nickName，未绑定显示"未绑定"）
        NSString *statusText;
        if (bound) {
            // 兼容多种 key：nickName / nickname / nick_name
            NSString *nick = nil;
            if ([info isKindOfClass:[NSDictionary class]]) {
                nick = info[@"nickName"];
                if (!nick) nick = info[@"nickname"];
                if (!nick) nick = info[@"nick_name"];
            }
            if ([nick isKindOfClass:[NSString class]] && nick.length > 0) {
                statusText = nick;
            } else {
                NSLog(@"[Bindings] ⚠️ %@ bound=1 但 nickName 为空，info=%@", key, info);
                statusText = @"已绑定";
            }
        } else {
            statusText = @"未绑定";
        }
        UIColor *statusColor = bound ? RGB(7, 193, 96) : RGB(153, 153, 153);
        UILabel *statusLab = [HistoryRecordModel createLabLabTextColor:statusColor fontFloat:13 textAlignment:NSTextAlignmentRight];
        statusLab.frame = CGRectMake(_window_width - 36 - 120, 0, 120, row.height);
        statusLab.text = statusText;
        [row addSubview:statusLab];
        
        // 右箭头
        UIImageView *nexIV = [HistoryRecordModel createImgImgView];
        nexIV.image = [UIImage imageNamed:@"next_Img2"];
        [row addSubview:nexIV];
        [nexIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(row.mas_right).offset(-12);
            make.centerY.equalTo(row.mas_centerY);
            make.width.height.offset(16);
        }];
        
        // 点击按钮（tag = 9200 + i，与 row 关联）
        UIButton *cliBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, row.width, row.height - 10)];
        cliBBtn.tag = 9200 + i;
        [cliBBtn addTarget:self action:@selector(_onPlatformRowTapped:) forControlEvents:UIControlEventTouchUpInside];
        [row addSubview:cliBBtn];
        
        // 分割线
        if (i < platforms.count - 1) {
            UIView *linV = [HistoryRecordModel createLineViewUIUI];
            linV.frame = CGRectMake(0, row.height - 1, _window_width, 1);
            [row addSubview:linV];
        }
    }
}

- (void)_onPlatformRowTapped:(UIButton *)sender {
    NSArray *platformKeys = @[@"wechat", @"apple"];
    if (sender.tag - 9200 < 0 || sender.tag - 9200 >= platformKeys.count) return;
    
    NSString *key = platformKeys[sender.tag - 9200];
    NSDictionary *bindings = [LYUserDefault userDefault].socialBindings;
    NSDictionary *info = bindings[key];
    BOOL bound = NO;
    if ([info isKindOfClass:[NSDictionary class]]) {
        id boundObj = info[@"bound"];
        if (boundObj && ![boundObj isKindOfClass:[NSNull class]]) {
            bound = [boundObj boolValue];
        }
    }
    
    if (bound) {
        NSString *platformName = [key isEqualToString:@"wechat"] ? @"微信" : @"Apple";
        [SGActionView showAlertWithTitle:[NSString stringWithFormat:@"是否解绑%@？", platformName]
                                message:[NSString stringWithFormat:@"解绑后将无法使用%@登录", platformName]
                     leftButtonTitle:@"取消"
                    rightButtonTitle:@"解绑"
                       selectedHandle:^(NSInteger index) {
            if (index == 1) {
                [self _callUnbindAccountAPI:key platformName:platformName];
            }
        }];
    } else {
        if ([key isEqualToString:@"wechat"]) {
            [self _startWechatBindFlow];
        } else if ([key isEqualToString:@"apple"]) {
            [self _startAppleBindFlow];
        }
    }
}

#pragma mark - 统一绑定/解绑接口

/// 绑定：POST /oauth/bindAccount {type, ...凭证}
- (void)_callBindAccountAPI:(NSString *)type params:(NSDictionary *)params {
    [SVProgressHUD showWithStatus:@"绑定中..."];
    [requestToolClass postNetworkWithUrl:request_oauth_bindAccount andParameter:params success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        [SVProgressHUD dismiss];
        if (code == 200) {
            [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
            [self _refreshBindingsFromServer];
        } else {
            [SVProgressHUD showErrorWithStatus:msg.length > 0 ? msg : @"绑定失败"];
        }
    } fail:^(NSString * _Nonnull msg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:msg.length > 0 ? msg : @"绑定失败"];
    }];
}

/// 解绑：POST /oauth/unbindAccount {type}
- (void)_callUnbindAccountAPI:(NSString *)type platformName:(NSString *)platformName {
    [SVProgressHUD showWithStatus:@"解绑中..."];
    NSDictionary *params = @{@"type": type};
    [requestToolClass postNetworkWithUrl:request_oauth_unbindAccount andParameter:params success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        [SVProgressHUD dismiss];
        if (code == 200) {
            [SVProgressHUD showSuccessWithStatus:@"解绑成功"];
            [self _markPlatformUnbound:type];
        } else {
            [SVProgressHUD showErrorWithStatus:msg.length > 0 ? msg : @"解绑失败"];
        }
    } fail:^(NSString * _Nonnull msg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:msg.length > 0 ? msg : @"解绑失败"];
    }];
}

/// 微信绑定：授权 → loginWechat 拿 ticket → bindAccount
- (void)_startWechatBindFlow {
    [[MHWeChatHandler shared] sendAuthReqFromVC:self];
}

- (void)_onWechatAuthReceived:(NSNotification *)note {
    NSString *code = note.userInfo[@"code"];
    if (code.length == 0) return;
    
    [SVProgressHUD showWithStatus:@"绑定中..."];
    [requestToolClass postNetworkWithUrl:request_login_wechat andParameter:@{@"code": code} success:^(int code2, id  _Nonnull info, NSString * _Nonnull msg) {
        [SVProgressHUD dismiss];
        if (code2 != 200 || ![info isKindOfClass:[NSDictionary class]]) {
            [SVProgressHUD showErrorWithStatus:msg ?: @"授权失败"];
            return;
        }
        
        BOOL bound = NO;
        id boundObj = info[@"bound"];
        if (boundObj && ![boundObj isKindOfClass:[NSNull class]]) bound = [boundObj boolValue];
        NSString *ticket = [info[@"wechatTicket"] copy];
        
        if (bound && ticket.length == 0) {
            [SVProgressHUD showSuccessWithStatus:@"已绑定"];
            [self _refreshBindingsFromServer];
        } else if (ticket.length > 0) {
            [self _callBindAccountAPI:@"wechat" params:@{@"type": @"wechat", @"wechatTicket": ticket}];
        } else {
            [SVProgressHUD showErrorWithStatus:@"未返回票据"];
        }
    } fail:^(NSString * _Nonnull msg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:msg ?: @"网络异常"];
    }];
}

- (void)_onWechatAuthFailed {
    [SVProgressHUD showErrorWithStatus:@"微信授权失败"];
}
- (void)_onWechatAuthCanceled {
    [SVProgressHUD showInfoWithStatus:@"已取消"];
}

/// 苹果绑定：ASAuthorizationController → bindAccount
- (void)_startAppleBindFlow API_AVAILABLE(ios(13.0)) {
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest *request = [provider createRequest];
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        controller.delegate = self;
        controller.presentationContextProvider = self;
        [controller performRequests];
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    if (![authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) return;
    
    ASAuthorizationAppleIDCredential *credential = (ASAuthorizationAppleIDCredential *)authorization.credential;
    NSString *user = credential.user;
    NSString *email = credential.email ?: @"";
    NSString *fullName = credential.fullName ? [NSString stringWithFormat:@"%@%@",
        credential.fullName.familyName ?: @"", credential.fullName.givenName ?: @""] : @"";
    
    NSData *identityToken = credential.identityToken;
    if (!identityToken) {
        [SVProgressHUD showErrorWithStatus:@"Apple 授权失败"];
        return;
    }
    NSString *tokenStr = [[NSString alloc] initWithData:identityToken encoding:NSUTF8StringEncoding];
    
    [SVProgressHUD showWithStatus:@"绑定中..."];
    // Apple 只在第一次授权返回 fullName → 必须带上
    NSMutableDictionary *params = [@{
        @"type": @"apple",
        @"identityToken": tokenStr ?: @"",
        @"email": email,
        @"fullName": fullName
    } mutableCopy];
    if (user.length > 0) params[@"appleUserId"] = user;
    
    [requestToolClass postNetworkWithUrl:request_oauth_bindAccount andParameter:[params copy] success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        [SVProgressHUD dismiss];
        if (code == 200) {
            [SVProgressHUD showSuccessWithStatus:@"绑定成功"];
            [self _refreshBindingsFromServer];
        } else {
            [SVProgressHUD showErrorWithStatus:msg.length > 0 ? msg : @"绑定失败"];
        }
    } fail:^(NSString * _Nonnull msg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:msg.length > 0 ? msg : @"绑定失败"];
    }];
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    if (error.code != ASAuthorizationErrorCanceled) {
        [SVProgressHUD showErrorWithStatus:@"Apple 授权失败"];
    }
}

/// 刷新绑定状态（GET /oauth/bindings 或 /user/me）
- (void)_refreshBindingsFromServer {
    [requestToolClass getNetworkWithUrl:request_user_me andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        if ([info isKindOfClass:[NSDictionary class]]) {
            [LYUserDefault saveUserDefault:info];
            [self setupSocialBindingsRows];
        }
    } fail:^(NSString * _Nonnull msg) {
        [self setupSocialBindingsRows];
    }];
}

- (void)_markPlatformUnbound:(NSString *)key {
    NSDictionary *bindings = [LYUserDefault userDefault].socialBindings;
    if (![bindings isKindOfClass:[NSDictionary class]]) return;
    
    NSMutableDictionary *mutable = [bindings mutableCopy];
    NSMutableDictionary *platInfo = [mutable[key] mutableCopy];
    if (!platInfo) platInfo = [NSMutableDictionary dictionary];
    platInfo[@"bound"] = @(0);
    mutable[key] = [platInfo copy];
    
    [[LYUserDefault userDefault] setSocialBindings:[mutable copy]];
    [self setupSocialBindingsRows];
}

- (void)clicListTagsMethod:(UIButton *)btn
{
    if(btn.tag == 500) {
        MHRedoPasswordController *vc = [[MHRedoPasswordController alloc] init];
        vc.isChageAccount = 1;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        MHRedoPasswordController *vc = [[MHRedoPasswordController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
