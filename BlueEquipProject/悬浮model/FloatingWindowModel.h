//
//  FloatingWindowModel.h
//  DragonTeethLive
//
//  Created by Edwin on 2022/11/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^FloatingWindowModelBlock)(void);
@interface FloatingWindowModel : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong) NSArray *musicList;
@property (nonatomic, assign) BOOL isMusicPlay;
@property (nonatomic, assign) NSInteger musRow;
@property (nonatomic, assign) int timeL;
@property (nonatomic, assign) BOOL isEnableBluetooth;

@property (nonatomic, copy) NSString *id_id;
@property (nonatomic, assign) BOOL isPlayLis;

@property (nonatomic, copy) NSString *device_namL;//连接的设备名字

@property (nonatomic, strong) NSArray *bxMutArr; //二期开发 波形列表
@property (nonatomic, assign) NSInteger bx_row; //正在播放第几个

@property (nonatomic, strong) NSArray *devicNameArr; //二期开发 电鳗贞操锁 设备名列表
@property (nonatomic, strong) NSArray *devicNameArr3; //三期开发 马眼棒 设备名列表

// 设备7 记录控制页面数据
@property (nonatomic, assign) int JingDian_one_strong;//经典模式
@property (nonatomic, assign) int JingDian_one_model;
@property (nonatomic, assign) int JingDian_two_strong;
@property (nonatomic, assign) int JingDian_two_model;
@property (nonatomic, assign) int JingDian_thr;
@property (nonatomic, assign) int JingDian_thr_strong;
@property (nonatomic, assign) int JingDian_thr_strong2;

@property (nonatomic, assign) BOOL yaoyiyao_one; //摇一摇
@property (nonatomic, assign) BOOL yaoyiyao_two;
@property (nonatomic, assign) BOOL yaoyiyao_thr;

@property (nonatomic, assign) BOOL yuyin_play;//语音控制
@property (nonatomic, assign) BOOL yuyin_one;
@property (nonatomic, assign) BOOL yuyin_two;
@property (nonatomic, assign) BOOL yuyin_thr;

@property (nonatomic, assign) BOOL shoudong_one;//手动控制  电击
@property (nonatomic, assign) BOOL shoudong_two; //振动
@property (nonatomic, assign) int shoudong_oneStrong; //电击
@property (nonatomic, assign) int shoudong_twoStrong; //振动
@property (nonatomic, assign) int shoudong_oneStrongX; //电击
@property (nonatomic, assign) int shoudong_twoStrongX; //振动
@property (nonatomic, assign) int shoudong_model;

@property (nonatomic, assign) int boxing_play; //波形控制
@property (nonatomic, assign) NSInteger choose_numW; //设备7 记录退出时的界面




@property (nonatomic, strong) NSMutableArray *serviceArrs;
@property (nonatomic, strong) NSMutableArray *idArrs;
@property (nonatomic, strong) NSMutableArray *datasMut2;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, copy) NSString *macStMMM;
@property (nonatomic, copy) NSString *macStMMM2;
@property (nonatomic, copy) NSString *namStMMM;
@property (nonatomic, assign) BOOL bleLBooThr;//是否进入蓝牙连接界面
@property (nonatomic, assign) BOOL isWWWWBoo;
@property (nonatomic, copy) NSString *ElecStr;
@property (nonatomic, assign) BOOL bluetoothBtn_bo;



- (CGFloat)getStatusBarManagerHeighMehotd;
- (UIWindowScene *)getWindowSceneBarMehotd;


- (void)switchChatDetailControlNick:(NSString *)nick_name hostId:(NSString *)hostId;

- (void)switchGroupChatDetailControlNick:(NSString *)nick_name hostId:(NSString *)hostId;

//- (void)switchUserSpaceMangeDetailControlNick:(BOOL)boo_boo hostId:(NSString *)hostId blockMehtod:(FloatingWindowModelBlock)block_m;

- (void)switchFloatBFShow:(BOOL)boo Data:(NSArray *)arrLis row:(NSInteger)rowM second:(int)secondL sped:(NSInteger)spedRow isPlayList:(BOOL)isPlayLis idZ:(NSString *)id_id;

- (void)switchFloatBFHiddenMethod;
- (void)switchFloatBFMusicShow:(BOOL)boo;

- (void)uploadPlayListArr:(NSArray *)arrLis isPlay:(BOOL)isPPP idIII:(NSString *)id_MM;
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentViewController;
@end

NS_ASSUME_NONNULL_END
