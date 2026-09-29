//
//  HistoryRecordModel.m
//  Greens
//
//  Created by Edwin on 2020/5/15.
//  Copyright © 2020 lyx. All rights reserved.
//

#import "HistoryRecordModel.h"
#import "JZLYFactory.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking.h>
#import "TUIConfig.h"

@implementation HistoryRecordModel

+(NSMutableArray *)separateString:(NSString *)str
{
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    for (int i=0; i<str.length; i++) {
        NSRange rang_rg = NSMakeRange(i, 1);
        NSString *singleSt = [str substringWithRange:rang_rg];
        [resultArr addObject:singleSt];
    }
    return resultArr;
}

+ (NSString *)getNumbersChangeWWW:(int)nums
{
    NSString *msgSt = [NSString stringWithFormat:@"%d", nums];
    int giveMsgCount = nums;
    if (giveMsgCount > 10000) {

        int mm_hh = giveMsgCount%10000;
        
        CGFloat ww = giveMsgCount/10000.0f;
        NSString *twoGiveCou = [NSString stringWithFormat:@"%.0f",ww];
        if (mm_hh > 0) {
            twoGiveCou = [NSString stringWithFormat:@"%.1f",ww];
        }
    }
    return msgSt;
}

+(int)hexToDec:(NSString *)hexString
{
    NSString *hex_st = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    
    NSScanner *scaner = [NSScanner scannerWithString:hex_st];
    unsigned  int longVVV;
    [scaner scanHexInt:&longVVV];
    
    return longVVV;
}

+(NSString *)DecTohex:(int)decimalNumber
{
    return [NSString stringWithFormat:@"%x", decimalNumber];
}


//MARK: 经纬度计算距离
+ (double)distanceBetweenOrderByLat1:(double)latitude1 Lat2:(double)latitude2 Long1:(double)longitude1 Long2:(double)longitude2
{
    CLLocation *curlocation = [[CLLocation alloc] initWithLatitude:latitude1 longitude:longitude1];
    CLLocation *otherlocation = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
    double distann = [curlocation distanceFromLocation:otherlocation];
    return distann;
}

+ (BOOL)stringIsOrNull:(NSString *)aStr
{
    if ([[aStr class] isSubclassOfClass:[NSNull class]]) {
        return YES;
        
    } if (aStr == nil || aStr == NULL || [aStr isEqualToString:@"(null)"] || [aStr isEqualToString:@"null"] ||[aStr isEqualToString:@""]) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSString class]] && [[aStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+(void)addAutoMoneyUIView:(UIView *)v_vv danweiF:(CGFloat)dwF moneF:(CGFloat)moneF color:(nonnull UIColor *)coloRR moneStr:(nonnull NSString *)moneStr tagN:(int)tagNN
{
    UILabel *oneLL = [HistoryRecordModel createLabLabTextColor:coloRR fontFloat:dwF textAlignment:NSTextAlignmentLeft];
    oneLL.text = eLocalizedString(@"danweiName");
    [v_vv addSubview:oneLL];
    [oneLL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(v_vv.mas_left);
        make.centerY.equalTo(v_vv.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(10);
    }];
    
    UILabel *oneLL2 = [HistoryRecordModel createLabLabTextColor:coloRR fontFloat:moneF textAlignment:NSTextAlignmentLeft];
    oneLL2.text = moneStr;
    oneLL2.tag = tagNN;
    oneLL2.numberOfLines = 2;
    [v_vv addSubview:oneLL2];
    [oneLL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneLL.mas_right).offset(2);
        make.right.top.bottom.equalTo(v_vv);
    }];
    
}

+ (NSAttributedString *)createStrketthroughAttributedLabel:(NSString *)strLL
{
    NSDictionary *attriDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:strLL attributes:attriDic];
    
    return attStr;
}

+ (NSString *)secondToHourMinutesSecond:(int)nums
{
    int second = 0;
    int minn = 0;
    int hour = 0;
    
    second = nums%60;
    minn = nums/60;
    
    if(minn >= 60) {
        hour = minn/60;
        minn = minn%60;
    }
    
    NSString *oneStr = [NSString stringWithFormat:@"%d", second];
    NSString *twoStr = [NSString stringWithFormat:@"%d", minn];
    NSString *thrStr = [NSString stringWithFormat:@"%d", hour];
    if(second < 10) {
        oneStr = [NSString stringWithFormat:@"0%d", second];
    }
    if(minn < 10) {
        twoStr = [NSString stringWithFormat:@"0%d", minn];
    }
    if(hour < 10) {
        thrStr = [NSString stringWithFormat:@"0%d", hour];
    }
    if(hour>0) {
        return [NSString stringWithFormat:@"%@:%@:%@", thrStr, twoStr, oneStr];
    }else {
        return [NSString stringWithFormat:@"%@:%@", twoStr, oneStr];
    }
}


+ (NSString *)secondDayToHourMinutesSecond:(int)nums
{
    int second2 = 0;
    int second = 0;
    int minn = 0;
    int hour = 0;
    
    int dayd = nums/60;
    second2 = nums%60;
    
    second = dayd%60;
    minn = dayd/60;
    
    if(minn >= 24) {
        hour = minn/24;
        minn = minn%24;
    }
      
    NSString *oneStr2 = [NSString stringWithFormat:@"%d", second2];
    NSString *oneStr = [NSString stringWithFormat:@"%d", second];
    NSString *twoStr = [NSString stringWithFormat:@"%d", minn];
    NSString *thrStr = [NSString stringWithFormat:@"%d", hour];
    
    if(second2 < 10) {
        oneStr2 = [NSString stringWithFormat:@"0%d", second2];
    }
    if(second < 10) {
        oneStr = [NSString stringWithFormat:@"0%d", second];
    }
    if(minn < 10) {
        twoStr = [NSString stringWithFormat:@"0%d", minn];
    }
    if(hour < 10) {
        thrStr = [NSString stringWithFormat:@"0%d", hour];
    }
    return [NSString stringWithFormat:@"%@:%@:%@:%@", thrStr, twoStr, oneStr, oneStr2];
}


+ (NSString *)minDayToDayHourMinutes:(int)nums
{
    int second = 0;
    int minn = 0;
    int hour = 0;
    
    int dayd = nums/60;
    second = nums%60;

    hour = dayd/24;
    minn = dayd%24;
      
    NSString *oneStr = [NSString stringWithFormat:@"%d", second];
    NSString *twoStr = [NSString stringWithFormat:@"%d", minn];
    NSString *thrStr = [NSString stringWithFormat:@"%d", hour];
    
    if(second < 10) {
        oneStr = [NSString stringWithFormat:@"0%d", second];
    }
    if(minn < 10) {
        twoStr = [NSString stringWithFormat:@"0%d", minn];
    }
    if(hour < 10) {
        thrStr = [NSString stringWithFormat:@"0%d", hour];
    }
    return [NSString stringWithFormat:@"%@:%@:%@", thrStr, twoStr, oneStr];
}


+ (NSString *)secondDayToHourMinutesSecondTwo:(int)nums
{
    int secondTT = 0;
    int second = 0;
    int minn = 0;
    int hour = 0;
    
    secondTT = nums%60;
    
    int dayd = nums/60;
    
    second = dayd%60;
    minn = dayd/60;
    
    if(minn >= 60) {
        hour = minn/60;
        minn = minn%60;
    }
      
    NSString *oneStr2 = [NSString stringWithFormat:@"%d", secondTT];
    NSString *oneStr = [NSString stringWithFormat:@"%d", second];
    NSString *twoStr = [NSString stringWithFormat:@"%d", minn];
    NSString *thrStr = [NSString stringWithFormat:@"%d", hour];
    
    if(secondTT < 10) {
        oneStr2 = [NSString stringWithFormat:@"0%d", secondTT];
    }
    if(second < 10) {
        oneStr = [NSString stringWithFormat:@"0%d", second];
    }
    if(minn < 10) {
        twoStr = [NSString stringWithFormat:@"0%d", minn];
    }
    if(hour < 10) {
        thrStr = [NSString stringWithFormat:@"0%d", hour];
    }
    if(hour>0) {
        return [NSString stringWithFormat:@"%@:%@:%@:%@", thrStr, twoStr, oneStr, oneStr2];
    }else {
        return [NSString stringWithFormat:@"00:%@:%@:%@", twoStr, oneStr, oneStr2];
    }
}

+ (NSAttributedString *)formatMessageString:(NSString *)textlll
{
    NSString *text = [NSString stringWithFormat:@"%@", textlll];
    
    //先判断text是否存在
    if (text == nil || text.length == 0) {
        NSLog(@"TTextMessageCell formatMessageString failed , current text is nil");
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    //1、创建一个可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    if([TUIConfig defaultConfig].faceGroups.count == 0){
        [attributeString addAttribute:NSFontAttributeName value:SYS_Font(14) range:NSMakeRange(0, attributeString.length)];
        return attributeString;
    }
    [attributeString addAttribute:NSForegroundColorAttributeName value:GrayTextColor range:NSMakeRange(0, attributeString.length)];

    //2、通过正则表达式来匹配字符串
    NSString *regex_emoji = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]"; //匹配表情

    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:NSRegularExpressionCaseInsensitive error:&error];
    if (!re) {
        NSLog(@"%@", [error localizedDescription]);
        return attributeString;
    }

    NSArray *resultArray = [re matchesInString:text options:0 range:NSMakeRange(0, text.length)];

    TUIFaceGroup *group = [TUIConfig defaultConfig].faceGroups[0];

    //3、获取所有的表情以及位置
    //用来存放字典，字典中存储的是图片和图片对应的位置
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        //获取数组元素中得到range
        NSRange range = [match range];
        //获取原字符串中对应的值
        NSString *subStr = [text substringWithRange:range];

        for (TUIFaceCellData *face in group.faces) {
            if ([face.name isEqualToString:subStr]) {
                //face[i][@"png"]就是我们要加载的图片
                //新建文字附件来存放我们的图片,iOS7才新加的对象
                NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
                //给附件添加图片
                textAttachment.image = [[TUIImageCache sharedInstance] getFaceFromCache:face.path];
                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                textAttachment.bounds = CGRectMake(0, -(SYS_Font(14).lineHeight-SYS_Font(14).pointSize)/2, SYS_Font(14).pointSize, SYS_Font(14).pointSize);
                //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
                NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                //把图片和图片对应的位置存入字典中
                NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
                [imageDic setObject:imageStr forKey:@"image"];
                [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
                //把字典存入数组中
                [imageArray addObject:imageDic];
                break;
            }
        }
    }

    //4、从后往前替换，否则会引起位置问题
    for (int i = (int)imageArray.count -1; i >= 0; i--) {
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];
    }

    [attributeString addAttribute:NSFontAttributeName value:SYS_Font(14) range:NSMakeRange(0, attributeString.length)];
    
    return attributeString;
}


+(CGFloat)jiSuanHeight:(NSString *)strL font:(float)fon width:(float)width
{
    CGFloat heigth_h = [JZLYFactory heightWithText:strL font:fon sizeWidth:width];
    
    return heigth_h;
}

+(CGFloat)jiSuanWith:(NSString *)strL font:(float)fon
{
    CGFloat width_W = [JZLYFactory widthWithText:strL font:fon sizeWidth:300];
    
    return width_W;
}

+(CGFloat)jiSuanWithMethod:(NSString *)strL font:(float)fon floatMust:(CGFloat)flotwidth
{
    CGFloat width_W = [JZLYFactory widthWithText:strL font:fon sizeWidth:flotwidth];
    
    return width_W;
}

+(void)addNewAccountDataPlist:(NSArray *)dicAcout
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"accountCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
    
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist增加前-- %lu", (unsigned long)dataArray.count);
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSDictionary *name in dataArray) {
            [dataAry addObject:name];
        }
        for (NSDictionary *nameDic in dicAcout) {
            [dataAry addObject:nameDic];
        }

        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
        
        NSMutableArray *dataA = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist增加后-- %lu", (unsigned long)dataA.count);
        
    }
}

+(NSArray *)requestAccountAllDataPlist
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"accountCachePlist.plist"];
      
    NSLog(@"plist路径 -- %@",filePath);

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    NSMutableArray *dataArray = [NSMutableArray array];
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        dataArray = [dataArray initWithContentsOfFile:filePath];
    }
    return dataArray;
}
+(void)deletAccountAllListPlist
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"accountCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSArray *dataArray = @[];
        [dataArray writeToFile:filePath atomically:YES];
    }
}


//搜索记录 缓存
+(void)addDataPlist:(NSString *)str
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"hostoricalCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
    
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist增加前-- %lu", (unsigned long)dataArray.count);
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            [dataAry addObject:name];
        }
        [dataAry insertObject:str atIndex:0];
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
        
        NSMutableArray *dataA = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist增加后-- %lu", (unsigned long)dataA.count);
        
    }
}

+(void)uploadNameDataPlist:(NSString *)num name:(NSString *)nameL
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"hostoricalCachePlist.plist"];
    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (int i=0; i<dataArray.count; i++) {
            NSString *nameP = dataArray[i];
            NSArray *thrAr = [nameP componentsSeparatedByString:@"-&-"];
            if([minStr(thrAr[0]) isEqualToString:num]) {
                [dataAry addObject:[NSString stringWithFormat:@"%@-&-%@-&-%@-&-%@-&-%@-&-%@", thrAr[0], nameL, thrAr[2], thrAr[3], thrAr[4], thrAr[5]]];
            }else {
                [dataAry addObject:nameP];
            }
        }
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
    }
}

+(void)deletDataPlist:(NSString *)num
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"hostoricalCachePlist.plist"];
      
    NSLog(@"plist路径 -- %@",filePath);

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除前-- %lu", (unsigned long)dataArray.count);
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            NSArray *subAr = [name componentsSeparatedByString:@"-&-"];
            if(![num isEqualToString:minStr(subAr[0])]) {
                [dataAry addObject:name];
            }
        }
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
        
        NSMutableArray *dataA = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除后-- %lu", (unsigned long)dataA.count);
    }
}

+(void)deletDataPlistArr:(NSArray *)num
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"hostoricalCachePlist.plist"];
      
    NSLog(@"plist路径 -- %@",filePath);

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除前-- %lu", (unsigned long)dataArray.count);
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            NSArray *subAr = [name componentsSeparatedByString:@"-&-"];
            if(![num containsObject:minStr(subAr[0])]) {
                [dataAry addObject:name];
            }
        }
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
        
        NSMutableArray *dataA = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除后-- %lu", (unsigned long)dataA.count);
    }
}

+(void)deletAllDataPlist
{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"hostoricalCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        
    NSArray *dataArray = @[];
    [dataArray writeToFile:filePath atomically:YES];
    }
}

+(void)insertDataPlist:(NSString *)num row:(NSInteger)rowL deleteRow:(NSInteger)deleRow
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"hostoricalCachePlist.plist"];
      
    NSLog(@"plist路径 -- %@",filePath);

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除前-- %lu", (unsigned long)dataArray.count);
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            [dataAry addObject:name];
        }
        [dataAry removeObjectAtIndex:deleRow];
        [dataAry insertObject:num atIndex:rowL];
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
        
        NSMutableArray *dataA = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除后-- %lu", (unsigned long)dataA.count);
    }
}

+(NSArray *)requestAllDataPlist
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"hostoricalCachePlist.plist"];
      
    NSLog(@"plist路径 -- %@",filePath);

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    NSMutableArray *dataArray = [NSMutableArray array];
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
//    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        dataArray = [dataArray initWithContentsOfFile:filePath];
    }
    return dataArray;
}



//播放主列表
+(void)addDataPlayListPlist:(NSString *)str
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playListCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
    
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist增加前-- %lu", (unsigned long)dataArray.count);
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            [dataAry addObject:name];
        }
        [dataAry insertObject:str atIndex:0];
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
        
        NSMutableArray *dataA = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist增加后-- %lu", (unsigned long)dataA.count);
        
    }
}

+(void)insertPlayListDataPlist:(NSString *)num row:(NSInteger)rowL deleteRow:(NSInteger)deleRow
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playListCachePlist.plist"];
      
    NSLog(@"plist路径 -- %@",filePath);

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除前-- %lu", (unsigned long)dataArray.count);
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            [dataAry addObject:name];
        }
        [dataAry removeObjectAtIndex:deleRow];
        [dataAry insertObject:num atIndex:rowL];
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
        
        NSMutableArray *dataA = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除后-- %lu", (unsigned long)dataA.count);
    }
}

+(void)uploadNameDataPlayListPlist:(NSString *)num name:(NSString *)nameL
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playListCachePlist.plist"];
    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (int i=0; i<dataArray.count; i++) {
            NSString *nameP = dataArray[i];
            NSArray *thrAr = [nameP componentsSeparatedByString:@"-&-"];
            if([minStr(thrAr[0]) isEqualToString:num]) {
                [dataAry addObject:nameL];
            }else {
                [dataAry addObject:nameP];
            }
        }
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
    }
}

+(void)deletDataPlayListPlist:(NSString *)num
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playListCachePlist.plist"];
      
    NSLog(@"plist路径 -- %@",filePath);

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除前-- %lu", (unsigned long)dataArray.count);
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            NSArray *subAr = [name componentsSeparatedByString:@"-&-"];
            if(![num isEqualToString:minStr(subAr[0])]) {
                [dataAry addObject:name];
            }
        }
//        [dataAry removeObjectAtIndex:num];
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
        
        NSMutableArray *dataA = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除后-- %lu", (unsigned long)dataA.count);
    }
}

+(void)deletDataPlayListPlistArr:(NSArray *)num
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playListCachePlist.plist"];
      
    NSLog(@"plist路径 -- %@",filePath);

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除前-- %lu", (unsigned long)dataArray.count);
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            NSArray *subAr = [name componentsSeparatedByString:@"-&-"];
            if(![num containsObject:minStr(subAr[0])]) {
                [dataAry addObject:name];
            }
        }
//        [dataAry removeObjectAtIndex:num];
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
        
        NSMutableArray *dataA = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSLog(@"plist删除后-- %lu", (unsigned long)dataA.count);
    }
}

+(void)deletAllDataPlayListPlist
{
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playListCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        
    NSArray *dataArray = @[];
    [dataArray writeToFile:filePath atomically:YES];
    }
}

+(NSArray *)requestAllDataPlayListPlist
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playListCachePlist.plist"];
      
    NSLog(@"plist路径 -- %@",filePath);

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    NSMutableArray *dataArray = [NSMutableArray array];
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
//    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        dataArray = [dataArray initWithContentsOfFile:filePath];
    }
    return dataArray;
}

//是否收藏的
+(void)addDataLoveMusicPlaylistName:(NSString *)nameS allStr:(NSString *)str
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"loveMusicListCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
    
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSMutableArray *dataAry = [NSMutableArray array];
        
        BOOL isYYY = NO;
        int ro_w = 0;
        for (int i=0; i<dataArray.count; i++) {
            NSString *name = dataArray[i];
            NSArray *ar_arl = [name componentsSeparatedByString:@">>"];
            if([nameS isEqualToString:minStr(ar_arl[0])]) {
                isYYY = YES;
                ro_w = i;
            }
            [dataAry addObject:name];
        }
        if(isYYY) {
            [dataAry removeObjectAtIndex:ro_w];
        }else {
            [dataAry addObject:str];
        }
       
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
    }
}

+(BOOL)searchDataLoveMusicSearchName:(NSString *)nameS
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"loveMusicListCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
    
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        
        BOOL isYYY = NO;
        for (int i=0; i<dataArray.count; i++) {
            NSString *name = dataArray[i];
            NSArray *ar_arl = [name componentsSeparatedByString:@">>"];
            if([nameS isEqualToString:minStr(ar_arl[0])]) {
                isYYY = YES;
            }
        }
        if(isYYY) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

+(NSArray *)requestAllDataLoveMusicPlayList
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"loveMusicListCachePlist.plist"];
      
    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    NSMutableArray *dataArray = [NSMutableArray array];
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        dataArray = [dataArray initWithContentsOfFile:filePath];
    }
    return dataArray;
}

+(void)deletAllLoveMusicPlayList
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"loveMusicListCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        
        NSArray *dataArray = @[];
        [dataArray writeToFile:filePath atomically:YES];
    }
}

//MARK: 音乐缓存
+(void)addDataMusicPlayListPlist:(NSString *)str
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playMusicListCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
    
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            [dataAry addObject:name];
        }
        [dataAry insertObject:str atIndex:0];
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
    }
}

+(void)insertMusicPlayListDataPlist:(NSString *)num row:(NSInteger)rowL deleteRow:(NSInteger)deleRow
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playMusicListCachePlist.plist"];
      
    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            [dataAry addObject:name];
        }
        [dataAry removeObjectAtIndex:deleRow];
        [dataAry insertObject:num atIndex:rowL];
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
    }
}

+(void)uploadNameDataMusicPlayListPlist:(NSString *)num name:(NSString *)nameL
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playMusicListCachePlist.plist"];
    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (int i=0; i<dataArray.count; i++) {
            NSString *nameP = dataArray[i];
            NSArray *thrAr = [nameP componentsSeparatedByString:@"-&-"];
            if([minStr(thrAr[0]) isEqualToString:num]) {
                [dataAry addObject:nameL];
            }else {
                [dataAry addObject:nameP];
            }
        }
        
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
    }
}

+(void)deletDataMusicPlayListPlist:(NSString *)num
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playMusicListCachePlist.plist"];
      
    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            NSArray *subAr = [name componentsSeparatedByString:@"-&-"];
            if(![num isEqualToString:minStr(subAr[0])]) {
                [dataAry addObject:name];
            }
        }

        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
    }
}

+(void)deletDataMusicPlayListPlistArr:(NSArray *)num
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playMusicListCachePlist.plist"];
    
    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
      
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        NSMutableArray *dataAry = [NSMutableArray array];
        
        for (NSString *name in dataArray) {
            NSArray *subAr = [name componentsSeparatedByString:@"-&-"];
            if(![num containsObject:minStr(subAr[0])]) {
                [dataAry addObject:name];
            }
        }
        NSArray *array= [NSArray arrayWithArray:dataAry];
        [array writeToFile:filePath atomically:YES];
    }
}

+(void)deletAllDataMusicPlayListPlist
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playMusicListCachePlist.plist"];

    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        
        NSArray *dataArray = @[];
        [dataArray writeToFile:filePath atomically:YES];
    }
}

+(NSArray *)requestAllDataMusicPlayListPlist
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePath = [path stringByAppendingPathComponent:@"playMusicListCachePlist.plist"];
      
    NSFileManager* fm = [NSFileManager defaultManager];
     if ([fm fileExistsAtPath:filePath]) {
     
     }else {
         [fm createFileAtPath:filePath contents:nil attributes:nil];
     }
    NSMutableArray *dataArray = [NSMutableArray array];
    BOOL bRet = [fm fileExistsAtPath:filePath];
    if (bRet) {
        dataArray = [dataArray initWithContentsOfFile:filePath];
    }
    return dataArray;
}


#pragma mark - 压缩图片
+ (NSData *)HcompressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size
{
    UIImage *OriginalImage = image;
    
    // 执行这句代码之后会有一个范围 例如500m 会是 100m～500k
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    
    // 执行while循环 如果第一次压缩不会小雨100k 那么减小尺寸在重新开始压缩
    while (dataKBytes > size)
    {
        while (dataKBytes > size && maxQuality > 0.1f)
        {
            maxQuality = maxQuality - 0.1f;
            data = UIImageJPEGRepresentation(image, maxQuality);
            dataKBytes = data.length / 1000.0;
            if(dataKBytes <= size )
            {
                return data;
            }
        }
        
        CGSize imageSize = OriginalImage.size;
        CGFloat Originalwidth = imageSize.width;
        CGFloat Originalheight = imageSize.height;
        CGFloat targetHeight = Originalheight / Originalwidth * OriginalImage.size.width * 0.8;
        UIGraphicsBeginImageContext(CGSizeMake(OriginalImage.size.width * 0.8, targetHeight));
        [image drawInRect:CGRectMake(0,0,OriginalImage.size.width * 0.8,  targetHeight)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        OriginalImage = newImage;
        image = OriginalImage;
        data = UIImageJPEGRepresentation(image, 0.1);
        dataKBytes = data.length / 1000.0;
        maxQuality = 0.9f;
    }
    return data;
}
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
#pragma mark -去除图片白底
+ (UIImage *) imageToTransparent:(UIImage*) image
{
// 分配内存
 
    const int imageWidth = image.size.width;
     
    const int imageHeight = image.size.height;
     
    size_t bytesPerRow = imageWidth * 4;
     
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // 创建context
     
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
     
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
     
    // 遍历像素
     
    int pixelNum = imageWidth * imageHeight;
     
    uint32_t* pCurPtr = rgbImageBuf;
     
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
        
    {
    
    //        //去除白色...将0xFFFFFF00换成其它颜色也可以替换其他颜色。
    
    //        if ((*pCurPtr & 0xFFFFFF00) >= 0xffffff00) {
    
    //
    
    //            uint8_t* ptr = (uint8_t*)pCurPtr;
    
    //            ptr[0] = 0;
    
    //        }
    
    //接近白色
    
    //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
    
    //分别取出RGB值后。进行判断需不需要设成透明。
    
        uint8_t* ptr = (uint8_t*)pCurPtr;
        
        if (ptr[1] > 240 && ptr[2] > 240 && ptr[3] > 240) {
            
            //当RGB值都大于240则比较接近白色的都将透明度设为0.-----即接近白色的都设置为透明。某些白色背景具有杂质就会去不干净，用这个方法可以去干净
            
            ptr[0] = 0;
        }
    }

    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
     
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace, kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider, NULL, true,kCGRenderingIntentDefault);
     
    CGDataProviderRelease(dataProvider);
     
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
     
    // 释放
     
    CGImageRelease(imageRef);
     
    CGContextRelease(context);
     
    CGColorSpaceRelease(colorSpace);
     
    return resultUIImage;
     
}

+ (void)clearTmpVideosffmpegDirectory
{
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
    for (NSString *file in tmpDirectory) {
        if ([file isEqualToString:@"videosffmpeg"]) {
            [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
        }
    }
}

+ (void)clearTmpDirectory
{
    NSArray* tmpDirectory = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSTemporaryDirectory() error:NULL];
    for (NSString *file in tmpDirectory) {
        
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", NSTemporaryDirectory(), file] error:NULL];
    }
}

+ (NSString *)getTimeFromTimestamp:(NSString *)timeC dateFormat:(NSString *)formatL
{

    //将对象类型的时间转换为NSDate类型

    double time = [timeC doubleValue]/1000;

    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];

    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];

    if (formatL.length > 0) {
        [formatter setDateFormat:formatL];
    }else {
//        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        [formatter setDateFormat:@"HH:mm"];
    }

    //将时间转换为字符串

    NSString *timeStr=[formatter stringFromDate:myDate];

    return timeStr;

}

+ (NSString *)getTimeFromYMDTimestamp:(NSString *)timeC dateFormat:(NSString *)formatL
{

    //将对象类型的时间转换为NSDate类型

    double time = [timeC doubleValue];
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];

    if (formatL.length > 0) {
        [formatter setDateFormat:formatL];
    }else {
        [formatter setDateFormat:@"YYYY-MM-dd"];
    }
    NSString *timeStr=[formatter stringFromDate:myDate];

    return timeStr;

}

+(NSString *)getNowTimeTimestamp2 {
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
}

#pragma mark ---- 将时间戳转换成时间
+ (NSString *)getTimeFromTimestamp:(NSString *)timeStamp{
    //将对象类型的时间转换为NSDate类型
    double timeStampDouble = [timeStamp doubleValue];
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timeStampDouble];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
    //将时间转换为字符串
    
    NSString *timeStr=[formatter stringFromDate:myDate];
    return timeStr;
}

//pragma mark 当前时间戳
+ (NSString *)nowTimeInterval {
    // 现在的时间戳
    
    // 获取当前时间0秒后的时间
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    // *1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSString *timeStr = [NSString stringWithFormat:@"%.0f", time];
    return timeStr;
}

#pragma mark 获取时间戳
+ (NSString *)getNowThreethTimeInterval {
    // 获取当前时间0秒后的时间
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    // *1000 是精确到毫秒，不乘就是精确到秒
//    NSTimeInterval time = [date timeIntervalSince1970]*1000;
    NSTimeInterval timestamp = [date timeIntervalSince1970];
//    NSString *timeStr = [NSString stringWithFormat:@"%.0f", timestamp];
    int seconds = (int)timestamp; // 确保只取整数部分
    
    //时间戳 转 16进制
    NSString *hexString = [NSString stringWithFormat:@"%x", seconds];
    
    return hexString;
}

// 字符串转时间戳 如：2017-4-10 17:15:10 （精确到毫秒*1000）
+ (NSString *)getTimeStrWithString:(NSString *)str {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

+ (UIImage *)imageWithLineWithImageView:(UIImageView *)imageView
{
    CGFloat width = imageView.frame.size.width;
    CGFloat height = imageView.frame.size.height;
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, width, height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {5,5};//虚线的长度设置
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0].CGColor);
//画线
    CGContextSetLineDash(line, 0, lengths, 1);
    CGContextMoveToPoint(line, 0, 1);
    CGContextAddLineToPoint(line, width-5, 1);
    CGContextStrokePath(line);
    return  UIGraphicsGetImageFromCurrentImageContext();
}


+ (void)convertVideoQuailtyWithInputURL:(NSURL*)inputURL outputURL:(NSURL*)outputURL {
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
    
    exportSession.outputURL = outputURL;
    exportSession.outputFileType = AVFileTypeMPEG4;
    exportSession.shouldOptimizeForNetworkUse= YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
     {
         switch (exportSession.status) {
             case AVAssetExportSessionStatusCancelled:
                 NSLog(@"AVAssetExportSessionStatusCancelled");
                 break;
             case AVAssetExportSessionStatusUnknown:
                 NSLog(@"AVAssetExportSessionStatusUnknown");
                 break;
             case AVAssetExportSessionStatusWaiting:
                 NSLog(@"AVAssetExportSessionStatusWaiting");
                 break;
             case AVAssetExportSessionStatusExporting:
                 NSLog(@"AVAssetExportSessionStatusExporting");
                 break;
             case AVAssetExportSessionStatusCompleted:
                 NSLog(@"AVAssetExportSessionStatusCompleted");
                 break;
             case AVAssetExportSessionStatusFailed:
                 NSLog(@"AVAssetExportSessionStatusFailed");
                 break;
         }
    }];
}

+(NSString *)getCurrentTimeMethod:(NSString *)typeStr
{
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:typeStr];
//    NSDate *datenow = [NSDate date];
//    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    if (typeStr.length > 0) {
        [formatter setDateFormat:typeStr];
    }else {
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    NSDate * NowDate = [NSDate dateWithTimeIntervalSince1970:now];
    NSString * timeStr = [formatter stringFromDate:NowDate];
    
    return timeStr;
}

+ (NSString *)getTimestampFromTime{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
//    NSDate *datenow = [NSDate date];
//    // 时间转时间戳的方法:
//    NSString *strTime = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    NSDate *datenow = [NSDate date];
//    NSString *strTime = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    NSString *strTime = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970])];
    return strTime;
}

+ (NSString *)getTimestampFromTimeSub:(int)timesub {

    int mmA = timesub/1000;
    
    int nna = timesub % 1000;

    NSString *timeMU = [NSString stringWithFormat:@"%d‘%d“", mmA, nna];
    return timeMU;
}

+ (NSString *)getUUID
{
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
    
}

//MARK: 阴影
+ (void)addShadowToViewE:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(4,4);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 1;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;

    theView.layer.masksToBounds = YES;
    theView.clipsToBounds = false;
}

+ (UIButton *)createImgBtn
{
    UIButton *oneRCBtn = [[UIButton alloc] init];
    oneRCBtn.clipsToBounds = YES;
    oneRCBtn.layer.cornerRadius = 5;
    return oneRCBtn;
}

+ (UIImageView *)createImgImgView
{
    UIImageView *oneRCBtn = [[UIImageView alloc] init];
    oneRCBtn.clipsToBounds = YES;
    return oneRCBtn;
}

+ (UITextField *)createTextFCalculator
{
    UITextField *five_fiv_Field = [[UITextField alloc] init];
    five_fiv_Field.layer.cornerRadius = 5;
    five_fiv_Field.clipsToBounds = YES;
    five_fiv_Field.layer.borderColor = GrayText.CGColor;
    five_fiv_Field.layer.borderWidth = 1;
    five_fiv_Field.font = SYS_Font(12);
    five_fiv_Field.textColor = GrayTextColor;
    five_fiv_Field.textAlignment = NSTextAlignmentCenter;
    five_fiv_Field.keyboardType = UIKeyboardTypeDecimalPad;
    return five_fiv_Field;
}

+ (UILabel *)createLabLabTextColor:(UIColor *)color fontFloat:(CGFloat)flot textAlignment:(NSTextAlignment)tAlignment
{
    UILabel *oneLab = [[UILabel alloc] init];
    oneLab.textColor = color;
    oneLab.font = SYS_Font(flot);
    oneLab.textAlignment = tAlignment;
    return oneLab;
}

+ (UIView *)createViewUIUI
{
    UIView *contVVV = [[UIView alloc] init];
    contVVV.layer.cornerRadius = 8;
    contVVV.clipsToBounds = YES;
    contVVV.backgroundColor = UIColor.whiteColor;
    return contVVV;
}

+ (UIView *)createLineViewUIUI
{
    UIView *contVVV = [[UIView alloc] init];
    contVVV.backgroundColor = RGB(241, 241, 241);
    return contVVV;
}

+ (void)DetermineNetworking
{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
            NSLog(@"有网");
        }else{
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"model_NoNetwork")];
        }
    }];
}

+ (CGFloat)kaigenhaoCalculator:(CGFloat)number
{
    CGFloat sqrtNumber = 0;
    if (number < 0) {
        // 这里根据实际情况做处理,简单的返回-1,可以根据-1情况进行处理
        sqrtNumber = -1;
    } else {
    // 下面是最主要的
        // 定义变量
        CGFloat oldRangeMid; // 记录上次运算的中间值
        CGFloat newRangeMid; // 生成新的中间值
        CGFloat rangeLeft; // 二分法区间的起始数
        CGFloat rangeRight; // 二分法区间的截止数

        // 初始化
        rangeLeft = 0;
        rangeRight = number;
        newRangeMid = oldRangeMid = (rangeLeft + rangeRight) / 2;

        do {
        // 满足条件,二分法缩小判断范围
            if (newRangeMid * newRangeMid > number) {
                rangeRight = newRangeMid;
            } else {
                rangeLeft = newRangeMid;
            }
            // 重新赋值,判断并且是否进入下一步的运算
            oldRangeMid = newRangeMid;
            newRangeMid = (rangeRight + rangeLeft) / 2;
            // 下面的判断是比较重要的
            // 我们需要判断新的Mid的值和旧的Mid的值的差值是不是在Float的精确度的允许误差范围之内,
            // 如果在误差范围之内,那么新的Mid就是我们需要得到的数值
            // 如果不在误差范围之内,那么继续进入下一步的运算,一直到满足
        } while (fabs(newRangeMid - oldRangeMid) > FLT_EPSILON);
        // 满足结果,赋值
        sqrtNumber = newRangeMid;
    }
    // 返回求得的开方数
    return sqrtNumber;
}

+ (NSString *)doubleCalculator:(CGFloat)number
{
    NSString *numone = [NSString stringWithFormat:@"%f", number];
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(numone.doubleValue)];
    return outNumber;
}

+ (NSArray *)getWeekDayFromDate:(NSInteger)numSS isFuture:(BOOL)isfuture {

    if (isfuture) {
        NSDate * date = [NSDate date];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd"];
        //一周的秒数
        NSTimeInterval time = numSS * 24 * 60 * 60;
        //下周就把"-"去掉
        NSDate *lastWeek = [date dateByAddingTimeInterval:time];
        NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
        
        NSDateFormatter * dateFormatterTwo = [[NSDateFormatter alloc] init];
        [dateFormatterTwo setDateFormat:@"yyyy-MM-dd"];
        NSString *startDateTwo =  [dateFormatterTwo stringFromDate:lastWeek];
        
        NSArray *tempWeek = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];

        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

        NSDateComponents *comps = [[NSDateComponents alloc] init];

        NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;

        comps = [calendar components:unitFlags fromDate:lastWeek];

        // 1、2、3、4、5、6、7 分别对应 周日、周一、周二、周三、周四、周五、周六

        NSInteger week = [comps weekday];

        // 调整后 1 代表 周一
        return @[[NSString stringWithFormat:@"%@\n%@", startDate, tempWeek[week-1]], startDateTwo];
    }else {
        NSDate * date = [NSDate date];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd"];
        //一周的秒数
        NSTimeInterval time = numSS * 24 * 60 * 60;
        //下周就把"-"去掉
        NSDate *lastWeek = [date dateByAddingTimeInterval:-time];
        NSString *startDate =  [dateFormatter stringFromDate:lastWeek];
        
        NSDateFormatter * dateFormatterTwo = [[NSDateFormatter alloc] init];
        [dateFormatterTwo setDateFormat:@"yyyy-MM-dd"];
        NSString *startDateTwo =  [dateFormatterTwo stringFromDate:lastWeek];
        
        NSArray *tempWeek = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];

        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

        NSDateComponents *comps = [[NSDateComponents alloc] init];

        NSInteger unitFlags = NSCalendarUnitYear |NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitWeekday | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;

        comps = [calendar components:unitFlags fromDate:lastWeek];

        // 1、2、3、4、5、6、7 分别对应 周日、周一、周二、周三、周四、周五、周六

        NSInteger week = [comps weekday];

        // 调整后 1 代表 周一
        return @[[NSString stringWithFormat:@"%@\n%@", startDate, tempWeek[week-1]], startDateTwo];
    }
}

//MARK: 颜色渐变

+ (CAGradientLayer *)createColorFrame:(CGRect)framH
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)RGB(255, 157, 114).CGColor, (__bridge id)RGB(232, 2, 185).CGColor];
    gradientLayer.locations = @[@0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = framH;
//    [self.view.layer addSublayer:gradientLayer];
    return gradientLayer;
}

+ (CAGradientLayer *)createTwoColorFrame:(CGRect)framH colorOne:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)RGB(233, 43, 43).CGColor, (__bridge id)RGB(248, 248, 248).CGColor];
    gradientLayer.locations = @[@0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = framH;
//    [self.view.layer addSublayer:gradientLayer];
    return gradientLayer;
}

+ (NSArray *)requestSettingBallScoreArr
{
//    NSArray *arrList = @[@[eLocalizedString(@"model_LanguageDisplay"), eLocalizedString(@"model_RedYellowCard")], @[eLocalizedString(@"model_EventPromptRange")], @[eLocalizedString(@"model_IndexShows"), eLocalizedString(@"model_IndexCompany")], @[eLocalizedString(@"model_sound"), eLocalizedString(@"model_Shock")], @[eLocalizedString(@"model_sound"), eLocalizedString(@"model_Shock")], @[eLocalizedString(@"model_CornerTip")]];
    NSArray *arrList = @[@[eLocalizedString(@"model_LanguageDisplay"), eLocalizedString(@"model_RedYellowCard")], @[eLocalizedString(@"model_EventPromptRange")], @[], @[eLocalizedString(@"model_sound"), eLocalizedString(@"model_Shock")], @[eLocalizedString(@"model_sound"), eLocalizedString(@"model_Shock")], @[eLocalizedString(@"model_CornerTip")]];
    return arrList;
}

+ (NSArray *)requestSettingBasketBallSArr
{
    NSArray *arrList = @[@[eLocalizedString(@"model_LanguageDisplay"), eLocalizedString(@"model_PreGameRankingsShow")], @[eLocalizedString(@"model_IndexShows"), eLocalizedString(@"model_IndexCompany")]];
    return arrList;
}


+ (NSString *)chooseFootGameLocation:(NSString *)typeN
{
    NSString *arrList = @"";
    if ([typeN isEqualToString:@"F"]) {
        
        arrList = eLocalizedString(@"foot_forward");
    }else if ([typeN isEqualToString:@"M"]) {
        
        arrList = eLocalizedString(@"foot_midfield");
    }else if ([typeN isEqualToString:@"D"]) {
        
        arrList = eLocalizedString(@"foot_defender");
    }else if ([typeN isEqualToString:@"G"]) {
        
        arrList = eLocalizedString(@"foot_goalkeeper");
    }
    return arrList;
}

+ (NSString *)chooseFootGameIcon:(NSString *)typeN
{
    NSString *name_St = @"";
    switch ([typeN intValue]) {
        case 1:
        {
            name_St = @"EventLiving_ruletag_1";
        }
            break;
        case 8:
        {
            name_St = @"EventLiving_ruletag_2";
        }
            break;
        case 9:
        {
            //换人
            name_St = @"EventLiving_ruletag_3";
        }
            break;
        case 100:
        {
            //换上
            name_St = @"EventLiving_ruletag_3on";
        }
            break;
        case 101:
        {
            //换下
            name_St = @"EventLiving_ruletag_3up";
        }
            break;
        case 4:
        {
            name_St = @"EventLiving_ruletag_4";
        }
            break;
        case 3:
        {
            name_St = @"EventLiving_ruletag_5";
        }
            break;
        case 2:
        {
            name_St = @"EventLiving_ruletag_6";
        }
            break;
        case 15:
        {
            name_St = @"EventLiving_ruletag_7";
        }
            break;
        case 19:
        {
            name_St = @"EventLiving_ruletag_8";
        }
            break;
        case 10:
        {
            name_St = @"EventLiving_ruletag_9";
        }
            break;
        case 17:
        {
            name_St = @"EventLiving_ruletag_10";
        }
            break;
        case 16:
        {
            name_St = @"EventLiving_ruletag_11";
        }
            break;
            
        default:
            break;
    }
    return name_St;
}

+ (NSString *)chooseTechnicalStatisticsName:(NSString *)name
{
    
    NSDictionary *dic_dic = @{@"goals":@"进球", @"penalty":@"点球", @"dribble":@"过人", @"dribble_succ":@"过人成功", @"clearances":@"解围", @"blocked_shots":@"有效阻挡", @"interceptions":@"拦截", @"tackles":@"抢断", @"passes":@"传球", @"passes_accuracy":@"传球成功", @"key_passes":@"关键传球", @"crosses":@"传中球", @"crosses_accuracy":@"传中球成功", @"long_balls":@"长传", @"long_balls_accuracy":@"成功长传", @"duels":@"1对1拼抢", @"duels_won":@"1对1拼抢成功", @"dispossessed":@"丢球", @"fouls":@"犯规", @"was_fouled":@"被侵犯", @"offsides":@"越位", @"yellow2red_cards":@"两黄变红", @"saves":@"扑救", @"punches":@"拳击球", @"runs_out":@"守门员出击", @"runs_out_succ":@"守门员出击成功", @"good_high_claim":@"高空出击"};
    
    NSString *name_st = [NSString stringWithFormat:@"%@", dic_dic[name]];
    if ([name_st containsString:@"null"]) {
        name_st = @"";
    }
    return name_st;
}

+ (NSString *)roundFloatMethod:(NSString *)name
{
    NSArray *cpm_arr = [name componentsSeparatedByString:@"."];
    if (cpm_arr.count == 2) {
        
        NSString *f_str = [NSString stringWithFormat:@"%@", cpm_arr[1]];
        if (f_str.length > 2) {
            float name_f = [name floatValue];
            float resulet_f = roundf(name_f*100)/100;
            return [NSString stringWithFormat:@"%.2f", resulet_f];
        }else {
            return name;
        }
    }else {
        return name;
    }
}

+ (UIImage *)imgResizableImageWithCapInsetsName:(NSString *)img
{
    UIImage *image = [UIImage imageNamed:img];
    CGFloat top = 10;
    CGFloat left = 15;
    CGFloat bottom = 10;
    CGFloat right = 15;
    /// 顶端、左端、底部、右端分别预留距离
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    //注意：拉伸之后一定要赋值回去
    image = [image  resizableImageWithCapInsets:insets
    resizingMode:UIImageResizingModeStretch];
    return image;
}

+ (UIImage *)imgCustomResizableImageWithCapInsetsName:(NSString *)img top:(CGFloat)topf left:(CGFloat)leftf bottom:(CGFloat)bottomf right:(CGFloat)rightf
{
    UIImage *image = [UIImage imageNamed:img];
    CGFloat top = topf;
    CGFloat left = leftf;
    CGFloat bottom = bottomf;
    CGFloat right = rightf;
    /// 顶端、左端、底部、右端分别预留距离
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    //注意：拉伸之后一定要赋值回去
    image = [image  resizableImageWithCapInsets:insets
    resizingMode:UIImageResizingModeStretch];
    return image;
}

+ (NSAttributedString *)AttributedStringTwoTogether:(NSString *)name All:(NSString *)nameAll nameFont:(UIFont *)nameF allFont:(UIFont *)allF nameColor:(UIColor *)nameColor allColor:(UIColor *)allColor
{

    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc]initWithString:nameAll];
    
    NSRange Range = NSMakeRange([nameAll rangeOfString:name].location, [nameAll rangeOfString:name].length);
    
    [nameString addAttribute:NSFontAttributeName value:nameF range:NSMakeRange(0, nameString.length)];
    
    [nameString addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, nameString.length)];
    
    [nameString addAttribute:NSForegroundColorAttributeName value:nameColor range:Range];
    
    return nameString;
}

+ (NSAttributedString *)AttributedStringLoginTogetherOne:(NSString *)name Two:(NSString *)name2 All:(NSString *)nameAll nameFont:(UIFont *)nameF allFont:(UIFont *)allF nameColor:(UIColor *)nameColor allColor:(UIColor *)allColor linkUrl:(NSString *)url1 linkUrl2:(NSString *)url2
{

    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc]initWithString:nameAll];
    
    NSRange Range = NSMakeRange([nameAll rangeOfString:name].location, [nameAll rangeOfString:name].length);
    
    NSRange Range2 = NSMakeRange([nameAll rangeOfString:name2].location, [nameAll rangeOfString:name2].length);
    
    [nameString addAttribute:NSFontAttributeName value:nameF range:NSMakeRange(0, nameString.length)];
    
    [nameString addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, nameString.length)];
    
    [nameString addAttribute:NSForegroundColorAttributeName value:nameColor range:Range];
    
    [nameString addAttribute:NSForegroundColorAttributeName value:nameColor range:Range2];
    
    [nameString addAttribute:NSLinkAttributeName value:url1 range:Range];
    
    [nameString addAttribute:NSLinkAttributeName value:url2 range:Range2];

    return nameString;
}


+(float)folderSizeAtPath
{
    NSString *folderPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSFileManager * manager=[NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) {
        return 0 ;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0 );
}

/**
 *  计算单个文件大小
 */
+(long long)fileSizeAtPath:(NSString *)filePath{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize];
    }
    return 0 ;
    
}

/**
 *  清理缓存
 */
+(void)cleanCache:(cleanCacheBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //文件路径
        NSFileManager *fileMger = [NSFileManager defaultManager];
        
        NSString *directoryPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        NSArray *subpaths = [fileMger contentsOfDirectoryAtPath:directoryPath error:nil];
        
        for (NSString *subPath in subpaths) {
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            [fileMger removeItemAtPath:filePath error:nil];
        }
        
    
        NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *directoryDPath = [pathArray lastObject];
        
        NSArray *subpathsD = [fileMger contentsOfDirectoryAtPath:directoryDPath error:nil];
        
        for (NSString *subPathD in subpathsD) {
            NSString *filePathD = [directoryPath stringByAppendingPathComponent:subPathD];
            BOOL bRet = [fileMger fileExistsAtPath:filePathD];
            if (bRet) {
                [[NSFileManager defaultManager] removeItemAtPath:filePathD error:nil];
            }
        }
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)stringWithJsonDictionary:(NSDictionary *)jsonDic
{
    if (jsonDic == nil) {
        return @"";
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (parseError) {
        return @"";
    }
    return jsonStr;
}



/**
 * 将 uint64_t 时间戳转换为本地时间字符串
 * @param timestamp 时间戳 (需确认单位是秒还是毫秒)
 * @param isMilliseconds YES表示毫秒, NO表示秒
 * @return 格式化后的时间字符串
 */
+ (NSString *)convertCustomTimestampToDateString:(uint64_t)timestamp isMilliseconds:(BOOL)isMilliseconds {
    if (timestamp == 0) {
        return @"";
    }
    
    // 1. 确定 NSTimeInterval (秒)
    NSTimeInterval timeInterval;
    if (isMilliseconds) {
        timeInterval = timestamp / 1000.0;
    } else {
        timeInterval = (NSTimeInterval)timestamp;
    }
    
    // 2. 创建 NSDate 对象
    // dateWithTimeIntervalSince1970 默认基于 UTC 时间戳创建 NSDate 对象
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // 3. 格式化输出
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时区为当前系统时区（自动处理 UTC+8 等偏移）
    formatter.timeZone = [NSTimeZone systemTimeZone];
    // 设置日期格式，可根据需求调整，如 @"yyyy/MM/dd HH:mm"
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


@end
