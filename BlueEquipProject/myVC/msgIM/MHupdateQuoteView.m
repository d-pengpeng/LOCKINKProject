//
//  MHupdateQuoteView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/4.
//

#import "MHupdateQuoteView.h"

@implementation MHupdateQuoteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        UIButton *botmVV = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        botmVV.backgroundColor = RGBA(0, 0, 0, 0.3);
        [botmVV addTarget:self action:@selector(deleteBBBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:botmVV];
        
        UIView *ccontVVV = [[UIView alloc] init];
        ccontVVV.backgroundColor = UIColor.clearColor;
        ccontVVV.layer.cornerRadius = 12;
        ccontVVV.clipsToBounds = YES;
        [self addSubview:ccontVVV];
        [ccontVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_centerY).offset(80);
            make.width.offset(280);
            make.height.offset(180);
        }];
        
        UIImageView *imgV = [HistoryRecordModel createImgImgView];
        imgV.image = [UIImage imageNamed:@"toysAllImg3"];
        [ccontVVV addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(ccontVVV);
        }];
        
        self.textVV = [[UITextView alloc] init];
        self.textVV.backgroundColor = UIColor.whiteColor;
        self.textVV.layer.cornerRadius = 8;
        self.textVV.clipsToBounds = YES;
        self.textVV.textColor = GrayTextColor;
        self.textVV.font = SYS_Font(14);
        [ccontVVV addSubview:self.textVV];
        [self.textVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(ccontVVV).offset(30);
            make.right.equalTo(ccontVVV.mas_right).offset(-30);
            make.height.offset(76);
        }];
        
        UIButton *lefBBtn = [HistoryRecordModel createImgBtn];
        lefBBtn.backgroundColor = UIColor.clearColor;
        lefBBtn.layer.cornerRadius = 4;
        lefBBtn.layer.borderColor = UIColor.whiteColor.CGColor;
        lefBBtn.layer.borderWidth = 1;
        [lefBBtn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        lefBBtn.titleLabel.font = SYS_Font(14);
        [lefBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [lefBBtn addTarget:self action:@selector(deleteBBBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [ccontVVV addSubview:lefBBtn];
        [lefBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ccontVVV.mas_left).offset(38);
            make.bottom.equalTo(ccontVVV.mas_bottom).offset(-28);
            make.top.equalTo(self.textVV.mas_bottom).offset(20);
            make.height.offset(36);
            make.width.offset(92);
        }];
        
        UIButton *lefBBtn2 = [HistoryRecordModel createImgBtn];
        lefBBtn2.backgroundColor = RGB(117, 34, 169);
        lefBBtn2.layer.cornerRadius = 4;
        [lefBBtn2 setTitle:eLocalizedString(@"home_Sure") forState:UIControlStateNormal];
        lefBBtn2.titleLabel.font = SYS_Font(14);
        [lefBBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [lefBBtn2 addTarget:self action:@selector(sureBtnMethodUIUI) forControlEvents:UIControlEventTouchUpInside];
        [ccontVVV addSubview:lefBBtn2];
        [lefBBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ccontVVV.mas_right).offset(-38);
            make.bottom.equalTo(ccontVVV.mas_bottom).offset(-28);
            make.top.equalTo(self.textVV.mas_bottom).offset(20);
            make.height.offset(36);
            make.width.offset(92);
        }];
    }
    return self;
}

- (void)sureBtnMethodUIUI
{
    if(self.textVV.text.length > 0) {
        if(self.block_) {
            self.block_(minStr(self.textVV.text));
        }
    }
    [self removeFromSuperview];
}

- (void)deleteBBBtnMethod
{
    [self removeFromSuperview];
}

@end
