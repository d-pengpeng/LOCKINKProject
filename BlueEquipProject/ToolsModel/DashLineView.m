//
//  DashLineView.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/10/14.
//

#import "DashLineView.h"

@interface DashLineView ()

@property (nonatomic, assign)NSInteger lineLength;
@property (nonatomic, assign)NSInteger lineSpacing;
@property (nonatomic, strong)UIColor *lineColor;
@property (nonatomic, assign)CGFloat height;
@end
@implementation DashLineView

- (instancetype)initWithFrame:(CGRect)frame withLineLength:(NSInteger)lineLength withLineSpacing:(NSInteger)lineSpacing withLineColor:(UIColor *)lineColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _lineLength = lineLength;
        _lineSpacing = lineSpacing;
        _lineColor = lineColor;
        _height = frame.size.height;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGFloat lengths[] = {_lineLength,_lineSpacing};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0,_height);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

@end
