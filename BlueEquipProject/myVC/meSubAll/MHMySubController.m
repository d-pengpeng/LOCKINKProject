//
//  MHMySubController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/9.
//

#import "MHMySubController.h"
#import "MHfindSubPatternsCell.h"
#import "MHfindSubPatternsModel.h"
#import "MWPhotoBrowser.h"
#import "MHSquareRankingController.h"

#import "LFImagePickerController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PopBottomView.h"
#import "MHEquipmenMeCell.h"
#import "MHMyPhotoCell.h"
#import "MHDetailEquipmentController.h"
#import "MHfindDetailController.h"
#import "MHPlaceVCell.h"

@interface MHMySubController ()<UITableViewDelegate, UITableViewDataSource, MHfindSubPatternsCelDelaget, MWPhotoBrowserDelegate, LFImagePickerControllerDelegate, MHMyPhotoCellDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) int pageN;

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) UIView *topVVV;
@property (nonatomic, copy) NSString *two_categoy;
@property (nonatomic, assign) BOOL isPhotBo;
@property (nonatomic, strong) NSMutableArray *arr_imgs;
@property (nonatomic, copy) NSString *img_idid;
@end

@implementation MHMySubController

- (NSMutableArray *)datasMut
{
    if (!_datasMut) {
        _datasMut = [NSMutableArray array];
    }
    return _datasMut;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    self.view.backgroundColor = RGB(1, 0, 2);
    self.img_idid = @"";
    self.arr_imgs = [NSMutableArray array];
    self.photos = [NSMutableArray array];
    [self configCollectView];
    
    self.pageN = 1;
    [self loadrefreshing];
    
}

- (void)publishBtnMethod
{
    if(self.isPhotBo) {
        return;
    }
    self.isPhotBo = YES;
    LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:10 delegate:self];
    //根据需求设置
    imagePicker.allowTakePicture = NO;
    imagePicker.maxVideosCount = 0; /** 解除混合选择- 要么1个视频，要么9个图片 */
    imagePicker.supportAutorotate = NO; /** 适配横屏 */
    imagePicker.allowPickingType = LFPickingMediaTypePhoto;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        imagePicker.syncAlbum = YES; /** 实时同步相册 */
    }
    imagePicker.doneBtnTitleStr = eLocalizedString(@"home_ok"); //最终确定按钮名称
    imagePicker.cancelBtnTitleStr = eLocalizedString(@"home_Cancel");
    imagePicker.previewBtnTitleStr = eLocalizedString(@"home_preview");
    imagePicker.fullImageBtnTitleStr = eLocalizedString(@"home_MasterDrawing");
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)lf_imagePickerControllerDidCancel:(LFImagePickerController *)picker
{
    self.isPhotBo = NO;
}

- (void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingResult:(NSArray<LFResultObject *> *)results
{
    NSMutableArray *arMut = [NSMutableArray array];
    
    for (NSInteger i = 0; i < results.count; i++) {
        LFResultObject *result = results[i];
        if ([result isKindOfClass:[LFResultImage class]]) {
           
            LFResultImage *resultImage = (LFResultImage *)result;
            NSData *dataImg = UIImageJPEGRepresentation(resultImage.originalImage, 0.9);
            [arMut addObject:dataImg];
        }
    }
    if(arMut.count > 0) {
        [SVProgressHUD show];
        
        [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            [LYUserDefault saveQCloudDic:info];
            
            [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:1 andImageData:arMut success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                NSArray *oneAr = info;
                NSString *urlMM = @"";
                for (NSString *liUrl in oneAr) {
                    if(urlMM.length > 0) {
                        urlMM = [NSString stringWithFormat:@"%@,%@", urlMM, liUrl];
                    }else {
                        urlMM = liUrl;
                    }
                }
                if(urlMM.length>0) {
                    [self uploadRequestMMM:urlMM];
                }else {
                    self.isPhotBo = NO;
                    [SVProgressHUD dismiss];
                }
            } fail:^(NSString * _Nonnull msg) {
                [SVProgressHUD dismiss];
            }];
        } fail:^(NSString * _Nonnull msg) {
            self.isPhotBo = NO;
            [SVProgressHUD dismiss];
        }];
        
    }else {
        self.isPhotBo = NO;
    }
}

- (void)uploadRequestMMM:(NSString *)url_len
{
    [requestToolClass postNetworkWithUrl:request_album_upload andParameter:@{@"urls":url_len} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postPhotoListUploadNotif" object:nil];
        self.isPhotBo = NO;
    } fail:^(NSString * _Nonnull msg) {
        self.isPhotBo = NO;
    }];
}

- (void)configCollectView
{
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-NAVHEIGHT-44) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    _appTableView.dragInteractionEnabled = YES;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHfindSubPatternsCell class] forCellReuseIdentifier:@"MHfindSubPatternsCell"];
    [self.appTableView registerClass:[MHMyPhotoCell class] forCellReuseIdentifier:@"MHMyPhotoCell"];
    [self.appTableView registerClass:[MHEquipmenMeCell class] forCellReuseIdentifier:@"MHEquipmenMeCell"];
    [self.appTableView registerClass:[MHPlaceVCell class] forCellReuseIdentifier:@"MHPlaceVCell"];
    [self.view addSubview:_appTableView];
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-NAVHEIGHT-44)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    if(self.cageId == 1) {
        UIButton *sureBBB = [HistoryRecordModel createImgBtn];
        sureBBB.frame = CGRectMake((_window_width-168)/2, _window_height-NAVHEIGHT-44-38-TARBARHEIGHT-62, 168, 42);
        [sureBBB setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
        [sureBBB setTitle:eLocalizedString(@"me_allNames12") forState:UIControlStateNormal];
        [sureBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        sureBBB.titleLabel.font = SYS_Font(14);
        [sureBBB addTarget:self action:@selector(publishBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureBBB];
    }
}

- (void)booToBoo:(BOOL)booM arrMut:(nonnull NSArray *)arr
{
    if(booM) {
        if(self.appTableView == nil) {
            self.datasMut = [NSMutableArray array];
            [self configCollectView];
        }
        [self.datasMut removeAllObjects];
        if(self.datasMut.count <= 0) {
            for (int i=0; i<arr.count; i++) {
                [self.datasMut addObject:arr[i]];
            }
            [self.appTableView reloadData];
        }
        self.appTableView.scrollEnabled = YES;
        self.appTableView.showsVerticalScrollIndicator = YES;
        
    }else {
        if(self.appTableView == nil) {
            self.datasMut = [NSMutableArray array];
            [self configCollectView];
        }
        [self.datasMut removeAllObjects];
        for (int i=0; i<arr.count; i++) {
            [self.datasMut addObject:arr[i]];
        }
        [self.appTableView reloadData];
        self.appTableView.scrollEnabled = NO;
        self.appTableView.showsVerticalScrollIndicator = NO;
    }
    
    if(self.datasMut.count <= 0) {
        [self.appTableView.mj_footer setHidden:YES];
        self.noDataImgV.hidden = NO;
    }else {
        [self.appTableView.mj_footer setHidden:NO];
        self.noDataImgV.hidden = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
 
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;

    if(bounds.size.height > size.height) {
        h = bounds.size.height;
    }
    float reload_distance = 10;
    if(y > h + reload_distance) {
        
        self.appTableView.scrollEnabled = YES;
        self.appTableView.showsVerticalScrollIndicator = YES;
        
    }else {

        if(offset.y <= 0) {
            self.appTableView.contentOffset = CGPointZero;
            self.appTableView.scrollEnabled = NO;
            self.appTableView.showsVerticalScrollIndicator = NO;
        }
    }
}


-(void)loadrefreshing {
    
    WEAKSELF
    self.appTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadFootData];
    }];
}

- (void)loadHeadData {
    
    self.pageN = 1;
    [self RequestListData];
}

- (void)loadFootData {
    
    self.pageN ++;
    [self RequestListData];
}

- (void)RequestListData
{
    NSString *url_url = request_square_pageRecommendedActivity;
    NSDictionary *dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"userId":self.othrerId};
    if(self.cageId == 1){
        url_url = request_user_pageTimelineAlbum;
    }else if (self.cageId == 2) {
        url_url = request_album_pageOwnToysActivity;
    }else if (self.cageId == 3) {
        url_url = request_device_pageDevice;
    }
    
    [requestToolClass postNetworkWithUrl:url_url andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            
            if(self.pageN == 1) {
                [self.datasMut removeAllObjects];
            }
            NSArray *listAr = info[@"records"];
            if((self.cageId == 0) || (self.cageId == 2)) {
                for (NSDictionary *dicM in listAr) {
                    MHfindSubPatternsModel *model = [MHfindSubPatternsModel mj_objectWithKeyValues:dicM];
                    [self.datasMut addObject:model];
                }
            }else {
                for (NSDictionary *dciM in listAr) {
                    [self.datasMut addObject:dciM];
                }
            }
            
            if(listAr <= 0) {
                [self.appTableView.mj_header endRefreshing];
                [self.appTableView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [self.appTableView.mj_header endRefreshing];
                [self.appTableView.mj_footer endRefreshing];
            }
            if(self.datasMut.count>0) {
                self.noDataImgV.hidden = YES;
                [self.appTableView.mj_footer setHidden:NO];
            }else {
                self.noDataImgV.hidden = NO;
                [self.appTableView.mj_footer setHidden:YES];
            }
            [self.appTableView reloadData];
        }else {
            [self.appTableView.mj_header endRefreshing];
            [self.appTableView.mj_footer endRefreshing];
        }
    } fail:^(NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 1) {
        return 1;
    }else {
        return self.datasMut.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        
        MHPlaceVCell *cell = [MHPlaceVCell cellWithTabelView:tableView];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        if(self.cageId == 1) {
            MHMyPhotoCell *cell = [MHMyPhotoCell cellWithTabelView:tableView];
            [cell addDataToModel:self.datasMut[indexPath.row]];
            cell.delegate_ = self;
            cell.backgroundColor = UIColor.clearColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(self.cageId == 2) {
            MHfindSubPatternsCell *cell = [MHfindSubPatternsCell cellWithTabelView:tableView];
            [cell addDataToMeDic:self.datasMut[indexPath.row] row:indexPath typMethod:1];
            cell.delegate_ = self;
            cell.backgroundColor = UIColor.clearColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(self.cageId == 3) {
            MHEquipmenMeCell *cell = [MHEquipmenMeCell cellWithTabelView:tableView];
            [cell addDataToModel:self.datasMut[indexPath.row]];
            cell.backgroundColor = UIColor.clearColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            MHfindSubPatternsCell *cell = [MHfindSubPatternsCell cellWithTabelView:tableView];
            [cell addDataToMeDic:self.datasMut[indexPath.row] row:indexPath typMethod:0];
            cell.delegate_ = self;
            cell.backgroundColor = UIColor.clearColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0) {
        
        if(self.cageId == 3) {
            MHDetailEquipmentController *vc = [[MHDetailEquipmentController alloc] init];
            vc.dicM = self.datasMut[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (self.cageId == 2) {
            
            MHfindSubPatternsModel *model = self.datasMut[indexPath.row];
            MHfindDetailController *vc = [[MHfindDetailController alloc] init];
            vc.modelM = model;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (self.cageId == 0) {
            MHfindSubPatternsModel *model = self.datasMut[indexPath.row];
            model.type = @"ACTIVITY";
            MHfindDetailController *vc = [[MHfindDetailController alloc] init];
            vc.modelM = model;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

//MARK: 相册查看
- (void)myPhotoCellDelegateMethodNum:(NSInteger)tagL arr:(NSArray *)arrM
{
    [self.photos removeAllObjects];
    [self.arr_imgs removeAllObjects];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;//no
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;//no
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    browser.canDeleteFile = YES;
    
    for (NSDictionary *model in arrM) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:model[@"url"]]];
        photo.caption = eLocalizedString(@"plaza_all20");
        [_photos addObject:photo];
        [self.arr_imgs addObject:minStr(model[@"id"])];
    }
    [browser setCurrentPhotoIndex:tagL];
    [self.navigationController pushViewController:browser animated:YES];
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index
{
//    if(self.isPhotBo) {
//        return;
//    }
//    self.isPhotBo = YES;
//    [requestToolClass postNetworkWithUrl:request_album_batchDelete andParameter:@{@"idList":minStr(self.arr_imgs[index])} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//
//        self.img_idid = @"";
//        [self loadHeadData];
//    } fail:^(NSString * _Nonnull msg) {
//
//    }];
    
    if(self.img_idid.length > 0) {
        
        self.img_idid = [NSString stringWithFormat:@"%@,%@", self.img_idid, self.arr_imgs[index]];
    }else {
        self.img_idid = minStr(self.arr_imgs[index]);
    }
    
    [self.arr_imgs removeObjectAtIndex:index];
    [self.photos removeObjectAtIndex:index];
    
}

//MARK: 批量删除图片
- (void)photoDeleteMethodUIUIUMethod
{
    if(self.img_idid.length > 0) {
        if(self.isPhotBo) {
            return;
        }
        self.isPhotBo = YES;
        [requestToolClass postNetworkWithUrl:request_album_batchDelete andParameter:@{@"idList":self.img_idid} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.img_idid = @"";
            [self loadHeadData];
        } fail:^(NSString * _Nonnull msg) {
            
        }];
    }
}

-(void)focusOrGoodOrComment:(NSInteger)typeN indexPath:(NSIndexPath *)indexPath
{
    if(typeN == 4) {
        [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"homeMsg_delete") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
            if (index == 1) {
                
                MHfindSubPatternsModel *model = self.datasMut[indexPath.row];
                NSString *mm_www = @"";
                if(model.activityId) {
                    mm_www = model.activityId;
                }else {
                    mm_www = model.recordId;
                }
                [requestToolClass getNetworkWithUrl:request_activity_deleteActivity andParameter:@{@"activityId":minStr(mm_www)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                    [self.datasMut removeObjectAtIndex:indexPath.row];
                    [self.appTableView reloadData];
                } fail:^(NSString * _Nonnull msg) {
                    
                }];
            }
        }];
    }
    
}
- (void)fileClick:(NSArray *)array row:(NSInteger)row indexPath:(NSIndexPath *)indexPath
{
    if (row == 39000) {
        
        [self playVideoMethod:[NSURL URLWithString:array[0]]];
    }else {
        self.photos = [NSMutableArray array];
        
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayActionButton = NO;//no
        browser.alwaysShowControls = NO;
        browser.displaySelectionButtons = NO;
        browser.zoomPhotosToFill = YES;
        browser.displayNavArrows = NO;//no
        browser.startOnGrid = NO;
        browser.enableGrid = YES;
        browser.canDeleteFile = NO;
        
        for (NSString *model in array) {
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:model]];
            photo.caption = @"图片";
            [_photos addObject:photo];
        }
        [browser setCurrentPhotoIndex:row];
        [self.navigationController pushViewController:browser animated:YES];
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

- (void)playVideoMethod:(NSURL *)videoURL {
    AVPlayerViewController *currentVideoPlayerViewController = [[AVPlayerViewController alloc] init];
    currentVideoPlayerViewController.player = [AVPlayer playerWithURL:videoURL];
    currentVideoPlayerViewController.view.frame = self.view.bounds;
    currentVideoPlayerViewController.showsPlaybackControls = YES;
    if (@available(iOS 11.0, *)) {
        currentVideoPlayerViewController.entersFullScreenWhenPlaybackBegins = YES;
    }
    [self presentViewController:currentVideoPlayerViewController animated:NO completion:nil];
    [currentVideoPlayerViewController.player play];
}

@end
