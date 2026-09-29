//
//  MHMyController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/31.
//

#import "MHMyController.h"
#import "homeLivingOneCell.h"
#import "homeLivingTwoCell.h"
#import "foundInformationView.h"
#import "MHfindSubPatternsModel.h"
#import "MHsettingsController.h"
#import "MHmyEditerController.h"
#import "PopBottomView.h"
#import "MHupdateQuoteView.h"

@interface MHMyController ()<UITableViewDelegate, UITableViewDataSource, homeLivingOneCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic,strong) NSMutableArray *datasMut;
@property (nonatomic, assign) CGFloat oneFloatNum;
@property (nonatomic, assign) NSInteger typeP;
@property (nonatomic, assign) BOOL scrolBoo;
@property (nonatomic, strong) foundInformationView *foundInformationV;
@property (nonatomic, strong) NSArray *listArr;
@property (nonatomic, strong) NSDictionary *userDic;
@property (nonatomic, assign) NSInteger tyNNW;

@end

@implementation MHMyController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    
    //设置常亮不锁屏
//    [[UIApplication sharedApplication] setIdleTimerDisabled:[LYUserDefault userDefault].isScreenAwake];
    [[UIApplication sharedApplication] setIdleTimerDisabled:[FloatingWindowModel shareInstance].bluetoothBtn_bo];
    
    if([LYUserDefault userDefault].isLoginBoo) {
        [self requestUIUIMethod];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"1"];
    
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"2"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi object:@"1"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:customTabbaNotifi2 object:@"5"];

}

- (void)requestUIUIMethod
{
    [requestToolClass getNetworkWithUrl:request_user_me andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {

        if([info isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicAll = info;
            self.userDic = info;
            [LYUserDefault saveUserDefault:dicAll];
            
            V2TIMUserFullInfo *info = [[V2TIMUserFullInfo alloc] init];
            info.nickName = [LYUserDefault userDefault].user_nickname;
            info.faceURL = [LYUserDefault userDefault].avatar;
            info.allowType = V2TIM_FRIEND_NEED_CONFIRM;
            [[V2TIMManager sharedInstance] setSelfInfo:info succ:^{
                NSLog(@"更新 IM昵称 成功");
            } fail:^(int code, NSString *desc) {
                NSLog(@"更新 IM昵称 失败");
            }];
            
            [self.appTableView reloadData];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
    if([LYUserDefault userDefault].countries_Arr.count <= 0) {
        [requestToolClass getNetworkWithUrl:request_login_countries andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            [LYUserDefault saveCountiesArr:info];
        } fail:^(NSString * _Nonnull msg) {

        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    self.view.backgroundColor = RGB(2, 0, 3);
    
    _datasMut = [NSMutableArray array];
    
    self.oneFloatNum = 310-NAVHEIGHT-45;
    self.typeP = 0;
    
    self.listArr = @[eLocalizedString(@"plaza_all14"), eLocalizedString(@"me_allNames1"), eLocalizedString(@"plaza_all13"), eLocalizedString(@"me_allNames2")];
    
    self.appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height) style:UITableViewStylePlain];
    self.appTableView.delegate = self;
    self.appTableView.dataSource = self;
    self.appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.appTableView.rowHeight = UITableViewAutomaticDimension;
    self.appTableView.estimatedRowHeight = 70;
    self.appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[homeLivingOneCell class] forCellReuseIdentifier:@"homeLivingOneCell"];
    [self.appTableView registerClass:[homeLivingTwoCell class] forCellReuseIdentifier:@"homeLivingTwoCell"];
    [self.view addSubview:self.appTableView];
    
    UIButton *setingBtn = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-44, NAVHEIGHT-38, 32, 32)];
    [setingBtn setBackgroundImage:[UIImage imageNamed:@"me_setingImg1"] forState:UIControlStateNormal];
    [setingBtn addTarget:self action:@selector(setingBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setingBtn];
    
    [self loadrefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postPhotoListUploadNotifMethod) name:@"postPhotoListUploadNotif" object:nil];
}

- (void)postPhotoListUploadNotifMethod
{
    [self.appTableView.mj_header beginRefreshing];
}

- (void)setingBtnMethod
{
    MHsettingsController *vc = [[MHsettingsController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
 
    CGPoint offset = aScrollView.contentOffset;
    if(offset.y >= self.oneFloatNum) {
        NSLog(@"滑动y-y --%.0f",offset.y);
        if(!self.scrolBoo) {
            self.scrolBoo = YES;
            [self.appTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
            [self.appTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    }else {
        if(offset.y < self.oneFloatNum-20){
            self.scrolBoo = NO;
        };
    }
}

-(void)loadrefreshing{
    
    WEAKSELF
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeadData];
    }];
    
    // 马上进入刷新状态
    [self.appTableView.mj_header beginRefreshing];
}

- (void)loadHeadData {
    
    [self RequestListData];
}

- (void)RequestListData
{
    NSString *url_url = request_user_pageOtherActivity;
    NSDictionary *dicMM = @{@"page":@"1", @"size":@"10", @"userId":[LYUserDefault userDefault].t_id};
    if(self.typeP == 1){
        url_url = request_user_pageTimelineAlbum;
    }else if (self.typeP == 2) {
        url_url = request_album_pageOwnToysActivity;
    }else if (self.typeP == 3) {
        url_url = request_device_pageDevice;
    }
    
    [requestToolClass postNetworkWithUrl:url_url andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self.appTableView.mj_header endRefreshing];
        [self.datasMut removeAllObjects];
        NSArray *arrL = info[@"records"];
        if((self.typeP == 0) || (self.typeP == 2)) {
            for (NSDictionary *dciM in arrL) {
                MHfindSubPatternsModel *model = [MHfindSubPatternsModel mj_objectWithKeyValues:dciM];
                [self.datasMut addObject:model];
            }
        }else {
            for (NSDictionary *dciM in arrL) {
                [self.datasMut addObject:dciM];
            }
        }
        
        [self.appTableView reloadData];
    } fail:^(NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        homeLivingOneCell *cell = [homeLivingOneCell cellWithTabelView:tableView];
        if(self.userDic) {
            [cell addDataToMeUser:self.userDic];
        }
        cell.delegate_ = self;
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {

        homeLivingTwoCell *cell = [homeLivingTwoCell cellWithTabelView:tableView];
        cell.selVC = self;
        cell.othrId = [LYUserDefault userDefault].t_id;
        [cell addDataToModel:self.listArr datList:self.datasMut typeL:self.typeP booScrol:self.scrolBoo vieControl:self];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WEAKSELF
        cell.block_ = ^(NSInteger selRow) {
            weakSelf.typeP = selRow;
            
            [weakSelf.foundInformationV changeVIdeoTopTitleXIndex:weakSelf.typeP];
            [weakSelf.appTableView.mj_header beginRefreshing];
        };
        
        return cell;
    }
}

- (void)clickHomeLivingOneCellMethod:(NSInteger)num
{
    self.tyNNW = num;
    if(num == 1) {
        MHmyEditerController *vc = [[MHmyEditerController alloc] init];
        vc.userDic = self.userDic;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (num == 2) {
        
        [self showPhotoBtn];
    }else if (num == 3) {
        
        [self showPhotoBtn];
    }else if (num == 4) {
        
        MHupdateQuoteView *updaQuV = [[MHupdateQuoteView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [self.tabBarController.view addSubview:updaQuV];
        updaQuV.block_ = ^(NSString * _Nonnull strLL) {
          
            [self uploadNickName:strLL];
        };
    }
}

- (void)uploadNickName:(NSString *)nickNam
{
    [SVProgressHUD show];
    
    NSDictionary *saveDic = @{@"quote":nickNam};
    [requestToolClass postNetworkWithUrl:request_user_updateQuote andParameter:saveDic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        [self requestUIUIMethod];
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 1) {
        return 44;
    }else {
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headVVV = [self.appTableView viewWithTag:3390];
    if(!headVVV) {
        
        headVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 44)];
        headVVV.tag = 3390;
        
//        UIView *bgV1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 20)];
//        bgV1.clipsToBounds = YES;
//        [headVVV addSubview:bgV1];
        
//        UIImageView *pppImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 20)];
//        pppImgV.image = [UIImage imageNamed:@"userSpacePlacImg"];
//        pppImgV.contentMode = UIViewContentModeScaleAspectFill;
//        [bgV1 addSubview:pppImgV];
        
        self.foundInformationV = [[foundInformationView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 44)];
        self.foundInformationV.layer.cornerRadius = 0;
        [headVVV addSubview:self.foundInformationV];
        self.foundInformationV.backgroundColor = RGB(1, 0, 2);
        [self.foundInformationV addVIdeoTopTitleMethodDataToDic:self.listArr];
        WEAKSELF
        self.foundInformationV.block_ = ^(NSInteger type, NSInteger num) {
            weakSelf.typeP = num;
            [weakSelf loadHeadData];
        };
    }
    
    [self.foundInformationV changeVIdeoTopTitleXIndex:self.typeP];
    return headVVV;
}

- (void)showPhotoBtn
{
    NSArray *array = @[@{@"name":eLocalizedString(@"home_Shoot"),@"id":@"3"},@{@"name":eLocalizedString(@"home_SelectFromAlbum"),@"id":@"2"},@{@"name":eLocalizedString(@"home_Cancel")}];
    PopBottomView *pop = [[PopBottomView alloc]initWithFrame:self.view.frame];
    pop.cancelColor = GrayTextColor;
    pop.data = array;
    pop.blockCallBackIndex = ^(NSDictionary *dictionary){
       
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        
        if ([dictionary[@"id"]intValue] == 2) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:^{
                if (@available(iOS 13.0, *)) {
                    [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
                } else {
                    // Fallback on earlier versions
                }
            }];
        }else if ([dictionary[@"id"]intValue] == 3) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:^{
                    if (@available(iOS 13.0, *)) {
                        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
                    } else {
                        // Fallback on earlier versions
                    }
                }];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:eLocalizedString(@"home_Prompt") message:eLocalizedString(@"home_DeviceSupportTakingPhotos") delegate:nil cancelButtonTitle:eLocalizedString(@"home_Sure") otherButtonTitles: nil];
                [alert show];
            }
        }
        
    };
    [pop viewShow];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage* img = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    UIImage *newImage =[self fixOrientation:img];
    
    [self uploadSignMethod:newImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadSignMethod:(UIImage *)newImage
{
    [SVProgressHUD show];
    NSData *data = UIImageJPEGRepresentation(newImage, 0.5);
    
    [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        [LYUserDefault saveQCloudDic:info];
        
        [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:1 andImageData:@[data] success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            NSArray *arMM = info;
            if(arMM.count > 0) {
                [self editerAvatorMethod:minStr(arMM[0])];
            }else {
                [SVProgressHUD dismiss];
            }
        } fail:^(NSString * _Nonnull msg) {
            [SVProgressHUD dismiss];
        }];
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)editerAvatorMethod:(NSString *)qiniuStr
{
    if(self.tyNNW == 3) {
        
        NSDictionary *dic = @{@"bg":qiniuStr};
        [requestToolClass postNetworkWithUrl:request_user_updateBg andParameter:dic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
//            [self requestUIUIMethod];
        } fail:^(NSString * _Nonnull msg) {
            
        }];
    }else {
        NSDictionary *dic = @{@"profile":qiniuStr};
        [requestToolClass postNetworkWithUrl:request_user_updateProfile andParameter:dic success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
//            [LYUserDefault saveUserAvator:qiniuStr];
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
            [self uploadfaceURLUrl:qiniuStr];
            [self requestUIUIMethod];
        } fail:^(NSString * _Nonnull msg) {
            
        }];
    }
}

//MARK: 修改腾讯IM 头像
- (void)uploadfaceURLUrl:(NSString *)avatorUrl
{
    V2TIMUserFullInfo *info = [[V2TIMUserFullInfo alloc] init];
    info.faceURL = avatorUrl;
    [[V2TIMManager sharedInstance] setSelfInfo:info succ:^{
        NSLog(@"更新 IM昵称 成功");
    } fail:^(int code, NSString *desc) {
        NSLog(@"更新 IM昵称 失败");
    }];
}

- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
