//
//  MHPasscodeSetController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/1.
//

#import "MHPasscodeSetController.h"
#import "eSecurityCodeView.h"

@interface MHPasscodeSetController ()

@property (nonatomic, strong) UIButton *addPlayBtn;
@property (nonatomic, strong) UIButton *addPlayBtn2;
@end

@implementation MHPasscodeSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = YES;
    self.showImgVV = YES;
    UIView *linVV = [HistoryRecordModel createLineViewUIUI];
    linVV.frame = CGRectMake(0, NAVHEIGHT-1, _window_width, 1);
    linVV.backgroundColor = RGB(121, 121, 121);
    [self.navView addSubview:linVV];
    self.titleName.text = eLocalizedString(@"my_settings10");
    
    UIImageView *imgV = [HistoryRecordModel createImgImgView];
    imgV.image = [UIImage imageNamed:@"lock_img"];
    [self.view addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.offset(74);
        make.height.offset(86);
    }];
    
    UILabel *oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
    oneLab.text = eLocalizedString(@"my_settings21");
    oneLab.numberOfLines = 0;
    [self.view addSubview:oneLab];
    [oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(imgV.mas_bottom).offset(30);
        make.height.mas_greaterThanOrEqualTo(40);
    }];
    
    UILabel *oneLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
    oneLab2.text = eLocalizedString(@"my_settings22");
    oneLab2.numberOfLines = 0;
    [self.view addSubview:oneLab2];
    [oneLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(50);
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.top.equalTo(oneLab.mas_bottom).offset(12);
        make.height.mas_greaterThanOrEqualTo(34);
    }];
    
    if([LYUserDefault userDefault].isSetLock) {
        
        _addPlayBtn = [HistoryRecordModel createImgBtn];
        [_addPlayBtn setBackgroundImage:[UIImage imageNamed:@"ModeImgs13"] forState:UIControlStateNormal];
        [_addPlayBtn setTitle:eLocalizedString(@"my_settings26") forState:UIControlStateNormal];
        [_addPlayBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _addPlayBtn.titleLabel.font = SYS_Font(18);
        [_addPlayBtn addTarget:self action:@selector(addPlayMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_addPlayBtn];
        [_addPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.top.equalTo(oneLab2.mas_bottom).offset(48);
            make.height.offset(46);
        }];
        
        _addPlayBtn2 = [HistoryRecordModel createImgBtn];
        [_addPlayBtn2 setBackgroundImage:[UIImage imageNamed:@"ModeImgs13_13"] forState:UIControlStateNormal];
        [_addPlayBtn2 setTitle:eLocalizedString(@"my_settings25") forState:UIControlStateNormal];
        [_addPlayBtn2 setTitleColor:RGB(255, 0, 128) forState:UIControlStateNormal];
        _addPlayBtn2.titleLabel.font = SYS_Font(18);
        [_addPlayBtn2 addTarget:self action:@selector(addPlayMethodTwo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_addPlayBtn2];
        [_addPlayBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.top.equalTo(_addPlayBtn.mas_bottom).offset(14);
            make.height.offset(46);
        }];
//        if(![LYUserDefault userDefault].isSetLockDisable) {
//            [_addPlayBtn setTitle:eLocalizedString(@"my_settings26") forState:UIControlStateNormal];
//        }
    }else {
        _addPlayBtn = [HistoryRecordModel createImgBtn];
        [_addPlayBtn setBackgroundImage:[UIImage imageNamed:@"ModeImgs13"] forState:UIControlStateNormal];
        [_addPlayBtn setTitle:eLocalizedString(@"my_settings23") forState:UIControlStateNormal];
        [_addPlayBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _addPlayBtn.titleLabel.font = SYS_Font(18);
        [_addPlayBtn addTarget:self action:@selector(addPlayMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_addPlayBtn];
        [_addPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.top.equalTo(oneLab2.mas_bottom).offset(48);
            make.height.offset(46);
        }];
        
        _addPlayBtn2 = [HistoryRecordModel createImgBtn];
        [_addPlayBtn2 setBackgroundImage:[UIImage imageNamed:@"ModeImgs13_13"] forState:UIControlStateNormal];
        [_addPlayBtn2 setTitle:eLocalizedString(@"my_settings25") forState:UIControlStateNormal];
        [_addPlayBtn2 setTitleColor:RGB(255, 0, 128) forState:UIControlStateNormal];
        _addPlayBtn2.titleLabel.font = SYS_Font(18);
        [_addPlayBtn2 addTarget:self action:@selector(addPlayMethodTwo) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_addPlayBtn2];
        [_addPlayBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
            make.top.equalTo(_addPlayBtn.mas_bottom).offset(14);
            make.height.offset(46);
        }];
        _addPlayBtn2.hidden = YES;
    }
}

- (void)addPlayMethod
{
    if([LYUserDefault userDefault].isSetLock) {
//        if([LYUserDefault userDefault].isSetLockDisable) {
//            [LYUserDefault saveSetLockDisable:NO];
//            [self.addPlayBtn setTitle:eLocalizedString(@"my_settings26") forState:UIControlStateNormal];
//        }else {
            
            [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"my_settings27") leftButtonTitle:eLocalizedString(@"home_No") rightButtonTitle:eLocalizedString(@"home_Yes") selectedHandle:^(NSInteger index) {
                if (index == 1) {
                    
//                    [LYUserDefault saveSetLockDisable:YES];
                    [LYUserDefault saveSetLock:NO];
                    [self.addPlayBtn setTitle:eLocalizedString(@"my_settings23") forState:UIControlStateNormal];
                    self.addPlayBtn2.hidden = YES;
                }
            }];
//        }
    }else {
        //MARK: 设置屏保密码
        eSecurityCodeView *vcM = [[eSecurityCodeView alloc] init];
        vcM.isSetting = YES;
        [self.navigationController pushViewController:vcM animated:YES];
        vcM.eSecurityCodBlock = ^(NSInteger num) {
            [self.addPlayBtn setTitle:eLocalizedString(@"my_settings26") forState:UIControlStateNormal];
            self.addPlayBtn2.hidden = NO;
        };
    }
}

- (void)addPlayMethodTwo
{
    eSecurityCodeView *vcM = [[eSecurityCodeView alloc] init];
    vcM.isSetting = YES;
    [self.navigationController pushViewController:vcM animated:YES];
    vcM.eSecurityCodBlock = ^(NSInteger num) {
      
    };
}

@end
