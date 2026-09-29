//
//  MHfloatPlayView.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/28.
//

#import "MHfloatPlayView.h"

@interface MHfloatPlayView ()


@end
@implementation MHfloatPlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColor.whiteColor;
        
        self.DDDbtn = [HistoryRecordModel createImgImgView];
        self.DDDbtn.frame = CGRectMake(6, 6, 28, 28);
        self.DDDbtn.image = [UIImage imageNamed:@"float_all1"];
        [self addSubview:self.DDDbtn];
    }
    return self;
}

- (void)layoutSubviews
{
    self.DDDbtn.frame = CGRectMake(6, 6, 28, 28);
}

@end
