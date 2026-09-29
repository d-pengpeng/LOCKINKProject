//
//  MHsettingsSubController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import "MHsettingsSubController.h"
#import "MHRedoPasswordController.h"

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = eLocalizedString(@"my_settings1");
    self.navView.backgroundColor = RGB(247, 247, 247);

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
}

- (void)clicListTagsMethod:(UIButton *)btn
{
    if(btn.tag == 500) {
        
        MHRedoPasswordController *vc = [[MHRedoPasswordController alloc] init];
        vc.isChageAccount = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        MHRedoPasswordController *vc = [[MHRedoPasswordController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
