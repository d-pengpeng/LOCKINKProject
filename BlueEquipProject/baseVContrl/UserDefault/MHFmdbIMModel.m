//
//  MHFmdbIMModel.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/7/17.
//

#import "MHFmdbIMModel.h"
#import "FMDB.h"

@interface MHFmdbIMModel()

@property(nonatomic,strong) FMDatabase *fmDB;
@end
@implementation MHFmdbIMModel

+ (instancetype)sharedInstance
{
    static MHFmdbIMModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MHFmdbIMModel alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        self.fmDB = [[FMDatabase alloc] initWithPath:[self cachePathStr]];
        // 3> 打开数据库
        if ([self.fmDB open])
        {
            // 4> 创建表格
//            BOOL isSuccess = [self.fmDB executeUpdate:CREATE_TABLE];
//            NSLog(@"%d",isSuccess);
        }
        else
        {
//            NSLog(@"打开失败");
        }
        
    }
    return self;
}

#pragma mark 缓存路径
- (NSString *)cachePathStr
{
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/IMProfile",cacheFolder];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    // 1> 获取Document路径
    NSString *path = [NSString stringWithFormat:@"%@/IMProfile/IMData.db",cacheFolder];
    
    return path;
}


@end
/*
 
 - (instancetype)init
 {
     self = [super init];
     if (self)
     {
         // 1> 获取Document路径
         NSString *path = [self cachePath];
         
         // NSLog(@"---------%@",path);
         // 2> 初始化FMDB
         self.fmDB = [[FMDatabase alloc] initWithPath:path];
         // 3> 打开数据库
         if ([self.fmDB open])
         {
             // 4> 创建表格
             BOOL isSuccess = [self.fmDB executeUpdate:CREATE_TABLE];
             NSLog(@"%d",isSuccess);
         }
         else
         {
 //            NSLog(@"打开失败");
         }
         
     }
     return self;
 }

 + (void)cacheImage:(NSData *)imageData imageURL:(NSString *)imageUrl
 {
     NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
     
     NSString *filePath = [NSString stringWithFormat:@"%@/maintenImages",cacheFolder];
     
     if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
         [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
     } else {
         //        NSLog(@"FileDir is exists.");
     }
     
     // 1> 获取Document路径
     NSString *path = [NSString stringWithFormat:@"%@/maintenImages/%@.jpg",cacheFolder,imageUrl];
     
     //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
     [imageData writeToFile:path atomically:YES];
 }

 + (NSString *)imageURL:(NSString *)imageName
 {
     NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
     // 1> 获取Document路径
     NSString *path = [NSString stringWithFormat:@"%@/maintenImages/%@.jpg",cacheFolder,imageName];
     
     return path;
 }


 #pragma mark 缓存路径
 - (NSString *)cachePath
 {
     NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
     
     NSString *filePath = [NSString stringWithFormat:@"%@/Profile",cacheFolder];
     
     if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
         [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
     } else {
 //        NSLog(@"FileDir is exists.");
     }
     
     // 1> 获取Document路径
     NSString *path = [NSString stringWithFormat:@"%@/Profile/Img.db",cacheFolder];
     
     return path;
 }

 #pragma mark 插入图片到数据库
 - (void)insertImageToDB:(NSData *)imageData imageURL:(NSString *)imageUrl
 {
     sqlite3 *db = NULL;
     sqlite3_stmt *sqlStatement = NULL;
     do {
         if (!(sqlite3_open([[self cachePath] UTF8String], &db) == SQLITE_OK)) {
 //            NSLog(@"An error has occurred.");
             break;
         }
         
         const char *insertSQL = "Insert or ignore into img_cache(imageUrl, imageData) VALUES(?,?);";
         
         if (sqlite3_prepare_v2(db, insertSQL, -1, &sqlStatement, NULL) != SQLITE_OK) {
 //            NSLog(@"Problem with prepare statement");
             break;
         }
         sqlite3_bind_text(sqlStatement, 1, [imageUrl UTF8String], -1, SQLITE_TRANSIENT);
         sqlite3_bind_blob(sqlStatement, 2, [imageData bytes], (int)[imageData length], SQLITE_TRANSIENT);
         
         if(sqlite3_step(sqlStatement)==SQLITE_DONE){
         }
         
     } while (NO);
     
     if (sqlStatement) {
         sqlite3_finalize(sqlStatement);
 //        NSLog(@"----------图片缓存完成--------");
     }
     sqlite3_close(db);
 }


 #pragma mark 从数据库获取图片
 - (NSData *)imageFromDB:(NSString *)imageUrl
 {
     sqlite3 *db = NULL;
     
     NSData *image = [[NSData alloc]init];
     
     @try {
         NSFileManager *fileMgr = [NSFileManager defaultManager];
         
         NSString * dbPath = [self cachePath];
         
         BOOL success = [fileMgr fileExistsAtPath:dbPath];
         if (!success) {
             //Cannot locate database file '%@'.", dbPath);
         }
         
         if (!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK)) {
             //An error has occurred.");
         }
         
         NSString *sql=[NSString stringWithFormat: @"SELECT imageData FROM img_cache where imageUrl = \"%@\"", imageUrl];
         
         sqlite3_stmt *sqlStatement = NULL;
         if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &sqlStatement, NULL) != SQLITE_OK) {
             //Problem with prepare statement");
         }
         
         while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
             const char *raw = sqlite3_column_blob(sqlStatement, 0);
             int rawLen = sqlite3_column_bytes(sqlStatement, 0);
             image = [NSData dataWithBytes:raw length:rawLen];
         }
     }
     @catch (NSException *exception) {
         //An exception occurred: %@", [exception reason]);
     }
     @finally {
         sqlite3_close(db);
 //        NSLog(@"[---获取缓存图片成功---]");
         return image;
     }
     
 }

 - (void)deleteImgeWithUrl:(NSString *)imageUrl
 {
     NSString *sql = [NSString stringWithFormat: @"SELECT * FROM img_cache where imageUrl = \"%@\"", imageUrl];
     NSArray *result = [self requestDataWithSQL:sql];
     NSDictionary *dict = result.lastObject;
     
     // 查询－删除
     NSString *sql_del = [NSString stringWithFormat:@"delete from img_cache where id = %@", dict[@"id"]];
     BOOL isSuccess = [self.fmDB executeQuery:sql_del];
     NSLog(@"移除图片-------%@",isSuccess?@"成功":@"失败");
 }

 #pragma mark 删除数据
 - (NSArray *)requestDataWithSQL:(NSString *)sql
 {
     FMResultSet *result = [self.fmDB executeQuery:sql];
     
     NSMutableArray *arr = [NSMutableArray array];
     while ([result next])
     {
         NSDictionary *dic = [result resultDictionary];
         [arr addObject:dic];
     }
     return [NSArray arrayWithArray:arr];
 }
 
 */
