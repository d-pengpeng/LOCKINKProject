//
//  receiveRedbagView.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/26.
//

#import "receiveRedbagView.h"

@implementation receiveRedbagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        btnClose.backgroundColor = RGBA(0, 0, 0, 0.3);
//        [btnClose addTarget:self action:@selector(btnCLoseMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnClose];
        
        _oneVV = [HistoryRecordModel createViewUIUI];
        _oneVV.backgroundColor = UIColor.clearColor;
        [self addSubview:_oneVV];
        [_oneVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY).offset(-40);
            make.width.offset(290);
            make.height.offset(478);
        }];
        
    }
    return self;
}

- (void)requestMethodUrl:(NSString *)urlStr
{
    NSDictionary *dicdic = @{@"id":urlStr};
//    [requestToolClass postNetworkWithUrl:request_Redenvelope_getRedInfo andParameter:dicdic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//        self.allDic = info;
//        NSString *is_snatched = minStr(self.allDic[@"is_snatched"]);
//        if([is_snatched intValue]==0) {
//            [self addUIUIUIType:1];
//        }else if ([is_snatched intValue]==1) {
//            [self addUIUIUIType:2];
//        }else {
//            [self addUIUIUIType:3];
//        }
//        NSString *is_receive = minStr(self.allDic[@"is_receive"]);
//        if([is_receive boolValue]) {
//            if(self.block_) {
//                self.block_(self.typeLLM==1 ? 4:3, @"", self.allDic);
//            }
//            [self removeFromSuperview];
//        }else {
//            self.oneVV.backgroundColor = UIColor.whiteColor;
//        }
//    } fail:^(NSString * _Nonnull msg) {
//
//    }];
}

- (void)addUIUIUIType:(NSInteger)typeL
{
    [_oneVV removeAllSubviews];
    
    UIImageView *imgV = [HistoryRecordModel createImgImgView];
    imgV.image = [UIImage imageNamed:@"redbagIMgs3"];
    [_oneVV addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(_oneVV);
    }];
    
    if(typeL == 1) {
        
        UIImageView *headImgV = [HistoryRecordModel createImgImgView];
        headImgV.image = normal_placeHeadImg;
        headImgV.layer.cornerRadius = 40;
        [_oneVV addSubview:headImgV];
        [headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_oneVV.mas_top).offset(60);
            make.centerX.equalTo(_oneVV.mas_centerX);
            make.width.height.offset(80);
        }];
        [headImgV sd_setImageWithURL:[NSURL URLWithString:minStr(self.allDic[@"avatar"])] placeholderImage:normal_placeHeadImg];
        
        UILabel *contLab = [HistoryRecordModel createLabLabTextColor:RGB(255, 219, 181) fontFloat:20 textAlignment:NSTextAlignmentCenter];
        contLab.text = self.remarkStr.length>0 ? self.remarkStr : eLocalizedString(@"chat_al30");
        contLab.numberOfLines = 0;
        [_oneVV addSubview:contLab];
        [contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImgV.mas_bottom).offset(20);
            make.left.equalTo(_oneVV.mas_left).offset(20);
            make.right.equalTo(_oneVV.mas_right).offset(-20);
        }];
        
        UIButton *startBtn = [HistoryRecordModel createImgBtn];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"redbagIMgs1"] forState:UIControlStateNormal];
        [startBtn addTarget:self action:@selector(startBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:startBtn];
        [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_oneVV.mas_bottom).offset(-54);
            make.centerX.equalTo(_oneVV.mas_centerX);
            make.width.height.offset(100);
        }];
        
        UIButton *deleBtn = [HistoryRecordModel createImgBtn];
        [deleBtn setBackgroundImage:[UIImage imageNamed:@"redbagIMgs2"] forState:UIControlStateNormal];
        [deleBtn addTarget:self action:@selector(btnCLoseMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBtn];
        [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_oneVV.mas_bottom).offset(30);
            make.centerX.equalTo(self.mas_centerX);
            make.width.height.offset(36);
        }];
    }else if(typeL == 2) {
        
        UIImageView *headImgV = [HistoryRecordModel createImgImgView];
        headImgV.image = normal_placeHeadImg;
        headImgV.layer.cornerRadius = 40;
        [_oneVV addSubview:headImgV];
        [headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_oneVV.mas_top).offset(60);
            make.centerX.equalTo(_oneVV.mas_centerX);
            make.width.height.offset(80);
        }];
        
        [headImgV sd_setImageWithURL:[NSURL URLWithString:minStr(self.allDic[@"avatar"])] placeholderImage:normal_placeHeadImg];
        
        UILabel *contLab = [HistoryRecordModel createLabLabTextColor:RGB(255, 219, 181) fontFloat:20 textAlignment:NSTextAlignmentCenter];
        contLab.text = eLocalizedString(@"chat_al41");
        contLab.numberOfLines = 0;
        [_oneVV addSubview:contLab];
        [contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImgV.mas_bottom).offset(20);
            make.left.equalTo(_oneVV.mas_left).offset(20);
            make.right.equalTo(_oneVV.mas_right).offset(-20);
        }];
        
        UIButton *startBtn = [HistoryRecordModel createImgBtn];
        [startBtn setTitle:eLocalizedString(@"chat_al42") forState:UIControlStateNormal];
        [startBtn setTitleColor:RGB(255, 219, 181) forState:UIControlStateNormal];
        startBtn.titleLabel.font = SYS_Font(14);
        [startBtn addTarget:self action:@selector(startListBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:startBtn];
        [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_oneVV.mas_bottom).offset(-30);
            make.centerX.equalTo(_oneVV.mas_centerX);
            make.height.offset(40);
        }];
        
        UIButton *deleBtn = [HistoryRecordModel createImgBtn];
        [deleBtn setBackgroundImage:[UIImage imageNamed:@"redbagIMgs2"] forState:UIControlStateNormal];
        [deleBtn addTarget:self action:@selector(btnCLoseMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBtn];
        [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_oneVV.mas_bottom).offset(30);
            make.centerX.equalTo(self.mas_centerX);
            make.width.height.offset(36);
        }];
    }else if(typeL == 3) {
        
        UIImageView *headImgV = [HistoryRecordModel createImgImgView];
        headImgV.image = normal_placeHeadImg;
        headImgV.layer.cornerRadius = 40;
        [_oneVV addSubview:headImgV];
        [headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_oneVV.mas_top).offset(60);
            make.centerX.equalTo(_oneVV.mas_centerX);
            make.width.height.offset(80);
        }];
        [headImgV sd_setImageWithURL:[NSURL URLWithString:minStr(self.allDic[@"avatar"])] placeholderImage:normal_placeHeadImg];
        
        UILabel *contLab = [HistoryRecordModel createLabLabTextColor:RGB(255, 219, 181) fontFloat:20 textAlignment:NSTextAlignmentCenter];
        contLab.text = eLocalizedString(@"chat_al41_1");
        contLab.numberOfLines = 0;
        [_oneVV addSubview:contLab];
        [contLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImgV.mas_bottom).offset(20);
            make.left.equalTo(_oneVV.mas_left).offset(20);
            make.right.equalTo(_oneVV.mas_right).offset(-20);
        }];
        
        UIButton *deleBtn = [HistoryRecordModel createImgBtn];
        [deleBtn setBackgroundImage:[UIImage imageNamed:@"redbagIMgs2"] forState:UIControlStateNormal];
        [deleBtn addTarget:self action:@selector(btnCLoseMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBtn];
        [deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_oneVV.mas_bottom).offset(30);
            make.centerX.equalTo(self.mas_centerX);
            make.width.height.offset(36);
        }];
    }
}

- (void)btnCLoseMethod
{
    [self removeFromSuperview];
}

- (void)startBtnMethod
{
//    [requestToolClass postNetworkWithUrl:request_Redenvelope_receiveRed andParameter:@{@"id":self.redId} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//        
//        if(self.block_) {
//            self.block_(self.typeLLM, minStr(info), self.allDic);
//        }
//        [self removeFromSuperview];
//    } fail:^(NSString * _Nonnull msg) {
//        [self addUIUIUIType:2];
//    }];
    
}

- (void)startListBtnMethod
{
    if(self.block_) {
        self.block_(self.typeLLM==1 ? 4:3, @"", self.allDic);
    }
    [self removeFromSuperview];
}

@end
