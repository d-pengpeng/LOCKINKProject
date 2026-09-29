//
//  MHRoleTwoSDDJStartView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/26.
//

#import "MHRoleTwoSDDJStartView.h"

@interface MHRoleTwoSDDJStartView ()

@property (nonatomic, strong) UILabel *tit_Lab;
@property (nonatomic, strong) NSArray *cont_bxArr;
@property (nonatomic, assign) int bf_num;
@end

@implementation MHRoleTwoSDDJStartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIButton *deleBBB = [HistoryRecordModel createImgBtn];
        deleBBB.frame = CGRectMake(self.width-16-36, 16, 36, 36);
        [deleBBB setImage:[UIImage imageNamed:@"delete_img1"] forState:UIControlStateNormal];
        [deleBBB addTarget:self action:@selector(deleBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBBB];
        
        self.tit_Lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        self.tit_Lab.numberOfLines = 0;
        self.tit_Lab.text = [NSString stringWithFormat:eLocalizedString(@"two_nams22"), @"xx"];
        [self addSubview:self.tit_Lab];
        [self.tit_Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(deleBBB.mas_bottom).offset(15);
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.offset(56);
        }];
        
        self.play_Btn = [HistoryRecordModel createImgBtn];
        [self.play_Btn setBackgroundImage:[UIImage imageNamed:@"play_allImgs2"] forState:UIControlStateNormal];
        [self.play_Btn setBackgroundImage:[UIImage imageNamed:@"play_allImgs1"] forState:UIControlStateSelected];
        [self.play_Btn addTarget:self action:@selector(playBtnMethodUIUIType) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.play_Btn];
        [self.play_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.tit_Lab.mas_bottom).offset(40);
            make.width.height.offset(64);
        }];
        
        UIButton *lefBtn = [HistoryRecordModel createImgBtn];
        [lefBtn setImage:[UIImage imageNamed:@"play_allImgs3"] forState:UIControlStateNormal];
        [lefBtn addTarget:self action:@selector(lefBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lefBtn];
        [lefBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.play_Btn.mas_left).offset(-30);
            make.centerY.equalTo(self.play_Btn.mas_centerY);
            make.width.height.offset(50);
        }];
        
        UIButton *rigBtn = [HistoryRecordModel createImgBtn];
        [rigBtn setImage:[UIImage imageNamed:@"play_allImgs4"] forState:UIControlStateNormal];
        [rigBtn addTarget:self action:@selector(rigBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rigBtn];
        [rigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.play_Btn.mas_right).offset(30);
            make.centerY.equalTo(self.play_Btn.mas_centerY);
            make.width.height.offset(50);
        }];
        
    }
    return self;
}

- (void)addBXUploadMethod
{
    if ([FloatingWindowModel shareInstance].bxMutArr.count > [FloatingWindowModel shareInstance].bx_row) {
        
        NSDictionary *dicM = [FloatingWindowModel shareInstance].bxMutArr[[FloatingWindowModel shareInstance].bx_row];
        MHBoXingModel *model = [MHBoXingModel mj_objectWithKeyValues:dicM];
        self.cont_bxArr = [minStr(model.content) componentsSeparatedByString:@","];
        self.bf_num = -1;
        
        self.tit_Lab.text = [NSString stringWithFormat:eLocalizedString(@"two_nams22"), model.title];
        
        self.play_Btn.selected = YES;
    }else {
        self.play_Btn.selected = NO;
    }
}

//获取当前播放 值
- (int)getPlayFFFHHH
{
    if (self.cont_bxArr.count > 0) {
        self.bf_num = self.bf_num+1;
        if (self.cont_bxArr.count > self.bf_num) {
            
        }else {
            self.bf_num = 0;
        }
        int ww_yy = [minStr(self.cont_bxArr[self.bf_num]) intValue];

        return ww_yy;
    }else {
        return -1;
    }
}


- (void)lefBtnMethod
{
    if ([FloatingWindowModel shareInstance].bxMutArr.count > 0) {
        if ([FloatingWindowModel shareInstance].bx_row <= 0) {
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"two_nams20")];
            [FloatingWindowModel shareInstance].bx_row = 0;
        }else {
            [FloatingWindowModel shareInstance].bx_row = [FloatingWindowModel shareInstance].bx_row-1;
            self.play_Btn.selected = YES;
            
            NSDictionary *dicM = [FloatingWindowModel shareInstance].bxMutArr[[FloatingWindowModel shareInstance].bx_row];
            MHBoXingModel *model = [MHBoXingModel mj_objectWithKeyValues:dicM];
            self.cont_bxArr = [minStr(model.content) componentsSeparatedByString:@","];
            self.bf_num = 0;
            
            self.tit_Lab.text = [NSString stringWithFormat:eLocalizedString(@"two_nams22"), model.title];
        }
    }
}

- (void)rigBtnMethod
{
    if ([FloatingWindowModel shareInstance].bxMutArr.count > 0) {
        if ([FloatingWindowModel shareInstance].bxMutArr.count > [FloatingWindowModel shareInstance].bx_row+1) {
            
            [FloatingWindowModel shareInstance].bx_row = [FloatingWindowModel shareInstance].bx_row+1;
            self.play_Btn.selected = YES;
            
            NSDictionary *dicM = [FloatingWindowModel shareInstance].bxMutArr[[FloatingWindowModel shareInstance].bx_row];
            MHBoXingModel *model = [MHBoXingModel mj_objectWithKeyValues:dicM];
            self.cont_bxArr = [minStr(model.content) componentsSeparatedByString:@","];
            self.bf_num = 0;
            
            self.tit_Lab.text = [NSString stringWithFormat:eLocalizedString(@"two_nams22"), model.title];
        }else {
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"two_nams21")];
            
            [FloatingWindowModel shareInstance].bx_row = [FloatingWindowModel shareInstance].bxMutArr.count-1;
        }
    }
}

- (void)playBtnMethodUIUIType
{
    self.play_Btn.selected = !self.play_Btn.selected;
    
}


- (void)deleBtnMethod
{
    if (self.block_) {
        self.block_();
    }
}

@end
