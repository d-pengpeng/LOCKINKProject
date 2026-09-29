//
//  noDataImgView.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/12/31.
//

#import "noDataImgView.h"

@interface noDataImgView ()

@property (nonatomic, strong) UILabel *msgLab;
@end
@implementation noDataImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *back_imgV = [HistoryRecordModel createImgImgView];
        back_imgV.frame = CGRectMake((self.width-150)/2.0f, (self.height-100)/2.0f-60, 150, 100);
        back_imgV.image = [UIImage imageNamed:@"noDataPlaceImg"];
        [self addSubview:back_imgV];
        
        self.msgLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:16 textAlignment:NSTextAlignmentCenter];
        self.msgLab.text = eLocalizedString(@"noData_msg1");
        [self addSubview:self.msgLab];
        [self.msgLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-20);
            make.top.equalTo(back_imgV.mas_bottom).offset(20);
        }];
        
    }
    return self;
}

- (void)settingMsgLab:(NSString *)msg_str
{
    self.msgLab.text = msg_str;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitVV = [super hitTest:point withEvent:event];
    if (hitVV == self) {
        return nil;
    }
    return hitVV;
}

@end
