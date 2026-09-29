//
//  MHfloatWHView.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/28.
//

#import "MHfloatWHView.h"

@implementation MHfloatWHView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = GrayTextColor;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *) touches withEvent:(UIEvent *)__unused event
{
    NSLog(@"tk-callBegan");
    UITouch *touch = touches.allObjects.firstObject;
    if (touch != nil) {
        self.lastPointInSelf = [touch locationInView:self];
        self.lastPointInSuperView = [self touchPointInScreen:touch];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *) touches withEvent:(UIEvent *)__unused event
{
    NSLog(@"tk-callMoved");

    UITouch *touch = touches.allObjects.firstObject;
    if (touch != nil) {
        CGPoint currentpoint = [self touchPointInScreen:touch];
        double halfWidth = self.superview.frame.size.width * 0.5;
        double halfHeight = self.superview.frame.size.height * 0.5;
        double centerX = currentpoint.x + (halfWidth - self.lastPointInSelf.x);
        double centerY = currentpoint.y + (halfHeight - self.lastPointInSelf.y);
        double x = MIN(UIScreen.mainScreen.bounds.size.width-halfWidth, MAX(centerX, halfWidth));
        double y = MIN(UIScreen.mainScreen.bounds.size.height - halfHeight, MAX(centerY, halfHeight));
        self.superview.center = CGPointMake(x, y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *) touches withEvent:(UIEvent *)__unused event
{
    
    UITouch *touch = touches.allObjects.firstObject;
    CGPoint currentpoint = [self touchPointInScreen:touch];
    if (CGPointEqualToPoint(self.lastPointInSuperView, currentpoint)) {
        NSLog(@"tk-callClick");
        
        if ([_delegate_ respondsToSelector:@selector(FloatingWViewDelegateMethod)]) {
            [_delegate_ FloatingWViewDelegateMethod];
        }
       
    }else {
        NSLog(@"tk-callEnded");
        CGSize screenSize = UIScreen.mainScreen.bounds.size;
        CGFloat left = currentpoint.x;
        CGFloat right = screenSize.width - currentpoint.x;
        CGFloat y = self.superview.center.y;
        y = MIN(screenSize.height - 100, MAX(y, 100));

        if (left <= right) {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(self.superview.bounds.size.width*0.5+6, y);
            }];
            
            if ([_delegate_ respondsToSelector:@selector(FloatingWViewDelegateMethodYyyy:isLeftRig:)]) {
                [_delegate_ FloatingWViewDelegateMethodYyyy:y isLeftRig:NO];
            }
        }else {
            [UIView animateWithDuration:0.3 animations:^{
                self.superview.center = CGPointMake(screenSize.width - self.superview.bounds.size.width*0.5-6, y);
            }];
            
            if ([_delegate_ respondsToSelector:@selector(FloatingWViewDelegateMethodYyyy:isLeftRig:)]) {
                [_delegate_ FloatingWViewDelegateMethodYyyy:y isLeftRig:YES];
            }
        }
    }
}

- (CGPoint)touchPointInScreen:(UITouch *)touch {

    return [self.superview convertPoint:[touch locationInView:self.superview] toCoordinateSpace:[[UIScreen mainScreen] coordinateSpace]];
}

@end
