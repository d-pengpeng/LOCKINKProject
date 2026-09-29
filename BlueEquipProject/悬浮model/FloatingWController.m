//
//  FloatingWController.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/11/30.
//

#import "FloatingWController.h"
#import "FloatingWView.h"
#import "floatingPlayLivingView.h"

@interface FloatingWController ()

@property (nonatomic, strong) FloatingWView *FloatingWV;
@property (nonatomic, strong) floatingPlayLivingView *floatingPlayLivingV;

@end

@implementation FloatingWController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.clearColor;
    
//    self.FloatingWV = [[FloatingWView alloc] initWithFrame:CGRectMake(50, 260, 62, 62)];
    self.FloatingWV = [[FloatingWView alloc] initWithFrame:CGRectMake(50, 260, 44, 44)];
    self.FloatingWV.clipsToBounds = YES;
    self.FloatingWV.layer.cornerRadius = 22;
    [self.view addSubview:self.FloatingWV];
    WEAKSELF
    self.FloatingWV.FloatingWVieweBLock = ^(NSString * _Nonnull strLLLL) {
        
        __strong __typeof(self)self = weakSelf;
        if(self.FloatingWCCCCVieweBLock) {
            self.FloatingWCCCCVieweBLock(strLLLL);
        }
    };
    
    self.floatingPlayLivingV = [[floatingPlayLivingView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    self.floatingPlayLivingV.backgroundColor = UIColor.clearColor;
    [self.FloatingWV addSubview:self.floatingPlayLivingV];
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(moveCollectionViewCell)];
    [self.floatingPlayLivingV addGestureRecognizer:longPress];
}

- (void)moveCollectionViewCell
{
//    长按分开
    if(self.block_) {
        self.block_();
    }
}

- (void)botmUIUIUBoo:(BOOL)booM
{
    if(booM) {
        CGSize srWH = [UIScreen mainScreen].bounds.size;
        self.view.frame = CGRectMake(self.x_lef, srWH.height-54-TARBARHEIGHT+49, 44, 44);
        self.FloatingWV.frame = self.view.bounds;
        [self.view addSubview:self.FloatingWV];
    }
}

- (void)clearUIVC
{
    [self.FloatingWV removeFromSuperview];
    [self.view removeAllSubviews];
}

- (void)hiddenShowMMmehtodUIUIBoo:(BOOL)isbb
{
    self.FloatingWV.hidden = isbb;
}

- (void)showVC {
    
    CGSize srWH = [UIScreen mainScreen].bounds.size;
    self.view.frame = CGRectMake(self.x_lef, srWH.height-54-TARBARHEIGHT+49, 44, 44);
    [self.selfVVC.view addSubview:self.view];
    [self.selfVVC.view bringSubviewToFront:self.view];
    self.view.userInteractionEnabled = YES;
    self.FloatingWV.userInteractionEnabled = YES;
    self.FloatingWV.frame = self.view.bounds;
    [self.view addSubview:self.FloatingWV];
    self.floatingPlayLivingV.frame = self.FloatingWV.bounds;

    self.FloatingWV.x_lef = self.x_lef;
    self.FloatingWV.x_boundary = self.x_boundary;
    self.FloatingWV.y_boundary = self.y_boundary;
    [self.floatingPlayLivingV addImgName:self.imgName];
}

- (void)showVCTwoMethod
{
    CGSize srWH = [UIScreen mainScreen].bounds.size;
    self.view.frame = CGRectMake(self.x_lef, srWH.height-54-TARBARHEIGHT+49, 44, 44);
    [self.selfVVC.view addSubview:self.view];
    [self.selfVVC.view bringSubviewToFront:self.view];
    self.view.userInteractionEnabled = YES;
    self.FloatingWV.userInteractionEnabled = YES;
    self.FloatingWV.frame = self.view.bounds;
    [self.view addSubview:self.FloatingWV];
    self.floatingPlayLivingV.frame = self.FloatingWV.bounds;
    
    self.FloatingWV.x_lef = self.x_lef;
    self.FloatingWV.x_boundary = self.x_boundary;
    self.FloatingWV.y_boundary = self.y_boundary;
    [self.floatingPlayLivingV addImgName:self.imgName];
}

- (void)uploadPointMethod:(CGPoint)pointS img:(nonnull NSString *)imgNam
{
    [self.floatingPlayLivingV addImgName:imgNam];
    [self.FloatingWV uploadPointMM:pointS];
}

- (void)uploadPointFiveSevenMethod:(CGPoint)pointS
{
    [self.FloatingWV uploadPointMM:pointS];
}

- (void)uploadImgMEhodname:(NSString *)img
{
    [self.floatingPlayLivingV addImgName:img];
}

@end
