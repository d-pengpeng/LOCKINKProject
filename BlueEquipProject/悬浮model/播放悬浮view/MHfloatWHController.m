//
//  MHfloatWHController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/28.
//

#import "MHfloatWHController.h"
#import "MHfloatWHView.h"
#import "MHfloatPlayView.h"
#import "MHfloatShowView.h"
#import "musicWindowModel.h"

@interface MHfloatWHController ()<MHfloatWHViewwDelegate, MHfloatPlayViewwDelegate>
{
    NSTimer *timeLL;
}
@property (nonatomic, strong) musicWindowModel *playerModel;
@property (nonatomic, strong) MHfloatWHView *FloatingWV;
@property (nonatomic, strong) MHfloatPlayView *floatingPlayLivingV;
@property (nonatomic, strong) MHfloatShowView *MHfloatShowV;
@property (nonatomic, strong) FloatingWindowModel *floatMode;

@property (nonatomic, assign) CGFloat y_yy;
@property (nonatomic, assign) BOOL isLefR;
@end

@implementation MHfloatWHController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    self.playerModel = [musicWindowModel shareInstance];
    self.floatMode = [FloatingWindowModel shareInstance];
    
    self.view.backgroundColor = UIColor.clearColor;
    
    CGSize srWH = [UIScreen mainScreen].bounds.size;
    self.FloatingWV = [[MHfloatWHView alloc] initWithFrame:CGRectMake(srWH.width, srWH.height/3.0f, 40, 40)];
    self.FloatingWV.delegate_ = self;
    self.FloatingWV.layer.cornerRadius = 20;
    self.FloatingWV.clipsToBounds = true;
    [self.view addSubview:self.FloatingWV];
    
    self.floatingPlayLivingV = [[MHfloatPlayView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.floatingPlayLivingV.delegate_ = self;
    self.floatingPlayLivingV.pullUr = self.pullUr;
    [self.FloatingWV addSubview:self.floatingPlayLivingV];
    
    self.y_yy = srWH.height/3.0f;
    self.isLefR = YES;
}

- (void)FloatingWViewDelegateMethodYyyy:(CGFloat)y_y isLeftRig:(BOOL)isLefRig
{
    self.y_yy = y_y;
    self.isLefR = isLefRig;
}

- (void)FloatingWViewDelegateMethod
{
//    [self.floatingPlayLivingV addStopPull];
//    if ([self.delegate_ respondsToSelector:@selector(FloatingWCCDelegateFloatingWindowHidden)]) {
//        [self.delegate_ FloatingWCCDelegateFloatingWindowHidden];
//    }
//    [self dismissVC];
    if(self.isMusicPlay) {
        if(!self.MHfloatShowV) {
            self.MHfloatShowV = [[MHfloatShowView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height) isMusicPlay:YES];
        }
        [self.MHfloatShowV uploadYyy:self.y_yy LeftRig:self.isLefR];
        [[UIApplication sharedApplication].windows.firstObject addSubview:self.MHfloatShowV];
        [[UIApplication sharedApplication].windows.firstObject bringSubviewToFront:self.MHfloatShowV];
        self.MHfloatShowV.block_ = ^(NSInteger typeL, BOOL isBoo) {
            if(typeL == 1) {
                [self dismissVCMM:isBoo];
            }else if (typeL == 3) {
                self.MHfloatShowV.hidden = YES;
            }
        };
        self.MHfloatShowV.hidden = NO;
    }else {
        if(!self.MHfloatShowV) {
            self.MHfloatShowV = [[MHfloatShowView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height) ArrLis:self.pArrList rowL:self.pRowL playT:self.playTNum sped:self.spedRow];
        }
        self.MHfloatShowV.pArrList = self.pArrList;
        self.MHfloatShowV.pRowL = self.pRowL;
        self.MHfloatShowV.playTNum = self.playTNum;
        self.MHfloatShowV.isPlayLis = self.isPlayLis;
        self.MHfloatShowV.id_id = self.id_id;
        [self.MHfloatShowV uploadYyy:self.y_yy LeftRig:self.isLefR];
        [[UIApplication sharedApplication].windows.firstObject addSubview:self.MHfloatShowV];
        [[UIApplication sharedApplication].windows.firstObject bringSubviewToFront:self.MHfloatShowV];
        self.MHfloatShowV.block_ = ^(NSInteger typeL, BOOL isBoo) {
            if(typeL == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"0", @"strong":@"0", @"strong2":@"0"}];
                [self dismissVC];
            }else if (typeL == 3) {
                self.MHfloatShowV.hidden = YES;
            }
        };
        self.MHfloatShowV.hidden = NO;
    }
}
- (void)floatingPlayLivingViewDelegateDeleteMethod
{
//    [self dismissVC];
    self.view.alpha = 0.0f;
    [self.view removeFromSuperview];
}

- (void)showVC {
    
    CGSize srWH = [UIScreen mainScreen].bounds.size;
    self.view.frame = CGRectMake(srWH.width, 0, srWH.width, srWH.height);
//    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    [[UIApplication sharedApplication].windows.firstObject addSubview:self.view];
    [[UIApplication sharedApplication].windows.firstObject bringSubviewToFront:self.view];
    
    [UIView animateWithDuration:0.3 animations:^{

        self.view.frame = CGRectMake(0, 0, srWH.width, srWH.height);
    } completion:^(BOOL finished) {
        if (finished) {
            self.view.frame = CGRectMake(0, 0, srWH.width, srWH.height);
        }
        [self MMMMMM];
        [self yjzUIUIUIUIUI];
    }];
}

- (void)MMMMMM
{
    CGSize srWH = [UIScreen mainScreen].bounds.size;
    self.view.frame = CGRectMake(0, 0, srWH.width, srWH.height);
    
    self.view.userInteractionEnabled = YES;
    self.FloatingWV.userInteractionEnabled = YES;
    [UIView animateWithDuration:0.6 animations:^{
        
        self.view.frame = CGRectMake(srWH.width-46, srWH.height/3.0f, 40, 40);
        self.FloatingWV.frame = self.view.bounds;
        self.floatingPlayLivingV.frame = self.FloatingWV.bounds;
        
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];

}

- (void)yjzUIUIUIUIUI
{
    if(self.isMusicPlay) {
        if(!self.MHfloatShowV) {
            self.MHfloatShowV = [[MHfloatShowView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height) isMusicPlay:YES];
        }
        [self.MHfloatShowV uploadYyy:self.y_yy LeftRig:self.isLefR];
        [[UIApplication sharedApplication].windows.firstObject addSubview:self.MHfloatShowV];
        [[UIApplication sharedApplication].windows.firstObject bringSubviewToFront:self.MHfloatShowV];
        self.MHfloatShowV.hidden = YES;
    }else {
        if(!self.MHfloatShowV) {
            self.MHfloatShowV = [[MHfloatShowView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height) ArrLis:self.pArrList rowL:self.pRowL playT:self.playTNum sped:self.spedRow];
        }
        self.MHfloatShowV.pArrList = self.pArrList;
        self.MHfloatShowV.pRowL = self.pRowL;
        self.MHfloatShowV.playTNum = self.playTNum;
        self.MHfloatShowV.isPlayLis = self.isPlayLis;
        self.MHfloatShowV.id_id = self.id_id;
        [self.MHfloatShowV uploadYyy:self.y_yy LeftRig:self.isLefR];
        [[UIApplication sharedApplication].windows.firstObject addSubview:self.MHfloatShowV];
        [[UIApplication sharedApplication].windows.firstObject bringSubviewToFront:self.MHfloatShowV];
        self.MHfloatShowV.hidden = YES;
    }
}

- (void)dismissVC {
 
    if(self.isMusicPlay) {
        [self.MHfloatShowV ddBBMethodsThrBoo:YES];
    }else {
        [self.MHfloatShowV ddBBMethodsTwoMMMMM];
    }
    [timeLL invalidate];
    timeLL = nil;
    self.view.alpha = 0.0f;
    [self.view removeFromSuperview];
   
}

- (void)dismissVCTwo {

    if(!self.MHfloatShowV) {
        if(self.isMusicPlay) {
            self.floatMode.isMusicPlay = NO;
            [self.playerModel stopPlayNoVoiceMP3];
        }
    }else {
        [self.MHfloatShowV ddBBMethodsThrBoo:NO];
    }
    [timeLL invalidate];
    timeLL = nil;
    self.view.alpha = 0.0f;
    [self.view removeFromSuperview];
   
}

- (void)dismissVCMM:(BOOL)boo {
    if(boo) {
        
    }else {
        
    }
    [timeLL invalidate];
    timeLL = nil;
    self.view.alpha = 0.0f;
    [self.view removeFromSuperview];
   
}

@end
