//
//  MHReportJBViewController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/2/28.
//

#import "MHReportJBViewController.h"
#import "LFImagePickerController.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface MHReportJBViewController ()<UITextViewDelegate, LFImagePickerControllerDelegate>

@property (nonatomic, strong) UILabel *chosLab;
@property (nonatomic, strong) NSArray *lisArr;
@property (nonatomic, copy) NSString *caget_id;

@property (nonatomic, strong) UIView *one_VV;
@property (nonatomic, strong) UIView *two_VV;
@property (nonatomic, strong) UIView *oneVVsub;
@property (nonatomic, strong) UIButton *deleteVV;
@property (nonatomic, strong) UIView *listVVsub;
@property (nonatomic, strong) UIView *selectVV;
@property (nonatomic, strong) UITextView *textV;
@property (nonatomic, strong) UILabel *placeLab;
@property (nonatomic, strong) UILabel *numberLab;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, copy) NSString *imgUrlStr;
@property (nonatomic, strong) UIView *lineVV;

@end

@implementation MHReportJBViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (@available(iOS 13.0, *)) {
        [FloatingWindowModel shareInstance].getWindowSceneBarMehotd.windows.firstObject.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
        // Fallback on earlier versions
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.redNavView = NO;
    self.titleName.text = eLocalizedString(@"me_allNames23");
    self.caget_id = @"";
    
    self.imgUrlStr = @"";
    self.photos = [NSMutableArray array];
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    self.navView.backgroundColor = RGB(247, 247, 247);
    
    UILabel *oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    oneLab.frame = CGRectMake(12, NAVHEIGHT+4, _window_width-24, 40);
    oneLab.text = eLocalizedString(@"find_choose4");
    [self.view addSubview:oneLab];
    
    UIView *oneVV = [HistoryRecordModel createViewUIUI];
    oneVV.frame = CGRectMake(12, CGRectGetMaxY(oneLab.frame), _window_width-24, 42);
    [self.view addSubview:oneVV];
    oneVV.backgroundColor = UIColor.clearColor;
    UIView *splaVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width-24, 42)];
    splaVV.backgroundColor = RGBA(176, 51, 228, 0.15);
    [oneVV addSubview:splaVV];
    self.oneVVsub = oneVV;
    
    self.chosLab = [HistoryRecordModel createLabLabTextColor:RGB(90, 90, 90) fontFloat:14 textAlignment:NSTextAlignmentLeft];
    self.chosLab.frame = CGRectMake(12, 0, oneVV.width-50, 42);
    self.chosLab.text = eLocalizedString(@"find_choose5");
    [oneVV addSubview:self.chosLab];
    
    UIImageView *nexV = [HistoryRecordModel createImgImgView];
    nexV.frame = CGRectMake(oneVV.width-28, 12, 18, 18);
    nexV.image = [UIImage imageNamed:@"dissm_nexImg4_4"];
    [oneVV addSubview:nexV];
    
    UIButton *chosBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, oneVV.width, 42)];
    [chosBBtn addTarget:self action:@selector(choseBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [oneVV addSubview:chosBBtn];
    
    UILabel *oneLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    oneLab2.frame = CGRectMake(12, CGRectGetMaxY(oneVV.frame)+4, _window_width-24, 40);
    oneLab2.text = eLocalizedString(@"find_choose6");
    [self.view addSubview:oneLab2];
    
    self.one_VV = [HistoryRecordModel createViewUIUI];
    self.one_VV.frame = CGRectMake(12, CGRectGetMaxY(oneLab2.frame), _window_width-24, 162);
    self.one_VV.backgroundColor = UIColor.clearColor;
    self.one_VV.layer.cornerRadius = 8;
    [self.view addSubview:self.one_VV];
    UIView *splaVV2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width-24, 162)];
    splaVV2.backgroundColor = RGBA(176, 51, 228, 0.15);
    [self.one_VV addSubview:splaVV2];
    
    self.placeLab = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:14 textAlignment:NSTextAlignmentLeft];
    self.placeLab.text = eLocalizedString(@"postPlaza_placeText");
    [self.one_VV addSubview:self.placeLab];
    [self.placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.one_VV.mas_left).offset(12);
        make.top.equalTo(self.one_VV.mas_top).offset(18);
    }];
    
    self.numberLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:12 textAlignment:NSTextAlignmentRight];
    self.numberLab.text = @"0/1000";
    [self.one_VV addSubview:self.numberLab];
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.one_VV.mas_right).offset(-12);
        make.bottom.equalTo(self.one_VV.mas_bottom).offset(-22);
    }];
    
    self.textV = [[UITextView alloc] initWithFrame:CGRectMake(12, 12, self.one_VV.width-24, self.one_VV.height-24)];
    self.textV.font = SYS_Font(14);
    self.textV.textColor = GrayText102;
    self.textV.backgroundColor = UIColor.clearColor;
    self.textV.delegate = self;
    self.textV.returnKeyType = UIReturnKeyDone;
    [self.one_VV addSubview:self.textV];
    
    UILabel *oneLab3 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
    oneLab3.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame)+4, _window_width-24, 40);
    oneLab3.text = eLocalizedString(@"find_choose7");
    [self.view addSubview:oneLab3];
    
    self.two_VV = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(oneLab3.frame), _window_width-24, 194)];
    [self.view addSubview:self.two_VV];
    
    UIButton *addFilBtn = [HistoryRecordModel createImgBtn];
    addFilBtn.frame = CGRectMake(0, 0, 92, 92);
    [addFilBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_add"] forState:UIControlStateNormal];
    [addFilBtn addTarget:self action:@selector(addFileBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.two_VV addSubview:addFilBtn];
    
    UIButton *sureBBB = [HistoryRecordModel createImgBtn];
    sureBBB.frame = CGRectMake((_window_width-210)/2, _window_height-46-TARBARHEIGHT, 210, 46);
    [sureBBB setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [sureBBB setTitle:eLocalizedString(@"my_settings13") forState:UIControlStateNormal];
    [sureBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    sureBBB.titleLabel.font = SYS_Font(14);
    [sureBBB addTarget:self action:@selector(publishBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBBB];
    
    [requestToolClass getNetworkWithUrl:request_other_listReportCategory andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.lisArr = info;
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

- (void)publishBtnMethod
{
    [self.view endEditing:YES];
    if(self.textV.text.length>0) {
        
        if(self.photos.count > 0) {
            NSMutableArray *arMut = [NSMutableArray array];
            
            for (int i=0; i<self.photos.count; i++) {
                LFResultVideo *resultVideo = self.photos[i];
                NSData *dataImg = UIImageJPEGRepresentation(resultVideo.smallImage, 0.9);
                [arMut addObject:dataImg];
            }
         
            [SVProgressHUD show];
            [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                [LYUserDefault saveQCloudDic:info];
                
                [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:1 andImageData:arMut success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                    NSArray *oneAr = info;
                    for (NSString *liUrl in oneAr) {
                        if(self.imgUrlStr.length > 0) {
                            self.imgUrlStr = [NSString stringWithFormat:@"%@,%@", self.imgUrlStr, liUrl];
                        }else {
                            self.imgUrlStr = liUrl;
                        }
                    }
                    [self uploadRequestMMM];
                    
                } fail:^(NSString * _Nonnull msg) {
                    [SVProgressHUD dismiss];
                }];
            } fail:^(NSString * _Nonnull msg) {
                [SVProgressHUD dismiss];
            }];
        }else {
            [SVProgressHUD show];
            self.imgUrlStr = @"";
            [self uploadRequestMMM];
        }
    }
}

- (void)uploadRequestMMM
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *dicMMM = @{@"type":self.typeL, @"targetId":self.targetIId, @"cid":self.caget_id, @"description":minStr(self.textV.text), @"evidenceUrls":self.imgUrlStr};
        [requestToolClass postNetworkWithUrl:request_other_complaint andParameter:dicMMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(NSString * _Nonnull msg) {
            
        }];
    });
}

- (void)choseBtnMethod
{
    self.deleteVV = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.deleteVV addTarget:self action:@selector(deleteVVMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteVV];
    
    self.listVVsub = [[UIView alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.oneVVsub.frame), 290, 260)];
    [self.view addSubview:self.listVVsub];
    UIImageView *imgPlace = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 260)];
    imgPlace.image = [UIImage imageNamed:@"place_whiteImg"];
    [self.listVVsub addSubview:imgPlace];
    
    UIScrollView *lisScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(17, 12, 256, 236)];
    lisScrollV.backgroundColor = UIColor.whiteColor;
    lisScrollV.showsVerticalScrollIndicator = NO;
    lisScrollV.showsHorizontalScrollIndicator = NO;
    [self.listVVsub addSubview:lisScrollV];
    lisScrollV.contentSize = CGSizeMake(256, self.lisArr.count*34+34);
    
    self.lineVV = [HistoryRecordModel createViewUIUI];
    self.lineVV.frame = CGRectMake(0, 0, 256, 34);
    self.lineVV.layer.cornerRadius = 4;
    self.lineVV.backgroundColor = normalPurpleColors;
    [lisScrollV addSubview:self.lineVV];
    
    for (int i=0; i<self.lisArr.count+1; i++) {
        
        UIView *spLinV = [[UIView alloc] initWithFrame:CGRectMake(0, i*34, 256, 34)];
        spLinV.backgroundColor = UIColor.whiteColor;
        [lisScrollV addSubview:spLinV];
        
        UIImageView *duiImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 14, 14)];
        duiImg.image = [UIImage imageNamed:@"duihao_img"];
        [spLinV addSubview:duiImg];
        
        UILabel *allLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        allLab.frame = CGRectMake(30, 0, spLinV.width-40, 34);
        if(i==0) {
            allLab.text = eLocalizedString(@"find_choose5");
            if([@"" isEqualToString:self.caget_id]) {
                allLab.textColor = normalColors;
            }else {
                allLab.textColor = GrayTextColor;
            }
        }else {
            NSDictionary *di_LL = self.lisArr[i-1];
            if([minStr(di_LL[@"id"]) isEqualToString:self.caget_id]) {
                allLab.text = minStr(di_LL[@"name"]);
                allLab.textColor = normalColors;
                self.lineVV.frame = CGRectMake(0, i*34, 256, 34);
            }else {
                allLab.text = minStr(di_LL[@"name"]);
                allLab.textColor = GrayTextColor;
            }
        }
        allLab.tag = 4500+i;
        [spLinV addSubview:allLab];
        
        UIButton *clickBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, spLinV.width, spLinV.height)];
        clickBBB.tag = 4600+i;
        [clickBBB addTarget:self action:@selector(clickBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
        [spLinV addSubview:clickBBB];
    }
}

- (void)clickBtnMethod:(UIButton *)btn
{
    if(btn.tag == 4600) {
        self.caget_id = @"";
        self.chosLab.text = eLocalizedString(@"find_choose5");
    }else {
        NSDictionary *di_LL = self.lisArr[btn.tag-4601];
        self.caget_id = minStr(di_LL[@"id"]);
        self.chosLab.text = minStr(di_LL[@"name"]);
    }
    [self deleteVVMethod];
}

- (void)deleteVVMethod
{
    self.listVVsub.hidden = YES;
    self.deleteVV.hidden = YES;
    self.lineVV.hidden = YES;
    [self.lineVV removeFromSuperview];
    [self.listVVsub removeFromSuperview];
    [self.deleteVV removeFromSuperview];
}

- (void)addFileBtnMethod {
    
    [self.view endEditing:YES];
    NSInteger numImg = 3;
    
    LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:numImg delegate:self];
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

- (void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingResult:(NSArray<LFResultObject *> *)results {
    
    [self.photos removeAllObjects];
    [self.two_VV removeAllSubviews];
    for (NSInteger i = 0; i < results.count; i++) {
        LFResultObject *result = results[i];
        if ([result isKindOfClass:[LFResultImage class]]) {
           
            LFResultImage *resultImage = (LFResultImage *)result;
            LFResultVideo *resultVideo = [[LFResultVideo alloc] init];
            resultVideo.smallImage = resultImage.originalImage;
            resultVideo.typeModel = 2;
            [self.photos addObject:resultVideo];
        }
    }
    
    if(self.photos.count > 2) {
        self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame)+44, _window_width-24, 194);
    }else {
        self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame)+44, _window_width-24, 92);
    }
    CGFloat ww_wX = (_window_width-24-20)/3+10;
    if(self.photos.count > 2) {

        for (int i=0; i<self.photos.count; i++) {
            LFResultVideo *resultVideo = self.photos[i];
            
            NSInteger num = i%3;
            NSInteger numT = i/3;
            UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92)];
            [self.two_VV addSubview:cont_VV];
            [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
        }
    }else {

        for (int i=0; i<self.photos.count+1; i++) {
            
            NSInteger num = i%3;
            NSInteger numT = i/3;
            if(i==self.photos.count) {
                UIButton *addFilBtn = [HistoryRecordModel createImgBtn];
                addFilBtn.frame = CGRectMake(0, 0, 92, 92);
                [addFilBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_add"] forState:UIControlStateNormal];
                [addFilBtn addTarget:self action:@selector(addFileBtnMethod) forControlEvents:UIControlEventTouchUpInside];
                [self.two_VV addSubview:addFilBtn];
                addFilBtn.frame = CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92);
            }else {
                LFResultVideo *resultVideo = self.photos[i];
                UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92)];
                [self.two_VV addSubview:cont_VV];
                [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
            }
        }
    }
}

- (void)createUIUI:(UIView *)botVV tag:(NSInteger)tagN model:(LFResultVideo *)model isVideo:(BOOL)isVideo
{
    UIImageView *bigImgV = [HistoryRecordModel createImgImgView];
    bigImgV.frame = CGRectMake(0, 0, botVV.width-10, botVV.height);
    bigImgV.tag = tagN+200;
    bigImgV.image = model.smallImage;
    [botVV addSubview:bigImgV];
    
    UIButton *imgBtn = [HistoryRecordModel createImgBtn];
    imgBtn.frame = CGRectMake(0, 0, botVV.width-10, botVV.height);
    imgBtn.tag = tagN;
    [botVV addSubview:imgBtn];
    
    UIButton *deleteBtn = [HistoryRecordModel createImgBtn];
    deleteBtn.frame = CGRectMake(botVV.width-20, 0, 20, 20);
    deleteBtn.tag = tagN+100;
    [deleteBtn setImage:[UIImage imageNamed:@"startL_vipbtnDelet"] forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnsMethod:) forControlEvents:UIControlEventTouchUpInside];
    [botVV addSubview:deleteBtn];
    [imgBtn addTarget:self action:@selector(showImgSBtn:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)showImgSBtn:(UIButton *)btn
{
    NSMutableArray *arrImgss = [NSMutableArray array];
    for (int i=0; i<self.photos.count; i++) {
        LFResultVideo *resultVideo = self.photos[i];
        
        UIImageView *btnImgs = [self.two_VV viewWithTag:i+2300];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.index = i;
        photo.image = resultVideo.smallImage; // 图片路径
        photo.srcImageView = btnImgs; // 来源于哪个UIImageView
        [arrImgss addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = arrImgss; // 设置所有的图片
    browser.currentPhotoIndex = btn.tag-2100; // 弹出相册时显示的第一张图片是？
    [browser show];
}

- (void)deleteBtnsMethod:(UIButton *)btn
{
    [self.photos removeObjectAtIndex:btn.tag-2200];
    [self.two_VV removeAllSubviews];
    if(self.photos.count > 2) {
        self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame)+44, _window_width-24, 194);
    }else {
        self.two_VV.frame = CGRectMake(12, CGRectGetMaxY(self.one_VV.frame)+44, _window_width-24, 92);
    }
    
    CGFloat ww_wX = (_window_width-24-20)/3+10;
    
    if(self.photos.count > 5) {

        for (int i=0; i<self.photos.count; i++) {
            LFResultVideo *resultVideo = self.photos[i];
            
            NSInteger num = i%3;
            NSInteger numT = i/3;
            UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92)];
            [self.two_VV addSubview:cont_VV];
            [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
        }
    }else {
        
        for (int i=0; i<self.photos.count+1; i++) {
            
            NSInteger num = i%3;
            NSInteger numT = i/3;
            if(i==self.photos.count) {
                UIButton *addFilBtn = [HistoryRecordModel createImgBtn];
                addFilBtn.frame = CGRectMake(0, 0, 92, 92);
                [addFilBtn setBackgroundImage:[UIImage imageNamed:@"sqarePost_add"] forState:UIControlStateNormal];
                [addFilBtn addTarget:self action:@selector(addFileBtnMethod) forControlEvents:UIControlEventTouchUpInside];
                [self.two_VV addSubview:addFilBtn];
                addFilBtn.frame = CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92);
            }else {
                LFResultVideo *resultVideo = self.photos[i];
                UIView *cont_VV = [[UIView alloc] initWithFrame:CGRectMake(ww_wX*num + (ww_wX-10-92)/2, 102*numT, 92, 92)];
                [self.two_VV addSubview:cont_VV];
                [self createUIUI:cont_VV tag:i+2100 model:resultVideo isVideo:NO];
            }
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        
        self.placeLab.hidden = YES;
        if (self.textV.text.length > 1000) {

        }else {
            self.numberLab.text = [NSString stringWithFormat:@"%lu/1000", (unsigned long)self.textV.text.length];
        }
    }else {
        self.placeLab.hidden = NO;
        self.numberLab.text = @"0/1000";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (self.textV.text.length > 1000) {
        
        self.textV.text = [self.textV.text stringByReplacingCharactersInRange:range withString:@""];
        self.numberLab.text = @"1000/1000";
        return NO;
    }else {
        return YES;
    }
}

@end
