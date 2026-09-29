//
//  eTitleOrangeView.m
//  beijing
//
//  东莞梦幻网络科技有限公司 注 on 2020/9/11.
//  Copyright © 2020 zhou last. All rights reserved.
//

#import "eTitleOrangeView.h"

@implementation eTitleOrangeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat height_H = frame.size.height;
        _leftone = [[UIView alloc] initWithFrame:CGRectMake(15, (height_H-15)/2.0, 4, 15)];
        _leftone.backgroundColor = normalOrangeColors;
        [self addSubview:_leftone];
        
        _oneLab = [[UILabel alloc] initWithFrame:CGRectMake(30, (height_H-33)/2.0, _window_width-50, 33)];
        _oneLab.text = @"您的问题反馈标题？";
        _oneLab.textColor = GrayTextColor;
        _oneLab.font = SYS_Font(14);
        [self addSubview:_oneLab];
    }
    return self;
}

@end
