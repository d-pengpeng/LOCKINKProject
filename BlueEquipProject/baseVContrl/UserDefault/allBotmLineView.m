//
//  allBotmLineView.m
//  AuctionLiveProject
//
//  Created by Edwin on 2023/5/13.
//

#import "allBotmLineView.h"

@implementation allBotmLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        UIView *contLLab = [[UIView alloc] init];
        [self addSubview:contLLab];
        [contLLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.offset(self.height);
//            make.width.mas_greaterThanOrEqualTo(80);
            make.width.offset(30);
        }];
        
//        UILabel *namLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentCenter];
//        namLab.text = eLocalizedString(@"pingtai_jianjie");
//        [contLLab addSubview:namLab];
//        [namLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(contLLab.mas_left);
//            make.centerY.equalTo(contLLab.mas_centerY);
//        }];
        
//        UIImageView *logoImgV = [HistoryRecordModel createImgImgView];
//        logoImgV.image = [UIImage imageNamed:@"logoImg"];
//        [contLLab addSubview:logoImgV];
//        [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(namLab.mas_right).offset(4);
//            make.centerY.equalTo(contLLab.mas_centerY);
//            make.width.height.offset(30);
//            make.right.equalTo(contLLab.mas_right);
//        }];
        
        UIImageView *logoImgV = [HistoryRecordModel createImgImgView];
        logoImgV.image = [UIImage imageNamed:@"logoImgHome"];
        [contLLab addSubview:logoImgV];
        [logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contLLab.mas_left);
            make.centerY.equalTo(contLLab.mas_centerY);
//            make.width.offset(30);
            make.height.offset(44);
            make.right.equalTo(contLLab.mas_right);
        }];
        
        
        UIView *lineVV = [[UIView alloc] init];
        lineVV.backgroundColor = RGB(230, 230, 230);
        [self addSubview:lineVV];
        [lineVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(16);
            make.right.equalTo(contLLab.mas_left).offset(-16);
            make.centerY.equalTo(self.mas_centerY);
            make.height.offset(2);
        }];
        
        UIView *lineVV2 = [[UIView alloc] init];
        lineVV2.backgroundColor = RGB(230, 230, 230);
        [self addSubview:lineVV2];
        [lineVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contLLab.mas_right).offset(16);
            make.right.equalTo(self.mas_right).offset(-16);
            make.centerY.equalTo(self.mas_centerY);
            make.height.offset(2);
        }];
        
        UIButton *clcikBtn = [[UIButton alloc] init];
        [clcikBtn addTarget:self action:@selector(clickMethodBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clcikBtn];
        [clcikBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.offset(200);
            make.height.offset(30);
        }];
    }
    return self;
}

- (void)clickMethodBtn
{
//    UIViewController *vcM = [[FloatingWindowModel shareInstance] getCurrentViewController];
    
    
}

@end
