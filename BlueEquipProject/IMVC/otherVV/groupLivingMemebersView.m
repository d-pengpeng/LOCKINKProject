//
//  groupLivingMemebersView.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/10/5.
//

#import "groupLivingMemebersView.h"

@interface groupLivingMemebersView ()<UIScrollViewDelegate>

@end

@implementation groupLivingMemebersView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIButton *deleteBtnV = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        deleteBtnV.backgroundColor = RGBA(0, 0, 0, 0.4);
        [deleteBtnV addTarget:self action:@selector(dleeteBtnMEthod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtnV];
        
        UIImageView *imgVV = [HistoryRecordModel createImgImgView];
        imgVV.image = [UIImage imageNamed:@"chat_imgs16"];
        [self addSubview:imgVV];
        [imgVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(5);
            make.centerY.equalTo(self.mas_centerY).offset(-50);
            make.width.offset(359);
            make.height.offset(377);
        }];
        
        self.oneVV = [[UIScrollView alloc] initWithFrame:CGRectMake((_window_width-354)/2, _window_height/2-129.5+9, 354, 259)];
        self.oneVV.backgroundColor = UIColor.clearColor;
        self.oneVV.bounces = NO;
        self.oneVV.showsVerticalScrollIndicator = NO;
        self.oneVV.showsHorizontalScrollIndicator = NO;
        self.oneVV.pagingEnabled = YES;
        self.oneVV.clipsToBounds = YES;
        self.oneVV.delegate = self;
        [self addSubview:self.oneVV];

        self.pageCC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.oneVV.frame)-20, _window_width, 20)];
        self.pageCC.currentPageIndicatorTintColor = RGB(227, 172, 114);
        self.pageCC.pageIndicatorTintColor = GrayText204;
        self.pageCC.userInteractionEnabled = NO;
        
        self.pageCC.currentPage = 0;
        [self addSubview:self.pageCC];
    }
    return self;
}

- (void)addMemebersArr:(NSArray *)arr
{
    [self.oneVV removeAllSubviews];
    
    if(arr.count/6>0) {
        if(arr.count%6>0) {
            self.pageCC.numberOfPages = 1+arr.count/6;
        }else {
            self.pageCC.numberOfPages = arr.count/6;
        }
        self.pageCC.hidden = NO;
    }else {
        self.pageCC.numberOfPages = 1;
        self.pageCC.hidden = YES;
    }
    
    self.oneVV.contentSize = CGSizeMake(351*2, 259);
    for (int i=0; i<arr.count; i++) {
        
        int x_x = i/2;
        int y_y = i%2;
        UIView *subVVV = [HistoryRecordModel createViewUIUI];
        subVVV.frame = CGRectMake(10+x_x*118, y_y*128, 98, 108);
        subVVV.backgroundColor = UIColor.clearColor;
        [self.oneVV addSubview:subVVV];
        
        NSDictionary *dicMM = arr[i];
        
        UIView *subsubV = [HistoryRecordModel createViewUIUI];
        subsubV.frame = CGRectMake(0, 23, 98, 85);
        [subVVV addSubview:subsubV];
        
        UIImageView *headIMgV = [HistoryRecordModel createImgImgView];
        headIMgV.frame = CGRectMake(26, 0, 46, 46);
        headIMgV.image = normal_placeHeadImg;
        headIMgV.layer.cornerRadius = 23;
        [subVVV addSubview:headIMgV];
        [headIMgV sd_setImageWithURL:[NSURL URLWithString:minStr(dicMM[@"avatar"])] placeholderImage:normal_placeHeadImg];
        
        UILabel *nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        nickLab.frame = CGRectMake(4, 46, 90, 32);
        nickLab.text = minStr(dicMM[@"user_nickname"]);
        [subVVV addSubview:nickLab];
        
        UIButton *zbzBtn = [HistoryRecordModel createImgBtn];
        zbzBtn.frame = CGRectMake(11, 80, 76, 24);
        [zbzBtn setImage:[UIImage imageNamed:@"chat_imgs17"] forState:UIControlStateNormal];
        [zbzBtn setTitle:eLocalizedString(@"ranking_living") forState:UIControlStateNormal];
        [zbzBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        zbzBtn.titleLabel.font = SYS_Font(12);
        zbzBtn.backgroundColor = RGB(227, 172, 114);
        zbzBtn.layer.cornerRadius = 12;
        zbzBtn.tag = 8700+i;
        [zbzBtn addTarget:self action:@selector(zbzBtnMethodType:) forControlEvents:UIControlEventTouchUpInside];
        [subVVV addSubview:zbzBtn];
    }
}

- (void)zbzBtnMethodType:(UIButton *)btn
{
    if(self.block_) {
        self.block_(btn.tag-8700);
    }
    [self removeFromSuperview];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int dd_num = scrollView.contentOffset.x/340;
    self.pageCC.currentPage = dd_num;
}

- (void)dleeteBtnMEthod
{
    [self removeFromSuperview];
}

@end
