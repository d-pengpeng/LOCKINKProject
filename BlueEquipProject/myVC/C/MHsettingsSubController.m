//
//  MHsettingsSubController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import "MHsettingsSubController.h"
#import "MHRedoPasswordController.h"
#import "LYUserDefault.h"

@interface MHsettingsSubController ()

@end

@implementation MHsettingsSubController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
    
    // 刷新绑定状态显示
    [self setupSocialBindingsRows];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleName.text = eLocalizedString(@"my_settings1");
    self.navView.backgroundColor = RGB(247, 247, 247);

    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
     
    // 顶部两行（修改密码 + 绑定手机号）
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
    
    // 第三方账号绑定区域容器（放在 2 行基础设置下面，起始 y = NAVHEIGHT + 2*54）
    [self setupSocialBindingsRows];
}

- (void)setupSocialBindingsRows {
    // 先移除旧的（如果有）
    for (UIView *v in self.view.subviews) {
        if (v.tag >= 9000 && v.tag < 9100) {
            [v removeFromSuperview];
        }
    }
    
    NSDictionary *bindings = [LYUserDefault userDefault].socialBindings;
    if (![bindings isKindOfClass:[NSDictionary class]]) {
        bindings = @{};
    }
    
    NSArray *platforms = @[
        @{@"key": @"wechat", @"name": @"微信", @"iconBound": @"wechat_bound", @"iconUnbound": @"wechat_login"},
        @{@"key": @"apple",  @"name": @"Apple", @"iconBound": @"apple_bound",  @"iconUnbound": @"apple_login"}
    ];
    
    CGFloat startY = NAVHEIGHT + 2 * 54 + 12;  // 基础设置 2 行 + 12pt 间距
    NSArray *subviews = self.view.subviews;
    
    for (int i = 0; i < platforms.count; i++) {
        NSDictionary *plat = platforms[i];
        NSString *key = plat[@"key"];
        NSDictionary *info = bindings[key];
        BOOL bound = [info[@"bound"] boolValue];
        
        UIView *row = [[UIView alloc] initWithFrame:CGRectMake(0, startY + i * 54, _window_width, 54)];
        row.backgroundColor = UIColor.whiteColor;
        row.tag = 9000 + i;
        [self.view addSubview:row];
        
        // 平台图标
        UIImageView *iconIV = [UIImageView new];
        iconIV.contentMode = UIViewContentModeScaleAspectFit;
        NSString *iconName = bound ? plat[@"iconBound"] : plat[@"iconUnbound"];
        if (iconName.length > 0) {
            iconIV.image = [UIImage imageNamed:iconName];
        }
        iconIV.tag = 9100;
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
        nameLab.tag = 9101;
        [row addSubview:nameLab];
        
        // 绑定状态（右对齐，离右箭头 8pt）
        // 箭头在 right=-12 宽16 → 箭头左边界 = _window_width-28 → 状态文字右边界 = _window_width-36
        NSString *statusText = bound ? @"已绑定" : @"未绑定";
        UIColor *statusColor = bound ? RGB(7, 193, 96) : RGB(153, 153, 153);
        UILabel *statusLab = [HistoryRecordModel createLabLabTextColor:statusColor fontFloat:13 textAlignment:NSTextAlignmentRight];
        statusLab.frame = CGRectMake(_window_width - 36 - 120, 0, 120, row.height);
        statusLab.text = statusText;
        statusLab.tag = 9102;
        [row addSubview:statusLab];
        
        // 右箭头
        UIImageView *nexIV = [HistoryRecordModel createImgImgView];
        nexIV.image = [UIImage imageNamed:@"next_Img2"];
        nexIV.tag = 9103;
        [row addSubview:nexIV];
        [nexIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(row.mas_right).offset(-12);
            make.centerY.equalTo(row.mas_centerY);
            make.width.height.offset(16);
        }];
        
        // 分割线
        if (i < platforms.count - 1) {
            UIView *linV = [HistoryRecordModel createLineViewUIUI];
            linV.frame = CGRectMake(0, row.height - 1, _window_width, 1);
            linV.tag = 9104;
            [row addSubview:linV];
        }
    }
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
