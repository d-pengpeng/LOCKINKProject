//
//  MHPrivacyController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/1.
//

#import "MHPrivacyController.h"
#import "MHAboutSubController.h"

@interface MHPrivacyController ()

@end

@implementation MHPrivacyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;
    self.showImgVV = YES;
    UIView *linVV = [HistoryRecordModel createLineViewUIUI];
    linVV.frame = CGRectMake(0, NAVHEIGHT-1, _window_width, 1);
    linVV.backgroundColor = RGB(121, 121, 121);
    [self.navView addSubview:linVV];
    self.titleName.text = eLocalizedString(@"my_settings2");
    
    for (int i=0; i<1; i++) {
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.backgroundColor = RGB(46, 54, 65);
        [self.view addSubview:oneVV];
        if(i==0) {
            oneVV.frame = CGRectMake(12, NAVHEIGHT+15, _window_width-24, 54);
            UILabel *labLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            labLab.frame = CGRectMake(12, 0, oneVV.width-100, oneVV.height);
            labLab.text = eLocalizedString(@"my_settings33");
            [oneVV addSubview:labLab];
            
            UIImageView *nexIV = [HistoryRecordModel createImgImgView];
            nexIV.image = [UIImage imageNamed:@"next_Img"];
            [oneVV addSubview:nexIV];
            [nexIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(oneVV.mas_right).offset(-12);
                make.centerY.equalTo(oneVV.mas_centerY);
                make.width.height.offset(18);
            }];
            
            UIButton *cliBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, oneVV.width, oneVV.height-10)];
            [cliBBtn addTarget:self action:@selector(clicListTagsMethod) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:cliBBtn];
        }else {
            oneVV.frame = CGRectMake(12, NAVHEIGHT+15+74, _window_width-24, 54);
            UILabel *labLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            labLab.frame = CGRectMake(12, 0, oneVV.width-115, oneVV.height);
            labLab.text = eLocalizedString(@"my_settings34");
            labLab.numberOfLines = 0;
            [oneVV addSubview:labLab];
            
            UIButton *KK = [HistoryRecordModel createImgBtn];
            [KK setBackgroundImage:[UIImage imageNamed:@"switch_norlImg"] forState:UIControlStateNormal];
            [KK setBackgroundImage:[UIImage imageNamed:@"switch_selImg"] forState:UIControlStateSelected];
            [KK addTarget:self action:@selector(KeepAwakeMethod:) forControlEvents:UIControlEventTouchUpInside];
            [oneVV addSubview:KK];
            [KK mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(oneVV.mas_right).offset(-12);
                make.centerY.equalTo(oneVV.mas_centerY);
                make.width.offset(47);
                make.height.offset(28);
            }];
        }
    }
    
    UIView *twoVV = [HistoryRecordModel createViewUIUI];
    twoVV.backgroundColor = UIColor.clearColor;
    twoVV.layer.borderColor = UIColor.whiteColor.CGColor;
    twoVV.layer.borderWidth = 1;
    [self.view addSubview:twoVV];
    [twoVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(self.navView.mas_bottom).offset(15+74*2-50);
        make.height.mas_greaterThanOrEqualTo(100);
    }];
    
    UILabel *twoLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    twoLab.text = eLocalizedString(@"my_settings35");
    [twoVV addSubview:twoLab];
    [twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoVV.mas_left).offset(12);
        make.top.equalTo(twoVV.mas_top).offset(12);
        make.right.equalTo(twoVV.mas_right).offset(-12);
        make.height.offset(20);
    }];

    UILabel *twoLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    twoLab2.text = eLocalizedString(@"my_settings36");
    twoLab2.numberOfLines = 0;
    [twoVV addSubview:twoLab2];
    [twoLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(twoVV.mas_left).offset(12);
        make.top.equalTo(twoLab.mas_bottom).offset(8);
        make.right.equalTo(twoVV.mas_right).offset(-12);
        make.bottom.equalTo(twoVV.mas_bottom).offset(-12);
    }];
    twoLab2.attributedText = [HistoryRecordModel AttributedStringTwoTogether:eLocalizedString(@"my_settings37") All:eLocalizedString(@"my_settings36") nameFont:SYS_Font(12) allFont:SYS_Font(12) nameColor:RGB(255, 0, 128) allColor:RGB(232, 232, 232)];
    
    UIButton *priVBtn = [[UIButton alloc] init];
    [priVBtn addTarget:self action:@selector(addUIUIUMethod) forControlEvents:UIControlEventTouchUpInside];
    [twoVV addSubview:priVBtn];
    [priVBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(twoVV);
        make.height.offset(60);
    }];
    
}

- (void)KeepAwakeMethod:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (void)clicListTagsMethod
{
  
}

- (void)addUIUIUMethod
{
//    MHAboutSubController *vc = [[MHAboutSubController alloc] init];
//    vc.typeNN = 1;
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
