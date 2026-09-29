//
//  foundInformationView.m
//  Greens
//
//  东莞梦幻网络科技有限公司 注 on 2021/6/9.
//  Copyright © 2021 SoulZhou. All rights reserved.
//

#import "foundInformationView.h"
#import "UIView+Frame.h"

@interface foundInformationView ()

@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) NSMutableArray *mutArr;
@property (nonatomic, strong) NSMutableArray *mutBtnArr;
@property (nonatomic, strong) UIView *lineVV;
@property (nonatomic, assign) NSInteger arr_numL;
@end

@implementation foundInformationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = UIColor.clearColor;
        self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        self.scrollV.alwaysBounceVertical = NO;
        self.scrollV.alwaysBounceHorizontal = YES;
        self.scrollV.showsVerticalScrollIndicator = NO;
        self.scrollV.showsHorizontalScrollIndicator = NO;
        self.scrollV.bounces = NO;
        self.scrollV.backgroundColor = UIColor.clearColor;
        [self addSubview:self.scrollV];
        
    }
    return self;
}

- (void)addGuideTopTitleMethodDataToDic:(NSArray *)arrDics
{
    NSArray *arrns = arrDics;
    self.mutArr = [NSMutableArray array];
    self.mutBtnArr = [NSMutableArray array];
    
    for (int i=0; i<arrns.count; i++) {
        
        [self.mutArr addObject:arrns[i]];
    }
    
    CGFloat ww_all = 12.0;
    for (int i=0; i<self.mutArr.count; i++) {

        NSString *dicdic = self.mutArr[i];

        UIButton *one_btn = [self btnWithGuideTitle:dicdic];
        one_btn.frame = CGRectMake(ww_all, self.height-38, one_btn.width+30, 26);
        [one_btn addTarget:self action:@selector(oneBtnVGuideTopTitleMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollV addSubview:one_btn];
        one_btn.layer.cornerRadius = 13;
        if (i==0) {
            one_btn.selected = YES;
            one_btn.backgroundColor = normalColors;
        }else {
            one_btn.selected = NO;
            one_btn.backgroundColor = UIColor.whiteColor;
            one_btn.layer.borderColor = normalColors.CGColor;
            one_btn.layer.borderWidth = 1;
        }
        
        [self.mutBtnArr addObject:one_btn];
        ww_all = ww_all+one_btn.width+20;
    }
    self.scrollV.contentSize = CGSizeMake(ww_all, self.height);
}
- (void)changeGuideTitleXIndex:(NSInteger)num
{
    for (int i=0; i<self.mutBtnArr.count; i++) {
        UIButton *one_btn = self.mutBtnArr[i];
        if (i == num) {
            one_btn.selected = YES;
            one_btn.titleLabel.font = SYS_Font(16);
            one_btn.backgroundColor = normalColors;
            one_btn.layer.borderColor = UIColor.whiteColor.CGColor;
            one_btn.layer.borderWidth = 1;
            
            CGFloat ww_x = one_btn.x;
            CGFloat ww_w = one_btn.width;
            if(self.scrollV.contentSize.width > self.width) {
                if (ww_x+ww_w > self.width) {
                   
                    [self.scrollV setContentOffset:CGPointMake(ww_x+ww_w-self.width, 0) animated:YES];
                }else {
                    [self.scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
                }
            }else {
                [self.scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
            }
            
            if (self.block_) {
                self.block_(2, i);
            }
        }else {
            one_btn.selected = NO;
            one_btn.titleLabel.font = SYS_Font(14);
            one_btn.backgroundColor = UIColor.whiteColor;
            one_btn.layer.borderColor = normalColors.CGColor;
            one_btn.layer.borderWidth = 1;
        }
    }
}

- (void)oneBtnVGuideTopTitleMethod:(UIButton *)btn
{
    for (int i=0; i<self.mutBtnArr.count; i++) {
        UIButton *one_btn = self.mutBtnArr[i];
        if (btn == one_btn) {
            one_btn.selected = YES;
            one_btn.titleLabel.font = SYS_Font(16);
            one_btn.backgroundColor = normalColors;
            one_btn.layer.borderColor = UIColor.whiteColor.CGColor;
            one_btn.layer.borderWidth = 1;
            
            CGFloat ww_x = one_btn.x;
            CGFloat ww_w = one_btn.width;
            if(self.scrollV.contentSize.width > self.width) {
                if (ww_x+ww_w > self.width) {
                   
                    [self.scrollV setContentOffset:CGPointMake(ww_x+ww_w-self.width, 0) animated:YES];
                }else {
                    [self.scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
                }
            }else {
                [self.scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
            }
            
            if (self.block_) {
                self.block_(2, i);
            }
        }else {
            one_btn.selected = NO;
            one_btn.titleLabel.font = SYS_Font(14);
            one_btn.backgroundColor = UIColor.whiteColor;
            one_btn.layer.borderColor = normalColors.CGColor;
            one_btn.layer.borderWidth = 1;
        }
    }
}

- (UIButton *)btnWithGuideTitle:(NSString *)title {
    
    UIButton *labelBtn = [[UIButton alloc] init];
    [labelBtn setTitle:title forState:UIControlStateNormal];
    [labelBtn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    [labelBtn setTitleColor:normalColors forState:UIControlStateNormal];
    [labelBtn sizeToFit];
    labelBtn.titleLabel.font = SYS_Font(13);
    labelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    return labelBtn;
}

- (void)stopOrStartUIMehtod:(BOOL)isBoo
{
//    if(isBoo) {
//        for (UIButton *mmmBtn in self.mutBtnArr) {
//            [mmmBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
//            [mmmBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateSelected];
////            mmmBtn.userInteractionEnabled = NO;
//        }
//        self.lineVV.backgroundColor = RGB(170, 170, 170);
//    }else {
//        for (UIButton *mmmBtn in self.mutBtnArr) {
//            [mmmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//            [mmmBtn setTitleColor:normalColors forState:UIControlStateSelected];
//            mmmBtn.userInteractionEnabled = YES;
//        }
//        self.lineVV.backgroundColor = normalColors;
//    }
}

//MARK: 视频首页顶部 标题列表
- (void)addVIdeoTopTitleMethodDataToDic:(NSArray *)arrDics
{
    NSArray *arrns = arrDics;
    self.mutArr = [NSMutableArray array];
    self.mutBtnArr = [NSMutableArray array];
    
    for (int i=0; i<arrns.count; i++) {
        
        [self.mutArr addObject:arrns[i]];
    }
    
    self.lineVV = [HistoryRecordModel createLineViewUIUI];
    self.lineVV.backgroundColor = normalColors;
    [self.scrollV addSubview:self.lineVV];
    
    CGFloat ww_all = self.width/arrns.count;
    
    NSString *lang_en = [[SwichLanguage shareInstance] userLanguage];
    if ([lang_en isEqualToString:@"en"]) {
        
        CGFloat ww_allpt = 12.0;
        for (int i=0; i<self.mutArr.count; i++) {

            NSString *dicdic = self.mutArr[i];

            UIButton *one_btn = [self btnWithVideoTitle:dicdic];
            one_btn.frame = CGRectMake(ww_allpt, 5, one_btn.width+20, 30);
            [one_btn addTarget:self action:@selector(oneBtnVIdeoTopTitleMethod:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollV addSubview:one_btn];
  
            if (i==0) {
                one_btn.selected = YES;
                one_btn.titleLabel.font = SYS_Font(15);
                
                self.lineVV.frame = CGRectMake(ww_allpt+(one_btn.width-18)/2, 30, 18, 2);
            }else {
                one_btn.selected = NO;
                one_btn.titleLabel.font = SYS_Font(14);
            }
            
            [self.mutBtnArr addObject:one_btn];
            ww_allpt = ww_allpt+one_btn.width;
        }
        self.scrollV.contentSize = CGSizeMake(ww_allpt, self.height);
    }else {
        for (int i=0; i<self.mutArr.count; i++) {

            NSString *dicdic = self.mutArr[i];

            UIButton *one_btn = [self btnWithVideoTitle:dicdic];
            one_btn.frame = CGRectMake(i*ww_all, 5, ww_all, 30);
            [one_btn addTarget:self action:@selector(oneBtnVIdeoTopTitleMethod:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollV addSubview:one_btn];
            
            if (i==0) {
                one_btn.selected = YES;
                one_btn.titleLabel.font = SYS_Font(15);
                
                self.lineVV.frame = CGRectMake(ww_all/2-9, 30, 18, 2);
            }else {
                one_btn.selected = NO;
                one_btn.titleLabel.font = SYS_Font(14);
            }
            
            [self.mutBtnArr addObject:one_btn];

        }
    }
    
}

- (UIButton *)btnWithVideoTitle:(NSString *)title {
    
    UIButton *labelBtn = [[UIButton alloc] init];
    [labelBtn setTitle:title forState:UIControlStateNormal];
    [labelBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [labelBtn setTitleColor:normalColors forState:UIControlStateSelected];
    [labelBtn sizeToFit];
    labelBtn.titleLabel.font = SYS_Font(16);
    labelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    return labelBtn;
}

- (void)oneBtnVIdeoTopTitleMethod:(UIButton *)btn
{
//    if(self.isScrollBoo) {
//        return;
//    }
    
    NSString *lang_en = [[SwichLanguage shareInstance] userLanguage];
    if ([lang_en isEqualToString:@"en"]) {
        
        for (int i=0; i<self.mutBtnArr.count; i++) {
            UIButton *one_btn = self.mutBtnArr[i];
            if (btn == one_btn) {
                one_btn.selected = YES;
                one_btn.titleLabel.font = SYS_Font(15);
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.lineVV.x = one_btn.x+one_btn.width/2-9;
                }];
                
                if (self.block_) {
                    self.block_(2, i);
                }
            }else {
                one_btn.selected = NO;
                one_btn.titleLabel.font = SYS_Font(14);
            }
        }
    }else {
        CGFloat ww_all = self.width/self.mutBtnArr.count;
        for (int i=0; i<self.mutBtnArr.count; i++) {
            UIButton *one_btn = self.mutBtnArr[i];
            if (btn == one_btn) {
                one_btn.selected = YES;
                one_btn.titleLabel.font = SYS_Font(15);
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.lineVV.x = i*ww_all+ww_all/2-9;
                }];
                
                if (self.block_) {
                    self.block_(2, i);
                }
            }else {
                one_btn.selected = NO;
                one_btn.titleLabel.font = SYS_Font(14);
            }
        }
    }
    
}
    
- (void)changeVIdeoTopTitleXIndex:(NSInteger)num
{
    NSString *lang_en = [[SwichLanguage shareInstance] userLanguage];
    if ([lang_en isEqualToString:@"en"]) {
        
        for (int i=0; i<self.mutBtnArr.count; i++) {
            UIButton *one_btn = self.mutBtnArr[i];
            if (num == i) {
                one_btn.selected = YES;
                one_btn.titleLabel.font = SYS_Font(15);
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.lineVV.x = one_btn.x+one_btn.width/2-9;
                }];
            }else {
                one_btn.selected = NO;
                one_btn.titleLabel.font = SYS_Font(14);
            }
        }
    }else {
        CGFloat ww_all = self.width/self.mutBtnArr.count;
        for (int i=0; i<self.mutBtnArr.count; i++) {
            UIButton *one_btn = self.mutBtnArr[i];
            if (num == i) {
                one_btn.selected = YES;
                one_btn.titleLabel.font = SYS_Font(15);
                
                [UIView animateWithDuration:0.3 animations:^{
                    self.lineVV.x = i*ww_all+ww_all/2-9;
                }];
            }else {
                one_btn.selected = NO;
                one_btn.titleLabel.font = SYS_Font(14);
            }
        }
    }
}
    
@end
