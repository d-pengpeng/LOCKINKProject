//
//  mandatoryUpdateView.m
//  DragonTeethLive
//
//  Created by Edwin on 2022/10/26.
//

#import "mandatoryUpdateView.h"

@interface mandatoryUpdateView ()

@property (nonatomic, copy) NSString *uplUrl;
@end
@implementation mandatoryUpdateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIView *botmVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        botmVVV.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self addSubview:botmVVV];
    }
    return self;
}

- (void)addUIUIUIUI:(NSDictionary *)dicMM
{
    self.uplUrl = minStr(dicMM[@"downloadUrl"]);
    
    UIView *contVV = [HistoryRecordModel createViewUIUI];
    contVV.backgroundColor = UIColor.clearColor;
    [self addSubview:contVV];
    [contVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-30);
        make.width.offset(270);
        make.height.offset(310);
    }];
    
    UIImageView *imgV = [HistoryRecordModel createImgImgView];
    imgV.image = [UIImage imageNamed:@"mandatoryUpdateImg"];
    [contVV addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(contVV);
    }];
    
    UILabel *oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:18 textAlignment:NSTextAlignmentLeft];
    oneLab.text = eLocalizedString(@"updatedVersion1");
    [contVV addSubview:oneLab];
    [oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contVV.mas_left).offset(15);
        make.top.equalTo(contVV.mas_top).offset(25);
        make.right.equalTo(contVV.mas_right).offset(-10);
        make.height.offset(34);
    }];
    
    UILabel *twoLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
    twoLab.text = [NSString stringWithFormat:@"V%@", dicMM[@"code"]];
    [contVV addSubview:twoLab];
    [twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contVV.mas_left).offset(15);
        make.top.equalTo(oneLab.mas_bottom);
        make.right.equalTo(contVV.mas_right).offset(-10);
        make.height.offset(34);
    }];
    
    UILabel *thrLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    thrLab.text = eLocalizedString(@"updatedVersion3");
    thrLab.font = [UIFont systemFontOfSize:16 weight:0.5];
    [contVV addSubview:thrLab];
    [thrLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contVV.mas_left).offset(15);
        make.top.equalTo(twoLab.mas_bottom).offset(45);
        make.right.equalTo(contVV.mas_right).offset(-15);
        make.height.offset(36);
    }];
    
    UITextView *texvVV = [[UITextView alloc] init];
    texvVV.textColor = UIColor.blackColor;
    texvVV.font = SYS_Font(14);
    texvVV.text = [NSString stringWithFormat:@"%@", dicMM[@"content"]];
    texvVV.backgroundColor = UIColor.whiteColor;
    texvVV.editable = NO;
    [contVV addSubview:texvVV];
    [texvVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contVV.mas_left).offset(15);
        make.top.equalTo(thrLab.mas_bottom).offset(0);
        make.right.equalTo(contVV.mas_right).offset(-15);
        make.bottom.equalTo(contVV.mas_bottom).offset(-50);
    }];

    
//    if ([LYUserDefault userDefault].iosMandatoryUpdateSandbox) {
//
//        UIButton *updateBtn = [HistoryRecordModel createImgBtn];
//        [updateBtn setTitle:eLocalizedString(@"updatedVersion2") forState:UIControlStateNormal];
//        [updateBtn setTitleColor:normalColors forState:UIControlStateNormal];
//        updateBtn.titleLabel.font = SYS_Font(16);
//        [updateBtn addTarget:self action:@selector(updateBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//        [contVV addSubview:updateBtn];
//        [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(contVV);
//            make.bottom.equalTo(contVV.mas_bottom);
//            make.height.offset(48);
//        }];
//    }else {
        
        UIButton *updateBtn = [HistoryRecordModel createImgBtn];
        [updateBtn setTitle:eLocalizedString(@"updatedVersion2") forState:UIControlStateNormal];
        [updateBtn setTitleColor:normalColors forState:UIControlStateNormal];
        updateBtn.titleLabel.font = SYS_Font(16);
        [updateBtn addTarget:self action:@selector(updateBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [contVV addSubview:updateBtn];
        [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contVV.mas_right);
            make.bottom.equalTo(contVV.mas_bottom);
            make.width.offset(135);
            make.height.offset(48);
        }];
        
        UIButton *noBtn = [HistoryRecordModel createImgBtn];
        [noBtn setTitle:eLocalizedString(@"home_Cancel") forState:UIControlStateNormal];
        [noBtn setTitleColor:GrayText forState:UIControlStateNormal];
        noBtn.titleLabel.font = SYS_Font(16);
        [noBtn addTarget:self action:@selector(noBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [contVV addSubview:noBtn];
        [noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contVV.mas_left);
            make.bottom.equalTo(contVV.mas_bottom);
            make.width.offset(135);
            make.height.offset(48);
        }];
//    }
    
    UIView *lineVV = [HistoryRecordModel createLineViewUIUI];
    [contVV addSubview:lineVV];
    [lineVV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contVV);
        make.bottom.equalTo(contVV.mas_bottom).offset(-48);
        make.height.offset(1);
    }];
    
}

- (void)updateBtnMethod
{
//    NSString *safari_url = [self.uplUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if (safari_url.length > 0) {
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:safari_url]]) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:safari_url] options:@{} completionHandler:^(BOOL success) {
//                
//            }];
//        }
//    }
    
    NSURL *url = [NSURL URLWithString:self.uplUrl];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
    
}

- (void)noBtnMethod
{
    [self removeFromSuperview];
}


@end
