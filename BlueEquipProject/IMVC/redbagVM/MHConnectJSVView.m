//
//  MHConnectJSVView.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/29.
//

#import "MHConnectJSVView.h"

@interface MHConnectJSVView ()

@property (nonatomic, strong) UIImageView *imgHead;
@property (nonatomic, strong) UILabel *nickLab;
@end
@implementation MHConnectJSVView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIView *backVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        backVV.backgroundColor = RGBA(0, 0, 0, 0.3);
        [self addSubview:backVV];
        
        UIView *oneVV = [HistoryRecordModel createViewUIUI];
        oneVV.layer.cornerRadius = 16;
        oneVV.frame = CGRectMake(30, self.height/2-150, self.width-60, 300);
        [self addSubview:oneVV];
        
        UIImageView *oneIIIMg = [HistoryRecordModel createImgImgView];
        oneIIIMg.image = [UIImage imageNamed:@"IM_imgConnect2"];
        [oneVV addSubview:oneIIIMg];
        [oneIIIMg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(oneVV);
        }];
        
        self.imgHead = [HistoryRecordModel createImgImgView];
        self.imgHead.image = normal_placeHeadImg;
        self.imgHead.layer.cornerRadius = 37;
        [oneVV addSubview:self.imgHead];
        [self.imgHead mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneVV.mas_top).offset(20);
            make.centerX.equalTo(oneVV.mas_centerX);
            make.width.height.offset(74);
        }];
        
        self.nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        [oneVV addSubview:self.nickLab];
        [self.nickLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imgHead.mas_bottom).offset(5);
            make.left.equalTo(oneVV.mas_left).offset(20);
            make.right.equalTo(oneVV.mas_right).offset(-20);
            make.height.offset(32);
        }];
        
        UILabel *msgLab1 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        msgLab1.text = eLocalizedString(@"chat_all10");
        [oneVV addSubview:msgLab1];
        [msgLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(10);
            make.right.equalTo(oneVV.mas_right).offset(-10);
            make.top.equalTo(self.nickLab.mas_bottom).offset(8);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        
        UILabel *msgLab2 = [HistoryRecordModel createLabLabTextColor:RGBA(13, 223, 255, 1) fontFloat:14 textAlignment:NSTextAlignmentCenter];
        msgLab2.text = eLocalizedString(@"chat_all11");
        [oneVV addSubview:msgLab2];
        [msgLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(10);
            make.right.equalTo(oneVV.mas_right).offset(-10);
            make.top.equalTo(msgLab1.mas_bottom).offset(8);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        
        UIButton *lefBBtn = [HistoryRecordModel createImgBtn];
        lefBBtn.backgroundColor = UIColor.whiteColor;
        lefBBtn.layer.cornerRadius = 4;
        [lefBBtn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        lefBBtn.titleLabel.font = SYS_Font(14);
        [lefBBtn setTitleColor:RGB(255, 0, 128) forState:UIControlStateNormal];
        [lefBBtn addTarget:self action:@selector(leftBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:lefBBtn];
        [lefBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oneVV.mas_left).offset(26);
            make.bottom.equalTo(oneVV.mas_bottom).offset(-28);
            make.right.equalTo(oneVV.mas_centerX).offset(-12);
            make.height.offset(34);
        }];
        
        UIButton *lefBBtn2 = [HistoryRecordModel createImgBtn];
        lefBBtn2.backgroundColor = RGB(255, 0, 128);
        lefBBtn2.layer.cornerRadius = 4;
        [lefBBtn2 setTitle:eLocalizedString(@"home_Sure2") forState:UIControlStateNormal];
        lefBBtn2.titleLabel.font = SYS_Font(14);
        [lefBBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [lefBBtn2 addTarget:self action:@selector(leftBtnMethodTwo) forControlEvents:UIControlEventTouchUpInside];
        [oneVV addSubview:lefBBtn2];
        [lefBBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(oneVV.mas_right).offset(-26);
            make.bottom.equalTo(oneVV.mas_bottom).offset(-28);
            make.left.equalTo(oneVV.mas_centerX).offset(12);
            make.height.offset(34);
        }];
    }
    return self;
}

- (void)addDicMethod:(NSDictionary *)dicM
{
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:minStr(dicM[@"fromHandImg"])] placeholderImage:normal_placeHeadImg];
    self.nickLab.text = minStr(dicM[@"fromNickName"]);
}

- (void)leftBtnMethodTwo
{
    if(self.block_) {
        self.block_(YES);
    }
    [self removeFromSuperview];
}

- (void)leftBtnMethod
{
    if(self.block_) {
        self.block_(NO);
    }
    [self removeFromSuperview];
}

@end
