//
//  eSelectCountryCodeView.m
//  yunbaolive
//
//  东莞梦幻网络科技有限公司 注 on 2021/5/8.
//  Copyright © 2021 cat. All rights reserved.
//

#import "eSelectCountryCodeView.h"

@interface eSelectCountryCodeView ()


@end

@implementation eSelectCountryCodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addUIUIUI];
    }
    return self;
}

- (void)addUIUIUI
{
    UIScrollView *scrolV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 188, 350)];
    scrolV.showsVerticalScrollIndicator = YES;
    scrolV.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrolV];
    
    NSArray *countryArr = [LYUserDefault userDefault].CountryCode;
    NSArray *codeArr = @[@"+86", @"+971", @"+44", @"+1", @"+598", @"+233", @"+58"];
//    NSArray *nameArr = @[@"中国", @"阿拉伯联合酋长国", @"英国", @"美国", @"乌拉圭", @"乌兹别克斯坦", @"委内瑞拉"];
    if (countryArr.count > 0) {
//        NSMutableArray *name_Mut = [NSMutableArray array];
        NSMutableArray *code_Mut = [NSMutableArray array];
        
        for (int i=0; i<countryArr.count; i++) {
//            NSDictionary *dic_mut = countryArr[i];
//            [name_Mut addObject:[NSString stringWithFormat:@"%@", dic_mut[@"name"]]];
//            [code_Mut addObject:[NSString stringWithFormat:@"%@", dic_mut[@"code"]]];
            [code_Mut addObject:minStr(countryArr[i])];
        }
        codeArr = code_Mut;
//        nameArr = name_Mut;
    }
    
    scrolV.contentSize = CGSizeMake(60, 5+50*codeArr.count);
    for (int i=0; i<codeArr.count; i++) {
        
        UIView *VVcont = [[UIView alloc] initWithFrame:CGRectMake(5, 50*i, 178, 50)];
        [scrolV addSubview:VVcont];
        
        UILabel *oenLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        oenLab.text = codeArr[i];
        oenLab.tag = i+1000;
        [VVcont addSubview:oenLab];
        [oenLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(VVcont.mas_left).offset(12);
            make.centerY.equalTo(VVcont.mas_centerY);
        }];
        UILabel *twoLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
//        twoLab.text = nameArr[i];
        [VVcont addSubview:twoLab];
        [twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(oenLab.mas_right).offset(5);
            make.centerY.equalTo(VVcont.mas_centerY);
            make.right.equalTo(VVcont.mas_right).offset(-5);
        }];
        
        UIButton *codBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 50*i, 178, 50)];
        codBtn.tag = i+2000;
        [codBtn addTarget:self action:@selector(codBtnClickMethod:) forControlEvents:UIControlEventTouchUpInside];
        [scrolV addSubview:codBtn];
        
    }
}

- (void)codBtnClickMethod:(UIButton *)btn
{
    UILabel *codst = [self viewWithTag:btn.tag-1000];
    if (self.eSelectBlock) {
        self.eSelectBlock(codst.text);
    }
}

@end
