//
//  HistoryRecordModel.h
//  Greens
//
//  Created by Edwin on 2020/5/15.
//  Copyright © 2020 lyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^cleanCacheBlock)(void);

@interface HistoryRecordModel : NSObject

@property (nonatomic, strong) NSMutableArray *historyDatas;

+(void)cleanCache:(cleanCacheBlock)block;

+(int)hexToDec:(NSString *)hexString; //16转10

+(NSString *)DecTohex:(int)decimalNumber; //10转16

+(NSMutableArray *)separateString:(NSString *)str;

+ (NSAttributedString *)createStrketthroughAttributedLabel:(NSString *)strLL;  //显示的价格 画中线 划掉

//MARK: 随机区分颜色
+ (NSAttributedString *)AttributedStringLoginTogetherOne:(NSString *)name Two:(NSString *)name2 All:(NSString *)nameAll nameFont:(UIFont *)nameF allFont:(UIFont *)allF nameColor:(UIColor *)nameColor allColor:(UIColor *)allColor linkUrl:(NSString *)url1 linkUrl2:(NSString *)url2;

//MARK: 随机区分颜色
+ (NSAttributedString *)AttributedStringTwoTogether:(NSString *)name All:(NSString *)nameAll nameFont:(UIFont *)nameF allFont:(UIFont *)allF nameColor:(UIColor *)nameColor allColor:(UIColor *)allColor;

+ (double)distanceBetweenOrderByLat1:(double)latitude1 Lat2:(double)latitude2 Long1:(double)longitude1 Long2:(double)longitude2;

+(void)addAutoMoneyUIView:(UIView *)v_vv danweiF:(CGFloat)dwF moneF:(CGFloat)moneF color:(UIColor *)coloRR moneStr:(NSString *)moneStr tagN:(int)tagNN;

+ (NSString *)getNumbersChangeWWW:(int)nums;

+ (NSString *)secondToHourMinutesSecond:(int)nums; //秒数转 hh:mm:ss

+ (BOOL)stringIsOrNull:(NSString *)aStr;

+ (NSString *)secondDayToHourMinutesSecond:(int)nums;

+ (NSString *)secondDayToHourMinutesSecondTwo:(int)nums;

+ (NSString *)minDayToDayHourMinutes:(int)nums; // 分 时 天

+ (void)addDataPlist:(NSString *)str;

+ (void)deletDataPlist:(NSString *)num;

+ (NSArray *)requestAllDataPlist;

+ (void)deletAllDataPlist;

+ (void)DetermineNetworking;


+ (CGFloat)jiSuanWith:(NSString *)strL font:(float)fon;

+(CGFloat)jiSuanWithMethod:(NSString *)strL font:(float)fon floatMust:(CGFloat)flotwidth;

+(CGFloat)jiSuanHeight:(NSString *)strL font:(float)fon width:(float)width;

+ (NSData *)HcompressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

+ (UIImage *) imageToTransparent:(UIImage*) image;

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;

+ (void)clearTmpVideosffmpegDirectory;
+ (void)clearTmpDirectory;

+(NSString *)getCurrentTimeMethod:(NSString *)typeStr;

+ (NSString *)getTimeFromTimestamp:(NSString *)timeC dateFormat:(NSString *)formatL;

+(NSString *)getNowTimeTimestamp2;

+ (UIImage *)imageWithLineWithImageView:(UIImageView *)imageView;

+ (void)convertVideoQuailtyWithInputURL:(NSURL*)inputURL outputURL:(NSURL*)outputURL;

+ (NSString *)getTimestampFromTime;

+ (NSString *)getTimestampFromTimeSub:(int)timesub;

+ (NSString *)getTimeFromTimestamp:(NSString *)timeStamp;

+ (NSString *)getUUID;

+ (void)addShadowToViewE:(UIView *)theView withColor:(UIColor *)theColor;

+ (UIButton *)createImgBtn;
+ (UITextField *)createTextFCalculator;
+ (UILabel *)createLabLabTextColor:(UIColor *)color fontFloat:(CGFloat)flot textAlignment:(NSTextAlignment)tAlignment;
+ (UIImageView *)createImgImgView;

+ (UIView *)createViewUIUI;

+ (UIView *)createLineViewUIUI;

+ (CGFloat)kaigenhaoCalculator:(CGFloat)number;

+ (NSString *)doubleCalculator:(CGFloat)number;

+ (NSArray *)getWeekDayFromDate:(NSInteger)numSS isFuture:(BOOL)isfuture;

+ (CAGradientLayer *)createColorFrame:(CGRect)framH;

+ (NSArray *)requestSettingBallScoreArr;
+ (NSArray *)requestSettingBasketBallSArr;

+ (CAGradientLayer *)createTwoColorFrame:(CGRect)framH colorOne:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo;

+ (NSString *)chooseFootGameIcon:(NSString *)typeN;

+ (NSString *)chooseFootGameLocation:(NSString *)typeN;

+ (NSString *)chooseTechnicalStatisticsName:(NSString *)name;

+ (NSString *)roundFloatMethod:(NSString *)name;

+ (UIImage *)imgResizableImageWithCapInsetsName:(NSString *)img; //图片的切片拉伸

+ (UIImage *)imgCustomResizableImageWithCapInsetsName:(NSString *)img top:(CGFloat)topf left:(CGFloat)leftf bottom:(CGFloat)bottomf right:(CGFloat)rightf;


+ (NSString *)getTimeFromYMDTimestamp:(NSString *)timeC dateFormat:(NSString *)formatL;

+ (NSAttributedString *)formatMessageString:(NSString *)textlll;

+ (float)folderSizeAtPath;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)stringWithJsonDictionary:(NSDictionary *)jsonDic;



//保存 播放列表
+(NSArray *)requestAllDataPlayListPlist;
+(void)deletAllDataPlayListPlist;
+(void)deletDataPlayListPlist:(NSString *)num;
+(void)addDataPlayListPlist:(NSString *)str;

+(void)deletDataPlistArr:(NSArray *)num;
+(void)deletDataPlayListPlistArr:(NSArray *)num;

+(void)insertDataPlist:(NSString *)num row:(NSInteger)rowL deleteRow:(NSInteger)deleRow;
+(void)insertPlayListDataPlist:(NSString *)num row:(NSInteger)rowL deleteRow:(NSInteger)deleRow;

+(void)uploadNameDataPlist:(NSString *)num name:(NSString *)nameL;
+(void)uploadNameDataPlayListPlist:(NSString *)num name:(NSString *)nameL;

+(NSArray *)requestAccountAllDataPlist;
+(void)addNewAccountDataPlist:(NSArray *)dicAcout;
+(void)deletAccountAllListPlist;

+ (NSString *)nowTimeInterval;
+ (NSString *)getNowThreethTimeInterval;
+ (NSString *)getTimeStrWithString:(NSString *)str;

+(void)addDataMusicPlayListPlist:(NSString *)str;
+(void)insertMusicPlayListDataPlist:(NSString *)num row:(NSInteger)rowL deleteRow:(NSInteger)deleRow;
+(void)uploadNameDataMusicPlayListPlist:(NSString *)num name:(NSString *)nameL;
+(void)deletDataMusicPlayListPlist:(NSString *)num;
+(void)deletDataMusicPlayListPlistArr:(NSArray *)num;
+(void)deletAllDataMusicPlayListPlist;
+(NSArray *)requestAllDataMusicPlayListPlist;

+(void)addDataLoveMusicPlaylistName:(NSString *)nameS allStr:(NSString *)str;
+(void)deletAllLoveMusicPlayList;
+(BOOL)searchDataLoveMusicSearchName:(NSString *)nameS;
+(NSArray *)requestAllDataLoveMusicPlayList;

+ (NSString *)convertCustomTimestampToDateString:(uint64_t)timestamp isMilliseconds:(BOOL)isMilliseconds; //转换时间
@end

NS_ASSUME_NONNULL_END
