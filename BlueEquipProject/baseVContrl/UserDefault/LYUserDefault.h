//
//  LYUserDefault.h
//  DragonTeethLive
//
//  Created by Edwin on 2021/11/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUserDefault : NSObject

@property (nonatomic ,copy) NSString *t_id;
@property (nonatomic ,copy) NSString *sex;
@property (nonatomic ,copy) NSString *placeOfOrigin;
@property (nonatomic ,copy) NSString *bg_img;

@property (nonatomic ,copy) NSString *user_nickname;
@property (nonatomic ,copy) NSString *avatar;
@property (nonatomic ,copy) NSString *mobile;
@property (nonatomic ,copy) NSString *votestotal;
@property (nonatomic ,copy) NSString *exp;
@property (nonatomic ,copy) NSString *votestotal_icon;
@property (nonatomic ,copy) NSString *exp_icon;
@property (nonatomic ,copy) NSString *withdrawal_balance;
@property (nonatomic ,copy) NSString *freeze_balance;
@property (nonatomic ,assign) BOOL is_guard;
@property (nonatomic ,assign) BOOL is_defray_pass;
@property (nonatomic ,copy) NSString *signature;
//贵族
@property (nonatomic ,assign) int guard_id;
@property (nonatomic ,copy) NSString *guard_endtime;
@property (nonatomic ,assign) int guard_list_order;
@property (nonatomic ,assign) int guard_color_level;
@property (nonatomic ,copy) NSString *guard_name;
@property (nonatomic ,copy) NSString *guard_icon;
@property (nonatomic ,copy) NSString *guard_swf;
@property (nonatomic ,copy) NSString *guard_swf_name;

@property (nonatomic ,copy) NSString *default_avatar;

@property (nonatomic ,assign) NSInteger barrageTypeSmallBig;
@property (nonatomic ,assign) NSInteger barrageTypeType;
@property (nonatomic ,assign) NSInteger barrageTypeAlph;
@property (nonatomic ,assign) NSInteger barrageTextColorType;
@property (nonatomic ,assign) NSInteger barrageTextVipType;
@property (nonatomic ,assign) BOOL isFloating;

@property (nonatomic ,assign) BOOL is_showRedYellow;
@property (nonatomic ,assign) BOOL is_joinballVoice;
@property (nonatomic ,assign) BOOL is_joinballVibration;
@property (nonatomic ,assign) BOOL is_redcardVoice;
@property (nonatomic ,assign) BOOL is_redcardVibration;
@property (nonatomic ,assign) BOOL sealing;

@property (nonatomic ,assign) BOOL iosMandatoryUpdateSandbox;
@property (nonatomic ,copy) NSString *iosVersionNumber;
@property (nonatomic ,copy) NSString *iosDownloadUrl;
@property (nonatomic ,copy) NSString *iosDownloadText;
@property (nonatomic ,copy) NSString *QiNiuDomain;

@property (nonatomic ,copy) NSString *announcement;
@property (nonatomic ,copy) NSString *websocket;
@property (nonatomic ,copy) NSString *CustomerService;

@property (nonatomic ,copy) NSString *timeSignUser;
@property (nonatomic ,copy) NSString *timeSignUser_box;
@property (nonatomic ,assign) NSInteger timebox_min;
@property (nonatomic ,assign) NSInteger timebox_sec;

@property (nonatomic ,assign) BOOL is_EnterBackground;

@property (nonatomic ,assign) NSInteger difference;
@property (nonatomic ,assign) NSInteger current_exp;
@property (nonatomic ,assign) int clearNum_host;

@property (nonatomic ,copy) NSString *user_agreement;
@property (nonatomic ,copy) NSString *privacy_policy;
@property (nonatomic ,copy) NSString *h5_url;
@property (nonatomic ,copy) NSString *live_notice;
@property (nonatomic ,copy) NSString *verify_status;
@property (nonatomic ,copy) NSString *roomnum;
@property (nonatomic ,copy) NSString *hostAnnouncement;
@property (nonatomic ,copy) NSString *long_id;
@property (nonatomic ,copy) NSString *type_id;
@property (nonatomic ,copy) NSString *expires_time;
@property (nonatomic ,copy) NSString *invite_gift_description;

@property (nonatomic ,copy) NSString *agent_num;
@property (nonatomic ,copy) NSString *purchase_num;
@property (nonatomic ,assign) NSInteger vip_rank;
@property (nonatomic ,assign) NSInteger order_num;
@property (nonatomic, assign) BOOL is_show;
@property (nonatomic,copy) NSString *registration_type;

@property (nonatomic, assign) BOOL open_anchor_apply;
@property (nonatomic, assign) BOOL open_auction_settings;

@property (nonatomic,copy) NSString *im_url;
@property (nonatomic,copy) NSString *im_group_url;

@property (nonatomic,copy) NSString *Lucky_box_url;
@property (nonatomic,copy) NSString *charity_url;


@property (nonatomic, assign) BOOL isLoginBoo;
@property (nonatomic, copy) NSString *musicSelNum;
@property (nonatomic ,assign) NSInteger play_type;

@property (nonatomic, assign) BOOL isScreenAwake;
@property (nonatomic, assign) BOOL isSetLock;
@property (nonatomic, assign) BOOL isSetLockDisable;
@property (nonatomic, copy) NSString *eSecurityCode;
@property (nonatomic, assign) BOOL play_start;

@property (nonatomic, copy) NSString *emailAuccount;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *intro;
@property (nonatomic, copy) NSString *region;
@property (nonatomic ,assign) NSInteger user_age;
@property (nonatomic, copy) NSString *imUserSig;

@property (nonatomic ,assign) NSInteger plist_id;
@property (nonatomic, copy) NSString *macName;
@property (nonatomic, copy) NSString *macElec;

@property (nonatomic ,assign) BOOL isFirstStart;
@property (nonatomic ,assign) NSInteger isPEmail;

@property (nonatomic, strong) NSArray *countries_Arr;

@property (nonatomic, strong) NSArray *dayArr;
@property (nonatomic, strong) NSArray *hourArr;
@property (nonatomic, strong) NSArray *mineArr;

@property (nonatomic, strong) NSArray *CountryCode;
@property (nonatomic, strong) NSArray *adListArr;

@property (nonatomic, copy) NSString *tmpSecretId;
@property (nonatomic, copy) NSString *tmpSecretKey;
@property (nonatomic, copy) NSString *sessionToken;
@property (nonatomic, assign) double startTime;
@property (nonatomic, copy) NSString *macId;

@property (nonatomic, assign) BOOL isDomestic;
@property (nonatomic, assign) NSInteger msgRed_start;
@property (nonatomic, assign) NSInteger msgRed_start2;
@property (nonatomic, copy) NSString *privacyPolicyUrl;
@property (nonatomic, copy) NSString *userAgreementUrl;
@property (nonatomic, copy) NSString *JG_RegisterId;
@property (nonatomic, copy) NSString *kefuId;

@property (nonatomic, assign) BOOL isFirstLogin1;

+ (LYUserDefault *)userDefault;

+ (void)saveisFirstLogin1:(BOOL)isbfff;

+ (void)saveUserRegisterId:(NSString *)url;
+ (void)saveKefuId:(NSString *)kefuId;

+ (void)saveQCloudDic:(NSDictionary *)dicT;
+ (void)savePrivacyOrUserDic:(NSDictionary *)dicT;
+ (void)saveMacId:(NSString *)elec;

+ (void)saveMsgNoRedStart:(NSInteger)TypeL;
+ (void)saveMsgNoRedStart2:(NSInteger)TypeL;

+ (void)saveCountiesArr:(NSArray *)arrs;
+ (void)saveCountryCodeArr:(NSArray *)arrs;
+ (void)saveAdListArr:(NSArray *)arrs;

+ (void)saveIsEmailBoo:(NSInteger)isShow;

+ (void)saveMacName:(NSString *)mac;
+ (void)saveMacElec:(NSString *)elec;

+ (void)saveEmailAuccount:(NSString *)email;
+ (void)saveUIimUserSig:(NSString *)email;

+ (void)saveUIPlist_idStr:(NSInteger)pNum;

//保存登录信息
+ (void)saveUserLoginDefault:(NSDictionary *)dicT;
+ (void)saveUserDefault:(NSDictionary *)dicT;

+ (void)savePlayType:(NSInteger)TypeL;

+(void)saveScreenAwake:(BOOL)boo;
+(void)saveSetLock:(BOOL)boo;
+(void)saveSetLockDisable:(BOOL)boo;
+(void)saveeSecurityCode:(NSString *)name;

+ (void)savePlayStart:(BOOL)TypeL;

+(void)saveMusicSelNum:(NSString *)name;

+ (void)saveIsLoginBoo:(BOOL)isShow;

+ (void)saveIsEnterBackground:(BOOL)isShow;

+ (void)saveIsRoomnum:(NSString *)isShow hostAnnoun:(NSString *)announ;

+ (void)saveIsSealing:(BOOL)isShow;

+ (void)clearLoginCache;

+ (void)saveUserClearNum:(int)clearNum;

+ (void)saveTimeSignUser:(NSString *)dateStr;
+ (void)saveTimeSignUserBox:(NSString *)dateStr;
+ (void)saveTimeBoxMin:(NSInteger)dateStr;
+ (void)saveTimeBoxSec:(NSInteger)dateStr;


+ (void)saveUserQiNiuDomain:(NSString *)url;


+ (void)saveUserAvator:(NSString *)url;

+ (void)saveUserNickName:(NSString *)url;

+ (void)saveUserSignature:(NSString *)url;

+ (void)saveUserMobilePhone:(NSString *)url;


+ (void)saveIsFirstStart:(BOOL)isShow;


@end

NS_ASSUME_NONNULL_END
