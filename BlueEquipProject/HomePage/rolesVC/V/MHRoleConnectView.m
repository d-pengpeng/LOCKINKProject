//
//  MHRoleConnectView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/8.
//

#import "MHRoleConnectView.h"

@implementation MHRoleConnectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        UIButton *deleBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        deleBBB.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deleBBB addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBBB];
        
    }
    return self;
}

-(void)addUIUIUIUIType:(NSInteger)typNum
{
    if(typNum == 1) {
        UIView *placVV = [HistoryRecordModel createViewUIUI];
        placVV.backgroundColor = UIColor.clearColor;
        [self addSubview:placVV];
        [placVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.offset(300);
            make.height.mas_greaterThanOrEqualTo(150);
        }];
        
        UIImageView *imgVV = [HistoryRecordModel createImgImgView];
        imgVV.image = [UIImage imageNamed:@"toysAllImg4"];
        [placVV addSubview:imgVV];
        [imgVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(placVV.mas_top);
            make.centerX.equalTo(placVV.mas_centerX);
            make.width.height.offset(100);
        }];
        
        NSString *mm_www = [NSString stringWithFormat:@"  %@  ", eLocalizedString(@"new_msg_4")];
        UIButton *stopBtn = [HistoryRecordModel createImgBtn];
        stopBtn.backgroundColor = RGB(138, 0, 197);
        stopBtn.layer.cornerRadius = 6;
        [stopBtn setTitle:mm_www forState:UIControlStateNormal];
        [stopBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        stopBtn.titleLabel.font = SYS_Font(14);
        [stopBtn addTarget:self action:@selector(stopBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [placVV addSubview:stopBtn];
        [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgVV.mas_bottom).offset(20);
            make.centerX.equalTo(placVV.mas_centerX);
            make.width.mas_greaterThanOrEqualTo(112);
            make.height.offset(30);
        }];
        
        UIView *lllVVV = [[UIView alloc] init];
        [placVV addSubview:lllVVV];
        [lllVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(stopBtn.mas_bottom).offset(20);
            make.centerX.equalTo(placVV.mas_centerX);
            make.width.mas_lessThanOrEqualTo(_window_width-80);
            make.height.mas_greaterThanOrEqualTo(16);
            make.bottom.equalTo(placVV.mas_bottom);
        }];
        
        UIImageView *tanhImgV = [HistoryRecordModel createImgImgView];
        tanhImgV.image = [UIImage imageNamed:@"tanhao_img1"];
        [lllVVV addSubview:tanhImgV];
        [tanhImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(lllVVV);
            make.width.height.offset(16);
        }];
        
        UILabel *tan_Lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        tan_Lab.text = eLocalizedString(@"new_msg_9");
        tan_Lab.numberOfLines = 0;
        [lllVVV addSubview:tan_Lab];
        [tan_Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tanhImgV.mas_right).offset(6);
            make.top.equalTo(lllVVV.mas_top);
            make.right.equalTo(lllVVV.mas_right);
            make.bottom.equalTo(lllVVV.mas_bottom);
        }];
    }
}

- (void)stopBtnMethod
{
    if(self.block_) {
        self.block_(YES);
    }
//    [self removeFromSuperview];
}

- (void)deleBtnMethod
{
    if(self.block_) {
        self.block_(NO);
    }
//    [self removeFromSuperview];
}

@end
