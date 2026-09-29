//
//  FloatingWindowModel.m
//  DragonTeethLive
//
//  Created by Edwin on 2022/11/26.
//

#import "FloatingWindowModel.h"
#import "c2cChatController.h"
#import "myGroupChatController.h"
#import "MHfloatWHController.h"

@interface FloatingWindowModel ()

@property (nonatomic, strong) MHfloatWHController *MHfloatWHC;
@end

@implementation FloatingWindowModel

+ (instancetype)shareInstance
{
    static FloatingWindowModel *giftRedEnv = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        giftRedEnv = [[FloatingWindowModel alloc] init];
    });
    
    return giftRedEnv;
}

- (NSMutableArray *)serviceArrs
{
    if (!_serviceArrs) {
        _serviceArrs = [NSMutableArray array];
    }
    return _serviceArrs;
}

- (NSMutableArray *)idArrs
{
    if (!_idArrs) {
        _idArrs = [NSMutableArray array];
    }
    return _idArrs;
}

- (NSMutableArray *)datasMut
{
    if (!_datasMut) {
        _datasMut = [NSMutableArray array];
    }
    return _datasMut;
}

- (NSMutableArray *)datasMut2
{
    if (!_datasMut2) {
        _datasMut2 = [NSMutableArray array];
    }
    return _datasMut2;
}


- (void)switchFloatBFShow:(BOOL)boo Data:(NSArray *)arrLis row:(NSInteger)rowM second:(int)secondL sped:(NSInteger)spedRow isPlayList:(BOOL)isPlayLis idZ:(NSString *)id_id
{
    self.isPlayLis = isPlayLis;
    self.id_id = id_id;
    if(boo) {
        self.MHfloatWHC = [[MHfloatWHController alloc] init];
        self.MHfloatWHC.isMusicPlay = NO;
        self.MHfloatWHC.pArrList = arrLis;
        self.MHfloatWHC.pRowL = rowM;
        self.MHfloatWHC.spedRow = spedRow;
        self.MHfloatWHC.playTNum = secondL;
        self.MHfloatWHC.isPlayLis = self.isPlayLis;
        self.MHfloatWHC.id_id = self.id_id;
        [self.MHfloatWHC showVC];
    }else {
        [self.MHfloatWHC dismissVCTwo];
        [self.MHfloatWHC dismissVC];
        self.MHfloatWHC = nil;
    }
}

- (void)switchFloatBFMusicShow:(BOOL)boo
{
    if(boo) {
        self.MHfloatWHC = [[MHfloatWHController alloc] init];
        self.MHfloatWHC.isMusicPlay = YES;
        [self.MHfloatWHC showVC];
    }else {
        [self.MHfloatWHC dismissVC];
        [self.MHfloatWHC dismissVCTwo];
        self.MHfloatWHC = nil;
    }
}

- (void)uploadPlayListArr:(NSArray *)arrLis isPlay:(BOOL)isPPP idIII:(NSString *)id_MM
{
    if(self.MHfloatWHC){
        if(self.isPlayLis == isPPP) {
            if([id_MM isEqualToString:self.id_id]) {
                self.MHfloatWHC.pArrList = arrLis;
            }
        }
    }
}

- (void)switchFloatBFHiddenMethod
{
    if(self.MHfloatWHC.isMusicPlay) {
        [self.MHfloatWHC dismissVCTwo];
    }else {
        [self.MHfloatWHC dismissVC];
    }
    self.MHfloatWHC = nil;
}

- (void)switchChatDetailControlNick:(NSString *)nick_name hostId:(NSString *)hostId
{
    c2cChatController *vc = [[c2cChatController alloc] init];
    vc.chatId = hostId;
    vc.showName = nick_name;
    UIViewController *nowVC = [self getCurrentViewController];
    [nowVC.navigationController pushViewController:vc animated:YES];
}

- (void)switchGroupChatDetailControlNick:(NSString *)nick_name hostId:(NSString *)hostId
{
    myGroupChatController *vc = [[myGroupChatController alloc] init];
    vc.chatId = hostId;
    vc.showName = nick_name;
    UIViewController *nowVC = [self getCurrentViewController];
    [nowVC.navigationController pushViewController:vc animated:YES];
}

//- (void)switchUserSpaceMangeDetailControlNick:(BOOL)boo_boo hostId:(NSString *)hostId blockMehtod:(nonnull FloatingWindowModelBlock)block_m
//{
//    mySpaceManagerController *vc = [[mySpaceManagerController alloc] init];
//    vc.user_idId = hostId;
//    UIViewController *nowVC = [self getCurrentViewController];
//    [nowVC.navigationController pushViewController:vc animated:YES];
//    vc.block_ = ^{
//
//        block_m();
//    };
//
//}

/*
 self.FloatingWC = [[FloatingWController alloc] init];
 self.FloatingWC.pullUr = pull_str;
 self.FloatingWC.delegate_ = self;
 [self.FloatingWC showVC];
 */


//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentViewControllerFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentViewControllerFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController])
    {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]])
    {
        // 根视图为UITabBarController
        currentVC = [self getCurrentViewControllerFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]])
    {
        // 根视图为UINavigationController
        currentVC = [self getCurrentViewControllerFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else
    {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}




- (CGFloat)getStatusBarManagerHeighMehotd
{
//    if (@available(iOS 15.0, *)) {
    
//        NSSet *setLL = [[UIApplication sharedApplication] connectedScenes];
//        UIWindowScene *windowSS = [setLL anyObject];
//        UIStatusBarManager *statusBarM = windowSS.statusBarManager;
//        return statusBarM.statusBarFrame.size.height;
//        
//    } else {
//        // Fallback on earlier versions
//        return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
//    }
    
    NSSet *setLL = [[UIApplication sharedApplication] connectedScenes];
    UIWindowScene *windowSS = [setLL anyObject];
    UIStatusBarManager *statusBarM = windowSS.statusBarManager;
    return statusBarM.statusBarFrame.size.height;
    
}

- (UIWindowScene *)getWindowSceneBarMehotd
{
    NSSet *setLL = [[UIApplication sharedApplication] connectedScenes];
    UIWindowScene *windowSS = [setLL anyObject];
    return windowSS;
}

@end
