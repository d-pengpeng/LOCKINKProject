//
//  floatingPlayLivingView.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/11/30.
//

#import "floatingPlayLivingView.h"

@interface floatingPlayLivingView ()

@end
@implementation floatingPlayLivingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)addImgName:(NSString *)imgN
{
    if(!self.imgVV) {
        self.imgVV = [HistoryRecordModel createImgImgView];
        self.imgVV.frame = CGRectMake(0, 0, self.width, self.height);
        self.imgVV.image = [UIImage imageNamed:imgN];
        [self addSubview:self.imgVV];
    }else {
        self.imgVV.image = [UIImage imageNamed:imgN];
    }
}

@end
