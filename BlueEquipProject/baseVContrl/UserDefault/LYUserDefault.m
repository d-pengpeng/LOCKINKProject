//
//  LYUserDefault.m
//  DragonTeethLive
//
//  Created by Edwin on 2021/11/27.
//

#import "LYUserDefault.h"

@implementation LYUserDefault

+ (LYUserDefault *)userDefault
{
    LYUserDefault *userD = [LYUserDefault new];
    return userD;
}

+ (void)clearLoginCache
{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"sex_sex"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"user_nickname"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"user_avatar"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"AppToken"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"imUserSig"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoginBoo"];
}

+ (void)saveQCloudDic:(NSDictionary *)cloudDic
{
    [[NSUserDefaults standardUserDefaults] setValue:minStr(cloudDic[@"tmpSecretId"]) forKey:@"tmpSecretId"];
    [[NSUserDefaults standardUserDefaults] setValue:minStr(cloudDic[@"tmpSecretKey"]) forKey:@"tmpSecretKey"];
    [[NSUserDefaults standardUserDefaults] setValue:minStr(cloudDic[@"sessionToken"]) forKey:@"sessionToken"];
    [[NSUserDefaults standardUserDefaults] setDouble:[minStr(cloudDic[@"startTime"]) doubleValue] forKey:@"startTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveUserRegisterId:(NSString *)url
{
    [[NSUserDefaults standardUserDefaults] setValue:url forKey:@"JG_RegistID"];
}

- (NSString *)JG_RegisterId
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"JG_RegistID"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"JG_RegistID"];
    }else {
        return @"";
    }
}

+ (void)saveKefuId:(NSString *)kefuId
{
    [[NSUserDefaults standardUserDefaults] setValue:kefuId forKey:@"kefuId"];
}

- (NSString *)kefuId
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"kefuId"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"kefuId"];
    }else {
        return @"";
    }
}

- (NSString *)tmpSecretKey
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"tmpSecretKey"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"tmpSecretKey"];
    }else {
        return @"";
    }
}

- (NSString *)sessionToken
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"sessionToken"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionToken"];
    }else {
        return @"";
    }
}

- (double)startTime
{
    if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"startTime"]) {
        return [[NSUserDefaults standardUserDefaults] doubleForKey:@"startTime"];
    }else {
        return 0;
    }
}

- (NSString *)tmpSecretId
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"tmpSecretId"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"tmpSecretId"];
    }else {
        return @"";
    }
}

+ (void)saveCountiesArr:(NSArray *)arrs
{
    [[NSUserDefaults standardUserDefaults] setValue:arrs forKey:@"countriesArr"];
}

+ (void)saveCountryCodeArr:(NSArray *)arrs
{
    [[NSUserDefaults standardUserDefaults] setValue:arrs forKey:@"CountryCode"];
}

- (NSArray *)countries_Arr
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"countriesArr"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"countriesArr"];
    }else {
        return @[];
    }
}

+ (void)saveisFirstLogin1:(BOOL)isbfff
{
    [[NSUserDefaults standardUserDefaults] setBool:isbfff forKey:@"isFirstLogin1"];
}

- (BOOL)isFirstLogin1
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstLogin1"];
}

+ (void)saveAdListArr:(NSArray *)arrs
{
    [[NSUserDefaults standardUserDefaults] setValue:arrs forKey:@"adList"];
}

- (NSArray *)adListArr
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"adList"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"adList"];
    }else {
        return @[];
    }
}

- (NSArray *)dayArr
{
    return @[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14"];
}

- (NSArray *)hourArr
{
    return @[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23"];
}

- (NSArray *)mineArr
{
    return @[@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", @"60"];
}

+ (void)saveMacName:(NSString *)mac
{
    [[NSUserDefaults standardUserDefaults] setValue:mac forKey:@"macName"];
}

- (NSString *)macName
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"macName"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"macName"];
    }else {
        return @"";
    }
}

+ (void)savePrivacyOrUserDic:(NSDictionary *)dicT
{
    NSString *langStr = [[SwichLanguage shareInstance] userLanguage];
    NSString *lang_new = @"en";
    if ([langStr hasPrefix:@"zh"]) {
    
        lang_new = @"zh";
    }else {
        lang_new = @"en";
    }
    [LYUserDefault saveMacId:@""];
    NSString *privacyPolicyUrl = [NSString stringWithFormat:@"%@&lang=%@", minStr(dicT[@"privacyPolicyUrl"]), lang_new];
    NSString *userAgreementUrl = [NSString stringWithFormat:@"%@&lang=%@", minStr(dicT[@"userAgreementUrl"]), lang_new];
    [[NSUserDefaults standardUserDefaults] setValue:privacyPolicyUrl forKey:@"privacyPolicyUrl"];
    [[NSUserDefaults standardUserDefaults] setValue:userAgreementUrl forKey:@"userAgreementUrl"];
}

- (NSString *)privacyPolicyUrl
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"privacyPolicyUrl"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"privacyPolicyUrl"];
    }else {
        return @"";
    }
}

- (NSString *)userAgreementUrl
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"userAgreementUrl"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"userAgreementUrl"];
    }else {
        return @"";
    }
}

+ (void)saveMacElec:(NSString *)elec
{
    [[NSUserDefaults standardUserDefaults] setValue:elec forKey:@"macElec"];
}

- (NSString *)macElec
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"macElec"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"macElec"];
    }else {
        return @"";
    }
}

+ (void)saveMacId:(NSString *)elec
{
    [[NSUserDefaults standardUserDefaults] setValue:elec forKey:@"macId"];
}

- (NSString *)macId
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"macId"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"macId"];
    }else {
        return @"";
    }
}

+ (void)saveUIPlist_idStr:(NSInteger)pNum
{
    if(pNum>0) {
        [[NSUserDefaults standardUserDefaults] setInteger:pNum forKey:@"Plist_id"];
    }else {
        NSInteger um_p = [[NSUserDefaults standardUserDefaults] integerForKey:@"Plist_id"];
        [[NSUserDefaults standardUserDefaults] setInteger:um_p+1 forKey:@"Plist_id"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)plist_id
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"Plist_id"];
}

+ (void)saveUIimUserSig:(NSString *)email
{
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"imUserSig"];
}

- (NSString *)imUserSig
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"imUserSig"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"imUserSig"];
    }else {
        return @"";
    }
}

+ (void)saveEmailAuccount:(NSString *)email
{
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"EmailAuccount"];
}

- (NSString *)emailAuccount
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"EmailAuccount"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"EmailAuccount"];
    }else {
        return @"";
    }
}

- (NSString *)placeOfOrigin
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_placeOfOrigin"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_placeOfOrigin"];
    }else {
        return @"";
    }
}

- (NSString *)bg_img
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_bg"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_bg"];
    }else {
        return @"";
    }
}

+ (void)saveUserLoginDefault:(NSDictionary *)dicT
{
    [[NSUserDefaults standardUserDefaults] setBool:[dicT[@"isDomestic"] boolValue] forKey:@"isDomestic"];
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"userId"]) forKey:@"user_id"];
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"token"]) forKey:@"AppToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveUserDefault:(NSDictionary *)dicT
{
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"id"]) forKey:@"user_id"];
    
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"gender"]) forKey:@"user_sex"];
    
    NSString *user_age = [NSString stringWithFormat:@"%@", dicT[@"age"]];
    [[NSUserDefaults standardUserDefaults] setInteger:[user_age integerValue] forKey:@"user_age"];
    
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"nickName"]) forKey:@"user_nickname"];
    
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"placeOfOrigin"]) forKey:@"user_placeOfOrigin"];
    
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"profile"]) forKey:@"user_avatar"];
    
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"bg"]) forKey:@"user_bg"];
    
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"location"]) forKey:@"user_area"];
    
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"birthday"]) forKey:@"user_birthday"];
    
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"quote"]) forKey:@"user_intro"];
    
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"region"]) forKey:@"user_region"];
    
    NSString *pass_id = minStr(dicT[@"bindingMethod"]);
    [[NSUserDefaults standardUserDefaults] setInteger:[pass_id integerValue] forKey:@"isPassWordB"];
    [[NSUserDefaults standardUserDefaults] setValue:minStr(dicT[@"boundContact"]) forKey:@"EmailAuccount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)user_age
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"user_age"];
}

- (NSString *)area
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_area"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_area"];
    }else {
        return @"";
    }
}

- (NSString *)birthday
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_birthday"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_birthday"];
    }else {
        return @"";
    }
}

- (NSString *)intro
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_intro"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_intro"];
    }else {
        return @"";
    }
}

- (NSString *)region
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_region"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_region"];
    }else {
        return @"";
    }
}


+(void)saveScreenAwake:(BOOL)boo
{
    [[NSUserDefaults standardUserDefaults] setBool:boo forKey:@"isScreenAwake"];
}

- (BOOL)isScreenAwake
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isScreenAwake"];
}

+(void)saveSetLock:(BOOL)boo
{
    [[NSUserDefaults standardUserDefaults] setBool:boo forKey:@"isSetLock"];
}

- (BOOL)isSetLock
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isSetLock"];
}

+(void)saveSetLockDisable:(BOOL)boo
{
    [[NSUserDefaults standardUserDefaults] setBool:boo forKey:@"isSetLockDisable"];
}

- (BOOL)isSetLockDisable
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isSetLockDisable"];
}

+(void)saveeSecurityCode:(NSString *)name
{
    [[NSUserDefaults standardUserDefaults] setValue:name forKey:@"eSecurityCode"];
}

- (NSString *)eSecurityCode
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"eSecurityCode"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"eSecurityCode"];
    }else {
        return @"";
    }
}

+ (void)savePlayType:(NSInteger)TypeL
{
    [[NSUserDefaults standardUserDefaults] setInteger:TypeL forKey:@"play_type"];
}

- (NSInteger)play_type
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"play_type"];
}

+ (void)savePlayStart:(BOOL)TypeL
{
    [[NSUserDefaults standardUserDefaults] setBool:TypeL forKey:@"play_start"];
}

- (BOOL)play_start
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"play_start"];
}

+ (void)saveMsgNoRedStart:(NSInteger)TypeL
{
    [[NSUserDefaults standardUserDefaults] setInteger:TypeL forKey:@"msgRed_start"];
}

- (NSInteger)msgRed_start
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"msgRed_start"];
}

+ (void)saveMsgNoRedStart2:(NSInteger)TypeL
{
    [[NSUserDefaults standardUserDefaults] setInteger:TypeL forKey:@"msgRed_start2"];
}

- (NSInteger)msgRed_start2
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"msgRed_start2"];
}

+(void)saveMusicSelNum:(NSString *)name
{
    [[NSUserDefaults standardUserDefaults] setValue:name forKey:@"musicSelNum"];
}

- (NSString *)musicSelNum
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"musicSelNum"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"musicSelNum"];
    }else {
        return @"0";
    }
}

+ (void)saveIsEmailBoo:(NSInteger)isShow
{
    [[NSUserDefaults standardUserDefaults] setInteger:isShow forKey:@"isPassWordB"];
}

- (NSInteger)isPEmail
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"isPassWordB"];
}

+ (void)saveIsLoginBoo:(BOOL)isShow
{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"isLoginBoo"];
}

- (BOOL)isLoginBoo
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLoginBoo"];
}

+ (void)saveIsEnterBackground:(BOOL)isShow
{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"is_EnterBackground"];
}
- (BOOL)is_EnterBackground
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"is_EnterBackground"];
}

+ (void)saveTimeSignUser:(NSString *)dateStr
{
    [[NSUserDefaults standardUserDefaults] setValue:dateStr forKey:@"timeSignUser"];
}
+ (void)saveTimeSignUserBox:(NSString *)dateStr
{
    [[NSUserDefaults standardUserDefaults] setValue:dateStr forKey:@"timeSignUser_box"];
}
- (NSString *)timeSignUser
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"timeSignUser"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"timeSignUser"];
    }else {
        return @"";
    }
}
- (NSString *)timeSignUser_box
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"timeSignUser_box"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"timeSignUser_box"];
    }else {
        return @"";
    }
}

+ (void)saveTimeBoxMin:(NSInteger)dateStr
{
    [[NSUserDefaults standardUserDefaults] setInteger:dateStr forKey:@"timebox_min"];
}
+ (void)saveTimeBoxSec:(NSInteger)dateStr
{
    [[NSUserDefaults standardUserDefaults] setInteger:dateStr forKey:@"timebox_sec"];
}

- (NSInteger)timebox_min
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"timebox_min"];
}
- (NSInteger)timebox_sec
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"timebox_sec"];
}

+ (void)saveUserQiNiuDomain:(NSString *)url
{
    [[NSUserDefaults standardUserDefaults] setValue:url forKey:@"QiNiuDomain"];
}
- (NSString *)QiNiuDomain
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"QiNiuDomain"];
}

+ (void)saveUserAvator:(NSString *)url
{
    [[NSUserDefaults standardUserDefaults] setValue:url forKey:@"user_avatar"];
}

+ (void)saveUserNickName:(NSString *)url
{
    [[NSUserDefaults standardUserDefaults] setValue:url forKey:@"user_nickname"];
}

+ (void)saveUserSignature:(NSString *)url
{
    [[NSUserDefaults standardUserDefaults] setValue:url forKey:@"user_signature"];
}

+ (void)saveUserMobilePhone:(NSString *)url
{
    [[NSUserDefaults standardUserDefaults] setValue:url forKey:@"mobilePhone"];
}

- (BOOL)is_show
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"is_show"];
}

- (NSString *)registration_type
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"registration_type"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"registration_type"];
    }else {
        return @"0";
    }
}

- (NSInteger)order_num
{
    if([[NSUserDefaults standardUserDefaults] integerForKey:@"order_num"]) {
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"order_num"];
    }else {
        return 0;
    }
}

- (NSString *)agent_num
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"agent_num"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"agent_num"];
    }else {
        return @"0";
    }
}

- (NSString *)purchase_num
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"purchase_num"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"purchase_num"];
    }else {
        return @"0";
    }
}

- (NSString *)expires_time
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"expires_time"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"expires_time"];
    }else {
        return @"";
    }
}

- (NSInteger)vip_rank
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"vip_rank"];
}

- (NSString *)type_id
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"type_id"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"type_id"];
    }else {
        return @"";
    }
}

- (NSString *)roomnum
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"roomnum"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"roomnum"];
    }else {
        return @"";
    }
}

- (NSString *)long_id
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"long_id"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"long_id"];
    }else {
        return @"";
    }
}

- (NSString *)hostAnnouncement
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"hostAnnouncement"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"hostAnnouncement"];
    }else {
        return @"";
    }
}

+ (void)saveIsRoomnum:(NSString *)isShow hostAnnoun:(NSString *)announ
{
    [[NSUserDefaults standardUserDefaults] setObject:isShow forKey:@"roomnum"];
    [[NSUserDefaults standardUserDefaults] setObject:announ forKey:@"hostAnnouncement"];
}

+ (void)saveIsSealing:(BOOL)isShow
{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"is_Sealing"];
}

- (BOOL)sealing
{//是否被禁言
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"is_Sealing"];
}

- (NSInteger)difference
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"differenceUser"];
}
- (NSInteger)current_exp
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"current_exp"];
}

+ (void)saveUserFloating:(BOOL)isfloat
{
    [[NSUserDefaults standardUserDefaults] setBool:isfloat forKey:@"user_is_floating"];
}

+ (void)saveUserClearNum:(int)clearNum
{
    [[NSUserDefaults standardUserDefaults] setInteger:clearNum forKey:@"clearNum_host"];
}
- (int)clearNum_host
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"clearNum_host"];
}

+ (void)saveRedYellow:(BOOL)isShow
{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"user_redYellow"];
}

- (BOOL)is_showRedYellow
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_redYellow"];
}

+ (void)saveIsFirstStart:(BOOL)isShow
{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"user_isFirstStart"];
}
- (BOOL)isFirstStart
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_isFirstStart"];
}

+ (void)saveJoinballVoice:(BOOL)isShow
{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"user_joinballVoice"];
}

- (BOOL)is_joinballVoice
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_joinballVoice"];
}

+ (void)saveJoinballVibration:(BOOL)isShow
{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"user_JoinballVibration"];
}

- (BOOL)is_joinballVibration
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_JoinballVibration"];
}

+ (void)saveRedcardVoice:(BOOL)isShow
{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"user_RedcardVoice"];
}

- (BOOL)is_redcardVoice
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_RedcardVoice"];
}

+ (void)saveRedcardVibration:(BOOL)isShow
{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:@"user_RedcardVibration"];
}

- (BOOL)is_redcardVibration
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_RedcardVibration"];
}



- (int)guard_color_level
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"user_guard_color_level"];
}

- (NSString *)guard_swf_name
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_swf_name"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_swf_name"];
    }else {
        return @"";
    }
}

- (NSString *)verify_status
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_verify_status"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_verify_status"];
    }else {
        return @"";
    }
}


- (NSString *)guard_swf
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_swf"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_swf"];
    }else {
        return @"";
    }
}

- (NSString *)guard_icon
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_icon"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_icon"];
    }else {
        return @"";
    }
}

- (NSString *)guard_name
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_name"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_name"];
    }else {
        return @"";
    }
}

- (NSString *)guard_endtime
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_endtime"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_guard_endtime"];
    }else {
        return @"";
    }
}

- (int)guard_list_order
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"user_guard_list_order"];
}

- (int)guard_id
{
    return (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"user_guard_id"];
}

- (NSString *)signature
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_signature"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_signature"];
    }else {
        return @"";
    }
}

- (BOOL)isFloating
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_is_floating"];
}

- (NSString *)sex
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_sex"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_sex"];
    }else {
        return @"";
    }
}

- (BOOL)is_guard
{
    if ([TOKEN length] > 0) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_is_guard"];
    }else {
        return NO;
    }
}

- (BOOL)is_defray_pass
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_is_defray_pass"];
}

- (NSString *)t_id
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
}

- (NSString *)balance
{
    if ([TOKEN length] > 0) {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_balance"]) {
            return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_balance"];
        }else {
            return @"0";
        }
    }else {
        return @"0";
    }
}

- (NSString *)user_nickname
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_nickname"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_nickname"];
    }else {
        return @"";
    }
}

- (NSString *)avatar
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_avatar"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_avatar"];
    }else {
        return @"";
    }
}

- (NSString *)mobile
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"mobilePhone"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"mobilePhone"];
    }else {
        return @"";
    }
}

- (NSString *)votestotal
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_votestotal"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_votestotal"];
    }else {
        return @"";
    }
}

- (NSString *)exp
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_exp"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_exp"];
    }else {
        return @"";
    }
}

- (NSString *)votestotal_icon
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_votestotal_icon"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_votestotal_icon"];
    }else {
        return @"";
    }
}

- (NSString *)exp_icon
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_exp_icon"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_exp_icon"];
    }else {
        return @"";
    }
}

- (NSString *)withdrawal_balance
{
    if ([TOKEN length] > 0) {
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_withdrawal_balance"]) {
            return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_withdrawal_balance"];
        }else {
            return @"0";
        }
    }else {
        return @"0";
    }
}

- (NSString *)freeze_balance
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_freeze_balance"]) {
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_freeze_balance"];
    }else {
        return @"0";
    }
}


+ (void)saveDefaultAvatar:(NSString *)avatarStr
{
    [[NSUserDefaults standardUserDefaults] setValue:avatarStr forKey:@"user_defaultAvatar"];
}

- (NSString *)default_avatar
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_defaultAvatar"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_defaultAvatar"];
    }else {
        return @"me_placeHead_icon";
    }
}

- (BOOL)open_auction_settings
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"open_auction_settings"];
}

- (NSString *)Lucky_box_url
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"lucky_box_url"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"lucky_box_url"];
    }else {
        return @"";
    }
}

- (NSString *)charity_url
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"charity_url"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"charity_url"];
    }else {
        return @"";
    }
}

- (NSString *)im_url
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"im_url"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"im_url"];
    }else {
        return @"";
    }
}

- (NSString *)im_group_url
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"im_group_url"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"im_group_url"];
    }else {
        return @"";
    }
}

- (BOOL)open_anchor_apply
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"open_anchor_apply"];
}

- (NSString *)invite_gift_description
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"invite_gift_description"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"invite_gift_description"];
    }else {
        return @"";
    }
}

- (NSArray *)CountryCode
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"CountryCode"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"CountryCode"];
    }else {
        return @[];
    }
}

- (NSString *)live_notice
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"live_notice"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"live_notice"];
    }else {
        return @"";
    }
}

- (NSString *)h5_url
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"h5_url"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"h5_url"];
    }else {
        return @"";
    }
}

- (NSString *)privacy_policy
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"privacy_policy"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"privacy_policy"];
    }else {
        return @"";
    }
}

- (NSString *)user_agreement
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_agreement"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_agreement"];
    }else {
        return @"";
    }
}

- (BOOL)iosMandatoryUpdateSandbox
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"user_iosMandatoryUpdateSandbox"];
}

- (NSString *)announcement
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_Announcement"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_Announcement"];
    }else {
        return @"";
    }
}
- (NSString *)websocket
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_websocket"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_websocket"];
    }else {
        return @"";
    }
}
- (NSString *)CustomerService
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_CustomerService"]) {
        
        return [[NSUserDefaults standardUserDefaults] valueForKey:@"user_CustomerService"];
    }else {
        return @"";
    }
}

//保存弹幕字体大小
+ (void)saveBarrageTypeSmallBig:(NSInteger)TypeL
{
    [[NSUserDefaults standardUserDefaults] setInteger:TypeL forKey:@"barrageTypeSmallBig"];
}

- (NSInteger)barrageTypeSmallBig
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTypeSmallBig"]) {
        
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTypeSmallBig"];
    }else {
        return 0;
    }
}

//保存弹幕位置
+ (void)saveBarrageTypeType:(NSInteger)TypeL
{
    [[NSUserDefaults standardUserDefaults] setInteger:TypeL forKey:@"barrageTypeType"];
}
- (NSInteger)barrageTypeType
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTypeType"]) {
        
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTypeType"];
    }else {
        return 2;
    }
}

//保存弹幕透明度
+ (void)saveBbarrageTypeAlph:(NSInteger)TypeL
{
    [[NSUserDefaults standardUserDefaults] setInteger:TypeL forKey:@"barrageTypeAlph"];
}
- (NSInteger)barrageTypeAlph
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTypeAlph"]) {
        
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTypeAlph"];
    }else {
        return 90;
    }
}

//保存弹幕字体颜色
+ (void)saveBbarrageTextColorType:(NSInteger)TypeL
{
    [[NSUserDefaults standardUserDefaults] setInteger:TypeL forKey:@"barrageTextColorType"];
}
- (NSInteger)barrageTextColorType
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTextColorType"]) {
        
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTextColorType"];
    }else {
        return 1;
    }
}

//保存弹幕vip背景图
+ (void)saveBbarrageTextVipType:(NSInteger)TypeL
{
    [[NSUserDefaults standardUserDefaults] setInteger:TypeL forKey:@"barrageTextVipType"];
}
- (NSInteger)barrageTextVipType
{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTextVipType"]) {
        
        return [[NSUserDefaults standardUserDefaults] integerForKey:@"barrageTextVipType"];
    }else {
        return 1;
    }
}

- (BOOL)isDomestic
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isDomestic"]) {
        return [[NSUserDefaults standardUserDefaults] boolForKey:@"isDomestic"];
    }else {
        return YES;
    }
}

@end
