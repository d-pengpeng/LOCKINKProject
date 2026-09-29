//
//  FloatingWView.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/11/30.
//

#import "FloatingWView.h"

@interface FloatingWView ()

@property (nonatomic, assign) CGFloat max_fyyy;
@end

@implementation FloatingWView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        
        self.max_fyyy = _window_height-34-TARBARHEIGHT+49;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *) touches withEvent:(UIEvent *)__unused event
{
    UITouch *touch = touches.allObjects.firstObject;
    if (touch != nil) {
        self.lastPointInSelf = [touch locationInView:self];
        self.lastPointInSuperView = [self touchPointInScreen:touch];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *) touches withEvent:(UIEvent *)__unused event
{
    UITouch *touch = touches.allObjects.firstObject;
    if (touch != nil) {
        CGPoint currentpoint = [self touchPointInScreen:touch];
        
//        18002640725
        CGSize srWH = [UIScreen mainScreen].bounds.size;
        if((currentpoint.y >(self.y_boundary+30))&&(currentpoint.x < srWH.width-self.x_boundary-30)) {
            if((currentpoint.y < self.max_fyyy)&&(currentpoint.x>40)) {
                self.superview.center = CGPointMake(currentpoint.x, currentpoint.y);
                if(self.FloatingWVieweBLock) {
                    self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", currentpoint.x, currentpoint.y]);
                }
            }else {
                if(currentpoint.y < (self.y_boundary+30)) {
                    
                    CGFloat yy_yy = self.y_boundary+30;
                    if(currentpoint.x > srWH.width-self.x_boundary-30) {
                        
                        self.superview.center = CGPointMake(srWH.width-self.x_boundary-30, yy_yy);
                        if(self.FloatingWVieweBLock) {
                            self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", srWH.width-self.x_boundary-30, yy_yy]);
                        }
                    }else if (currentpoint.x < 40) {
                        self.superview.center = CGPointMake(40, yy_yy);
                        if(self.FloatingWVieweBLock) {
                            self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", 40.f, yy_yy]);
                        }
                    }else {
                        self.superview.center = CGPointMake(currentpoint.x, yy_yy);
                        if(self.FloatingWVieweBLock) {
                            self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", currentpoint.x, yy_yy]);
                        }
                    }
                }else if (currentpoint.y > self.max_fyyy) {
                    
                    CGFloat yy_yy = self.max_fyyy;
                    if(currentpoint.x > srWH.width-self.x_boundary-30) {
                        
                        self.superview.center = CGPointMake(srWH.width-self.x_boundary-30, yy_yy);
                        if(self.FloatingWVieweBLock) {
                            self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", srWH.width-self.x_boundary-30, yy_yy]);
                        }
                    }else if (currentpoint.x < 40) {
                        self.superview.center = CGPointMake(40, yy_yy);
                        if(self.FloatingWVieweBLock) {
                            self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", 40.f, yy_yy]);
                        }
                    }else {
                        self.superview.center = CGPointMake(currentpoint.x, yy_yy);
                        if(self.FloatingWVieweBLock) {
                            self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", currentpoint.x, yy_yy]);
                        }
                    }
                }else {

                    if(currentpoint.x > srWH.width-self.x_boundary-30) {
                        
                        self.superview.center = CGPointMake(srWH.width-self.x_boundary-30, currentpoint.y);
                        if(self.FloatingWVieweBLock) {
                            self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", srWH.width-self.x_boundary-30, currentpoint.y]);
                        }
                    }else if (currentpoint.x < 40) {
                        self.superview.center = CGPointMake(40, currentpoint.y);
                        if(self.FloatingWVieweBLock) {
                            self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", 40.f, currentpoint.y]);
                        }
                    }else {
                        self.superview.center = CGPointMake(currentpoint.x, currentpoint.y);
                        if(self.FloatingWVieweBLock) {
                            self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", currentpoint.x, currentpoint.y]);
                        }
                    }
                }
            }
        }else {
            
            if(currentpoint.y < (self.y_boundary+30)) {
                
                CGFloat yy_yy = self.y_boundary+30;
                if(currentpoint.x > srWH.width-self.x_boundary-30) {
                    
                    self.superview.center = CGPointMake(srWH.width-self.x_boundary-30, yy_yy);
                    if(self.FloatingWVieweBLock) {
                        self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", srWH.width-self.x_boundary-30, yy_yy]);
                    }
                }else if (currentpoint.x < 40) {
                    self.superview.center = CGPointMake(40, yy_yy);
                    if(self.FloatingWVieweBLock) {
                        self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", 40.f, yy_yy]);
                    }
                }else {
                    self.superview.center = CGPointMake(currentpoint.x, yy_yy);
                    if(self.FloatingWVieweBLock) {
                        self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", currentpoint.x, yy_yy]);
                    }
                }
            }else if (currentpoint.y > self.max_fyyy) {
                
                CGFloat yy_yy = self.max_fyyy;
                if(currentpoint.x > srWH.width-self.x_boundary-30) {
                    
                    self.superview.center = CGPointMake(srWH.width-self.x_boundary-30, yy_yy);
                    if(self.FloatingWVieweBLock) {
                        self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", srWH.width-self.x_boundary-30, yy_yy]);
                    }
                }else if (currentpoint.x < 40) {
                    self.superview.center = CGPointMake(40, yy_yy);
                    if(self.FloatingWVieweBLock) {
                        self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", 40.f, yy_yy]);
                    }
                }else {
                    self.superview.center = CGPointMake(currentpoint.x, yy_yy);
                    if(self.FloatingWVieweBLock) {
                        self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", currentpoint.x, yy_yy]);
                    }
                }
            }else {

                if(currentpoint.x > srWH.width-self.x_boundary-30) {
                    
                    self.superview.center = CGPointMake(srWH.width-self.x_boundary-30, currentpoint.y);
                    if(self.FloatingWVieweBLock) {
                        self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", srWH.width-self.x_boundary-30, currentpoint.y]);
                    }
                }else if (currentpoint.x < 40) {
                    self.superview.center = CGPointMake(40, currentpoint.y);
                    if(self.FloatingWVieweBLock) {
                        self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", 40.f, currentpoint.y]);
                    }
                }else {
                    self.superview.center = CGPointMake(currentpoint.x, currentpoint.y);
                    if(self.FloatingWVieweBLock) {
                        self.FloatingWVieweBLock([NSString stringWithFormat:@"%.f,%.f", currentpoint.x, currentpoint.y]);
                    }
                }
            }
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)__unused event
{
    UITouch *touch = touches.allObjects.firstObject;
    CGPoint currentpoint = [self touchPointInScreen:touch];
    if (CGPointEqualToPoint(self.lastPointInSuperView, currentpoint)) {

//        if ([_delegate_ respondsToSelector:@selector(FloatingWViewDelegateMethod)]) {
//            [_delegate_ FloatingWViewDelegateMethod];
//        }
    }else {
        if(self.FloatingWVieweBLock) {
            self.FloatingWVieweBLock(@"10000,10000");
        }
    }
}

- (void)uploadPointMM:(CGPoint)point
{
    self.superview.center = point;
}

- (CGPoint)touchPointInScreen:(UITouch *)touch {

    return [self.superview convertPoint:[touch locationInView:self.superview] toCoordinateSpace:[[UIScreen mainScreen] coordinateSpace]];
}

@end
