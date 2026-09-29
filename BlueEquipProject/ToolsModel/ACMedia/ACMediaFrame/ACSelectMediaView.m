//
//  ACSelectMediaView.m
//
//  Created by caoyq on 16/12/22.
//  Copyright © 2016年 ArthurCao. All rights reserved.
//

#import "ACSelectMediaView.h"
#import "ACMediaImageCell.h"
#import "ACShowMediaTypeView.h"
#import "ACMediaManager.h"
#import "TZImagePickerController.h"
#import "MWPhotoBrowser.h"
#import "UIImage+Resize.h"

@interface ACSelectMediaView ()<UICollectionViewDelegate, UICollectionViewDataSource, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MWPhotoBrowserDelegate>
{
    UIViewController *rootVC;
    MWPhotoBrowser *mWPhotoBrowser;
}



@property (nonatomic, copy) ACMediaHeightBlock block;
@property (nonatomic, copy) ACSelectMediaBackBlock backBlock;

/** MWPhoto对象数组 */
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation ACSelectMediaView

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _mediaArray = [NSMutableArray array];
        rootVC = [UIApplication sharedApplication].windows.firstObject.rootViewController;//[[UIApplication sharedApplication] keyWindow].rootViewController;
        [self configureCollectionView];
    }
    return self;
}

-(void)setMediaArray:(NSMutableArray *)mediaArray{
    _mediaArray = mediaArray;
    [self.collectionView reloadData];
}

- (void)configureCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((_window_width-10*2-5*3)/4, (_window_width-10*2-5*3)/4);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    [_collectionView registerClass:[ACMediaImageCell class] forCellWithReuseIdentifier:NSStringFromClass([ACMediaImageCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
}

#pragma mark - public method

- (void)observeViewHeight:(ACMediaHeightBlock)value {
    _block = value;
}

- (void)observeSelectedMediaArray: (ACSelectMediaBackBlock)backBlock {
    _backBlock = backBlock;
}

+ (CGFloat)defaultViewHeight {
    return ACMedia_ScreenWidth/4;
}

#pragma mark -  Collection View DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mediaArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACMediaImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ACMediaImageCell class]) forIndexPath:indexPath];
    if (indexPath.row == _mediaArray.count) {
        cell.icon.image = [UIImage imageNamed:@"ACMediaFrame.bundle/AddMedia"];
        cell.videoImageView.hidden = YES;
        cell.deleteButton.hidden = YES;
    }else{
        ACMediaModel *model = [[ACMediaModel alloc] init];
        model = _mediaArray[indexPath.row];
        if ([NSString stringWithFormat:@"%@",model.mediaURL].length > 0) {
//            [cell.icon setImageWithURL:model.mediaURL placeholderImage:[UIImage imageNamed:@"banner_moren"]];
            [cell.icon sd_setImageWithURL:model.mediaURL placeholderImage:[UIImage imageNamed:@"banner_moren"]];
        }else{
            cell.icon.image = model.image;
        }
        
        cell.videoImageView.hidden = !model.isVideo;
        cell.deleteButton.hidden = NO;
        [cell setACMediaClickDeleteButton:^{
            [self.mediaArray removeObjectAtIndex:indexPath.row];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self layoutCollection:@[]];
            });
        }];
    }
    return cell;
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5,10);
}

#pragma mark - collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //回收键盘
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [[UIApplication sharedApplication].windows.firstObject endEditing:YES];
    
    if (indexPath.row == _mediaArray.count && _mediaArray.count >= 4) {
        [UIAlertController showAlertWithTitle:@"最多只能选择4张" message:nil actionTitles:@[@"确定"] cancelTitle:nil style:UIAlertControllerStyleAlert completion:nil];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    //点击的是添加媒体的按钮
    if (indexPath.row == _mediaArray.count) {
        switch (_type) {
            case ACMediaTypePhoto:
                [self openAlbum];
                break;
            case ACMediaTypePhotoAndCamera:
            {
                [UIAlertController showAlertWithTitle:@"选择图片来源" message:nil actionTitles:@[@"本地相册", @"拍照"] cancelTitle:@"取消" style:UIAlertControllerStyleActionSheet completion:^(NSInteger index) {
                    if (index == 0) {
                        [weakSelf openAlbum];
                    }else {
                        [weakSelf openCamera];
//                        [weakSelf openVideotape];
                    }
                }];
            }
                break;
            default:
            {
                ACShowMediaTypeView *fileView = [[ACShowMediaTypeView alloc] init];
                [fileView show];
                [fileView selectedIndexBlock:^(NSInteger itemIndex) {
                    if (itemIndex == 0) {
                        [weakSelf openAlbum];
                    }else if (itemIndex == 1) {
                        [weakSelf openCamera];
                    }else if (itemIndex == 2) {
                        [weakSelf openVideotape];
                    }else {
                        [weakSelf openVideo];
                    }
                }];
            }
                break;
        }
    }
    //展示媒体
    else {
        _photos = [NSMutableArray array];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayActionButton = NO;//no
        browser.alwaysShowControls = NO;
        browser.displaySelectionButtons = NO;
        browser.zoomPhotosToFill = YES;
        browser.displayNavArrows = NO;//no
        browser.startOnGrid = NO;
        browser.enableGrid = YES;
        browser.canDeleteFile = YES;
        for (ACMediaModel *model in _mediaArray) {
            MWPhoto *photo;
            if ([NSString stringWithFormat:@"%@",model.mediaURL].length > 0) {
                photo = [MWPhoto photoWithURL:model.mediaURL];
            }else{
                photo = [MWPhoto photoWithImage:model.image];
            }
            
            photo.caption = model.name;
            if (model.isVideo) {//model.mediaURL
                if (model.mediaURL) {//http://192.168.0.4:8080/upload/video/20170308/1488955084581056822.mov
                    photo.videoURL = [NSURL URLWithString:@"http://192.168.0.4:8080/upload/video/20170310/1489137918457010727.mp4"];//http://v.cctv.com/flash/mp4video6/TMS/2011/01/05/cf752b1c12ce452b3040cab2f90bc265_h264818000nero_aac32-1.mp4
                }else {
                    photo = [photo initWithAsset:model.asset targetSize:CGSizeZero];
                }
            }
            [_photos addObject:photo];
        }
        [browser setCurrentPhotoIndex:indexPath.row];
        mWPhotoBrowser = browser;
        [[self viewController].navigationController pushViewController:browser animated:YES];
    }
}

#pragma mark - <MWPhotoBrowserDelegate>

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index{
    NSLog(@"index = %ld",index);
    
    [self.photos removeObjectAtIndex:index];
    [_mediaArray removeObjectAtIndex:index];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self layoutCollection:@[]];
    });
    if (self.photos.count == 0) {
        
        [self.collectionView reloadData];
        [mWPhotoBrowser popBackTo];
        
    }
    [mWPhotoBrowser reloadData];
}

-(void)photoBrowserDidFinishBack:(MWPhotoBrowser *)photoBrowser{
    [self.collectionView reloadData];
}

#pragma mark - 布局

///添加选中的image，然后重新布局collectionview
- (void)layoutCollection: (NSArray *)images {
    [_mediaArray addObjectsFromArray:images];
    NSInteger allImageCount = _mediaArray.count + 1;
    NSInteger maxRow = (allImageCount - 1) / 4 + 1;
    maxRow = 1;
    _collectionView.height = maxRow * ACMedia_ScreenWidth/4;
    self.height = _collectionView.height;
    //block回调
    !_block ?  : _block(_collectionView.height);
    !_backBlock ?  : _backBlock(_mediaArray);
    
    [_collectionView reloadData];
}

#pragma mark - actions

/** 相册 */
- (void)openAlbum {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 - _mediaArray.count delegate:self];
    ///是否 在相册中显示拍照按钮
    imagePickerVc.allowTakePicture = NO;
    ///是否可以选择显示原图
    imagePickerVc.allowPickingOriginalPhoto = NO;
    ///是否 在相册中可以选择视频
    imagePickerVc.allowPickingVideo = NO;
    [rootVC presentViewController:imagePickerVc animated:YES completion:nil];
}

/** 相机 */
- (void)openCamera {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;

    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        if(iOS8Later) {
            picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [rootVC presentViewController:picker animated:YES completion:nil];
    }else{
        [UIAlertController showAlertWithTitle:@"该设备不支持拍照" message:nil actionTitles:@[@"确定"] cancelTitle:nil style:UIAlertControllerStyleAlert completion:nil];
    }
}

/** 录像 */
- (void)openVideotape {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray * mediaTypes =[UIImagePickerController  availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = YES;
        picker.mediaTypes = mediaTypes;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        picker.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
        picker.videoMaximumDuration = 600.0f; //录像最长时间
        if(iOS8Later) {
            picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [rootVC presentViewController:picker animated:YES completion:nil];
    } else {
        [UIAlertController showAlertWithTitle:@"当前设备不支持录像" message:nil actionTitles:@[@"确定"] cancelTitle:nil style:UIAlertControllerStyleAlert completion:nil];
    }
    

}

/** 视频 */
- (void)openVideo {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
    picker.allowsEditing = YES;
    UIViewController *vc = [UIApplication sharedApplication].windows.firstObject.rootViewController;//[[UIApplication sharedApplication] keyWindow].rootViewController;
    [vc presentViewController:picker animated:YES completion:nil];
}

#pragma mark - TZImagePickerController Delegate

//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    
    NSMutableArray *models = [NSMutableArray array];
    for (NSInteger index = 0; index < assets.count; index++) {
        
//        UIImage *newImage = [self imageWithImageSimple:photos[index] scaledToSize:CGSizeMake(500, 500)];
        NSData *dataImageback = [UIImage reSizeImageData:photos[index] maxImageSize:800 maxSizeWithKB:1024];
        UIImage *newImage = [UIImage imageWithData: dataImageback];
        
        
        CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
        NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
        uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSURL *url = [self saveImage:newImage WithName:uuidString];
        
        PHAsset *asset = assets[index];
        [ACMediaManager getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
            ACMediaModel *model = [[ACMediaModel alloc] init];
            model.name = name;
            model.uploadType = pathData;
            model.image = photos[index];
            model.mediaURL = url;
            [models addObject:model];
            if (index == assets.count - 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self layoutCollection:models];
                });
            }
        }];
    }
}

///选取视频后的回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset info:(NSDictionary *)info{
    NSLog(@"视频info = %@",info);
    NSString *videoAssetURL = [info objectForKey:@"PHImageFileSandboxExtensionTokenKey"];
    NSArray *array = [videoAssetURL componentsSeparatedByString:@";"];
    NSURL *url = [NSURL fileURLWithPath:[array lastObject]];
//    
//    NSString *url_catch = [self compressedVideoOtherMethodWithURL:url compressionType:@"AVAssetExportPresetMediumQuality" filePath:[array lastObject]];
    
//    NSString *cath = [self uploadVideoWithOperaitons:nil withVideoPath:url];
    
    [ACMediaManager getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
        ACMediaModel *model = [[ACMediaModel alloc] init];
        model.name = name;
        model.uploadType = pathData;
        model.image = coverImage;
        model.isVideo = YES;
        model.asset = asset;
        model.mediaURL = url;//
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutCollection:@[model]];
        });
    }];
}

#pragma mark - UIImagePickerController Delegate
///拍照、选视频图片、录像 后的回调（这种方式选择视频时，会自动压缩，但是很耗时间）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    //媒体类型
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //原图URL
    NSURL *imageAssetURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    ///视频 和 录像
    if ([mediaType isEqualToString:@"public.movie"]) {
        
        NSURL *videoAssetURL = [info objectForKey:UIImagePickerControllerMediaURL];
        PHAsset *asset;
        //录像没有原图 所以 imageAssetURL 为nil
        if (imageAssetURL) {
            PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetURL] options:nil];
            asset = [result firstObject];
        }
        [ACMediaManager getVideoPathFromURL:videoAssetURL PHAsset:asset enableSave:NO completion:^(NSString *name, UIImage *screenshot, id pathData) {
            ACMediaModel *model = [[ACMediaModel alloc] init];
            model.image = screenshot;
            model.name = name;
            model.uploadType = pathData;
            model.isVideo = YES;
            model.mediaURL = videoAssetURL;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self layoutCollection:@[model]];
            });
        }];
    }
    
    else if ([mediaType isEqualToString:@"public.image"]) {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        //如果 picker 没有设置可编辑，那么image 为 nil
        if (image == nil) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        PHAsset *asset;
        //拍照没有原图 所以 imageAssetURL 为nil
        if (imageAssetURL) {
            PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[imageAssetURL] options:nil];
            asset = [result firstObject];
        }
        
        [ACMediaManager getImageInfoFromImage:image PHAsset:asset completion:^(NSString *name, NSData *data) {
            
//            UIImage *newImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(500, 500)];
            NSData *dataImageback = [UIImage reSizeImageData:image maxImageSize:600 maxSizeWithKB:1024];
            UIImage *newImage = [UIImage imageWithData: dataImageback];
            
            CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
            NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
            uuidString = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSURL *url = [self saveImage:newImage WithName:uuidString];
            
            ACMediaModel *model = [[ACMediaModel alloc] init];
            model.image = image;
            model.name = name;
            model.uploadType = data;
            model.mediaURL = url;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self layoutCollection:@[model]];
            });
        }];
    }
}

-(NSURL *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName{
    NSURL *temp;
    NSData* imageData = UIImageJPEGRepresentation(tempImage, 1.0f);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [NSString stringWithFormat:@"%@.png",[documentsDirectory stringByAppendingPathComponent:imageName]];
    [imageData writeToFile:fullPathToFile atomically:NO];
    temp = [NSURL fileURLWithPath:fullPathToFile];
    return temp;
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSString *)compressedVideoOtherMethodWithURL:(NSURL *)url  compressionType:(NSString *)compressionType filePath:(NSString *)filePath{
    
    NSString *resultPath;
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    // 所支持的压缩格式中是否有 所选的压缩格式
    if ([compatiblePresets containsObject:compressionType]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:compressionType];
        
        
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyyMMddHHmmss"];
        NSString *_fileName = [NSString stringWithFormat:@"output-%@.mp4",[formater stringFromDate:[NSDate date]]];
        NSString  *_outfilePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", _fileName];
        
//        NSFileManager *manager = [NSFileManager defaultManager];
//        
//        NSArray *array = [filePath componentsSeparatedByString:@"/"];
//        filePath = [filePath stringByReplacingOccurrencesOfString:[array lastObject] withString:@""];
//        
//        BOOL isExists = [manager fileExistsAtPath:filePath];
//        
//        if (!isExists) {
//            
//            [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
//        }
        
//        NSInteger num = random()%1000;
        
        
        
//        resultPath = [NSString stringWithFormat:@"%@%@",filePath,[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"outputJFVideo-%@.mp4",[NSNumber numberWithInteger:num]]]];
        
        NSLog(@"resultPath = %@",_outfilePath);
        
        exportSession.outputURL = [NSURL fileURLWithPath:_outfilePath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             if (exportSession.status == AVAssetExportSessionStatusCompleted) {
                 
                 NSData *data = [NSData dataWithContentsOfFile:_outfilePath];
                 
                 float memorySize = (float)data.length / 1024 / 1024;
                 NSLog(@"视频压缩后大小 %f", memorySize);
//                 self.fileVideoImage.image = [self thumbnailImageForVideo:[NSURL fileURLWithPath:resultPath] atTime:1];
//                 
//                 [self playVideowithUrl:[NSURL fileURLWithPath:resultPath]];
                 
             } else {
                 
                 NSLog(@"压缩失败");
             }
             
             
         }];
        
        return _outfilePath;
        
    } else {
        NSLog(@"不支持 %@ 格式的压缩", compressionType);
        return nil;
    }
}

-(NSString *)uploadVideoWithOperaitons:(NSDictionary *)operations withVideoPath:(NSURL *)URL_videoPath
{
    
    
    /**获得视频资源*/
    
    AVURLAsset * avAsset = [AVURLAsset assetWithURL:URL_videoPath];
    
    /**压缩*/
    
    //    NSString *const AVAssetExportPreset640x480;
    //    NSString *const AVAssetExportPreset960x540;
    //    NSString *const AVAssetExportPreset1280x720;
    //    NSString *const AVAssetExportPreset1920x1080;
    //    NSString *const AVAssetExportPreset3840x2160;
    
    AVAssetExportSession  *  avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
    
    /**创建日期格式化器*/
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    /**转化后直接写入Library---caches*/
    
    NSString *  videoWritePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/output-%@.mp4",[formatter stringFromDate:[NSDate date]]]];
    
    
    avAssetExport.outputURL = [NSURL fileURLWithPath:videoWritePath];
    
    
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    
    
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^(void){
        
        
//        switch ([avAssetExport status]) {
//                
//            case AVAssetExportSessionStatusCompleted:
//            {
//                NSLog(@"成功！");
//                
//            }
//                break;
//            case AVAssetExportSessionStatusFailed:
//            {
//                NSLog(@"失败！");
//            }
//                break;
//            default:
//                break;
//        }
        if ([avAssetExport status] == AVAssetExportSessionStatusCompleted) {
            NSLog(@"成功！");
            
        }else{
            NSLog(@"失败！");
        }
        
        
    }];
    return videoWritePath;
}


@end
