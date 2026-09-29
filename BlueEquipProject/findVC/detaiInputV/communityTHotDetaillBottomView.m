//
//  communityTHotDetaillBottomView.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/12/17.
//

#import "communityTHotDetaillBottomView.h"

@interface communityTHotDetaillBottomView ()

@end
@implementation communityTHotDetaillBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGB(247, 247, 247);
        
        self.rankBtn = [HistoryRecordModel createImgBtn];
        self.rankBtn.frame = CGRectMake(12, 9, _window_width-96, 36);
        self.rankBtn.layer.cornerRadius = 4;
        self.rankBtn.backgroundColor = UIColor.whiteColor;
        [self.rankBtn setTitle:eLocalizedString(@"fieldText_place") forState:UIControlStateNormal];
        [self.rankBtn setTitleColor:RGB(169, 169, 169) forState:UIControlStateNormal];
        self.rankBtn.titleLabel.font = SYS_Font(14);
        self.rankBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.rankBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        [self.rankBtn addTarget:self action:@selector(keyBoardBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rankBtn];
        
        self.collectBtn = [HistoryRecordModel createImgBtn];
        self.collectBtn.frame = CGRectMake(_window_width-60-12, 9, 60, 36);
        [self.collectBtn setBackgroundColor:normalPurpleColors];
        self.collectBtn.layer.cornerRadius = 4;
        [self.collectBtn setTitle:eLocalizedString(@"home_send") forState:UIControlStateNormal];
        [self.collectBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.collectBtn.titleLabel.font = SYS_Font(14);
        [self.collectBtn addTarget:self action:@selector(shareBtnMMMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.collectBtn];
        
    }
    return self;
}

- (void)shareBtnMMMethod
{
    if (self.block_) {
        self.block_(2);
    }
}

- (void)keyBoardBtnMethod
{
    if (self.block_) {
        self.block_(1);
    }
}

@end
