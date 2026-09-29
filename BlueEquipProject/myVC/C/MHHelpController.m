//
//  MHHelpController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/1.
//

#import "MHHelpController.h"
#import <AVFoundation/AVFoundation.h>
#import "eChooseImageVideoView.h"
#import "LFImagePickerController.h"
#import "Q_AListController.h"
#import "MHUserGuideController.h"

@interface MHHelpController ()<UITextViewDelegate, eChooseImageVideoVDelegate, LFImagePickerControllerDelegate, LFAssetImageProtocol>

@property (nonatomic, strong) UILabel *numLL;
@property (nonatomic, strong) UITextView *textV;
@property (nonatomic, strong) UILabel *placeLab;
@property (nonatomic, strong) eChooseImageVideoView *eChooseImageVideoV;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, copy) NSString *photoStr;
@property (nonatomic, assign) BOOL isBooo;
@end

@implementation MHHelpController

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
    self.titleName.text = eLocalizedString(@"my_settings3");
    
    self.navView.backgroundColor = RGB(247, 247, 247);

    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    self.photos = [NSMutableArray array];
    
    UIView *oneV = [[UIView alloc] initWithFrame:CGRectMake(12, NAVHEIGHT+16, _window_width-24, 162)];
    oneV.clipsToBounds = YES;
    oneV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:oneV];
    
    UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width-24, 162)];
    vvv.backgroundColor = RGBA(176, 51, 228, 0.12);
    [oneV addSubview:vvv];
    
    self.numLL = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:14 textAlignment:NSTextAlignmentRight];
    self.numLL.frame = CGRectMake(oneV.width-100, 130, 88, 24);
    self.numLL.text = @"0/200";
    [oneV addSubview:self.numLL];
    
    self.placeLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:14 textAlignment:NSTextAlignmentLeft];
    self.placeLab.text = eLocalizedString(@"my_about8");
    self.placeLab.numberOfLines = 0;
    [oneV addSubview:self.placeLab];
    [self.placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oneV.mas_left).offset(12);
        make.top.equalTo(oneV.mas_top).offset(10);
        make.right.equalTo(oneV.mas_right).offset(-12);
    }];
    self.textV = [[UITextView alloc] initWithFrame:CGRectMake(12, 10, _window_width-24, 142)];
    self.textV.backgroundColor = UIColor.clearColor;
    self.textV.textColor = GrayTextColor;
    self.textV.delegate = self;
    self.textV.font = SYS_Font(14);
    [oneV addSubview:self.textV];
    
    eChooseImageVideoConfig *configL = [[eChooseImageVideoConfig alloc] init];
    configL.itemSize = CGSizeMake((_window_width-40)/3.0, (_window_width-40)/3.0);
    configL.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    configL.minimumLineSpacing = 10.0f;
    configL.minimumInteritemSpacing = 10.0f;
    configL.photosMaxCount = 6;
    
    
    _eChooseImageVideoV = [[eChooseImageVideoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(oneV.frame)+10, _window_width, (_window_width-40)/3.0+20) config:configL];
    _eChooseImageVideoV = [[eChooseImageVideoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(oneV.frame)+10, _window_width, (_window_width-40)*2/3.0+20) config:configL];
    _eChooseImageVideoV.delegate_ = self;
    _eChooseImageVideoV.navigationController = self.navigationController;
    self.eChooseImageVideoV.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.eChooseImageVideoV];
    self.eChooseImageVideoV.viewHeightChanged = ^(CGFloat height) {
        
//        addPlayBtn2.frame = CGRectMake(20, CGRectGetMaxY(twoLab2.frame)+6+height+20+20, _window_width-40, 46);
//
//        scrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(addPlayBtn2.frame)+_window_width/3);
//        dddBtn.frame = CGRectMake(0, 0, _window_width, CGRectGetMaxY(addPlayBtn2.frame)+_window_width/3);
    };
    
    UIButton *loginBBtn = [HistoryRecordModel createImgBtn];
    [loginBBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
    [loginBBtn setTitle:eLocalizedString(@"my_settings13") forState:UIControlStateNormal];
    [loginBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    loginBBtn.titleLabel.font = SYS_Font(18);
    [loginBBtn addTarget:self action:@selector(addPlayMethodTwo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBBtn];
    [loginBBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-120);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(46);
        make.width.offset(210);
    }];
    
    
    
//    UIScrollView *scrollVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
//    scrollVV.backgroundColor = GroupBackColor;
//    [self.view addSubview:scrollVV];
//
//    UIButton *dddBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//    [dddBtn addTarget:self action:@selector(deleteBtnMethod) forControlEvents:UIControlEventTouchUpInside];
//    [scrollVV addSubview:dddBtn];
//
//    UIView *twoVV = [HistoryRecordModel createViewUIUI];
//    twoVV.frame = CGRectMake(0, 15, _window_width, 109);
//    twoVV.layer.cornerRadius = 0;
//    [scrollVV addSubview:twoVV];
//
//    NSArray *fouAr = @[@"my_about5", @"my_about6"];
//    for (int i=0; i<fouAr.count; i++) {
//        UIView *subVV = [HistoryRecordModel createViewUIUI];
//        subVV.frame = CGRectMake(12, i*55, twoVV.width-24, 54);
//        [twoVV addSubview:subVV];
//
//        UILabel *subLLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
//        subLLab.frame = CGRectMake(0, 0, subVV.width-60, 54);
//        subLLab.text = eLocalizedString(fouAr[i]);
//        [subVV addSubview:subLLab];
//
//        UIImageView *nexIV = [HistoryRecordModel createImgImgView];
//        nexIV.image = [UIImage imageNamed:@"next_Img2"];
//        [subVV addSubview:nexIV];
//        [nexIV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(subVV.mas_right);
//            make.centerY.equalTo(subVV.mas_centerY);
//            make.width.height.offset(18);
//        }];
//
//        if(i>0) {
//            UIView *linv = [HistoryRecordModel createLineViewUIUI];
//            linv.frame = CGRectMake(0, 0, subVV.width, 1);
//            [subVV addSubview:linv];
//        }
//
//        UIButton *cliBBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, subVV.width, subVV.height-10)];
//        cliBBtn.tag = 500+i;
//        [cliBBtn addTarget:self action:@selector(clicListTagsMethod:) forControlEvents:UIControlEventTouchUpInside];
//        [subVV addSubview:cliBBtn];
//    }
//
//    UILabel *twoLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 124, _window_width-24, 44)];
//    twoLab.text = eLocalizedString(@"my_about7");
////    twoLab.lineBreakMode = NSLineBreakByCharWrapping;
//    twoLab.textColor = GrayText102;
//    twoLab.font = SYS_Font(14);
//    [scrollVV addSubview:twoLab];
//
//    self.numLL = [HistoryRecordModel createLabLabTextColor:GrayText102 fontFloat:14 textAlignment:NSTextAlignmentRight];
//    self.numLL.frame = CGRectMake(_window_width-100, 124, 88, 44);
//    self.numLL.text = @"0/200";
//    [scrollVV addSubview:self.numLL];
//
//    UIView *oneV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(twoLab.frame), _window_width, 142)];
//    oneV.clipsToBounds = YES;
//    oneV.backgroundColor = UIColor.whiteColor;
//    [scrollVV addSubview:oneV];
//
//    self.placeLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:14 textAlignment:NSTextAlignmentLeft];
//    self.placeLab.text = eLocalizedString(@"my_about8");
//    self.placeLab.numberOfLines = 0;
//    [oneV addSubview:self.placeLab];
//    [self.placeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(oneV.mas_left).offset(12);
//        make.top.equalTo(oneV.mas_top).offset(10);
//        make.right.equalTo(oneV.mas_right).offset(-12);
//    }];
//    self.textV = [[UITextView alloc] initWithFrame:CGRectMake(12, 10, _window_width-24, 122)];
//    self.textV.backgroundColor = UIColor.clearColor;
//    self.textV.textColor = GrayTextColor;
//    self.textV.delegate = self;
//    self.textV.font = SYS_Font(14);
//    [oneV addSubview:self.textV];
//
//    UILabel *twoLab2 = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(oneV.frame), _window_width-24, 12)];
////    twoLab2.text = eLocalizedString(@"my_about9");
////    twoLab2.textColor = GrayText102;
////    twoLab2.font = SYS_Font(14);
//    [scrollVV addSubview:twoLab2];
//
//    eChooseImageVideoConfig *configL = [[eChooseImageVideoConfig alloc] init];
//    configL.itemSize = CGSizeMake((_window_width-40)/3.0, (_window_width-40)/3.0);
//    configL.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    configL.minimumLineSpacing = 10.0f;
//    configL.minimumInteritemSpacing = 10.0f;
//    configL.photosMaxCount = 6;
//
//    UIButton *addPlayBtn2 = [HistoryRecordModel createImgBtn];
//
//    _eChooseImageVideoV = [[eChooseImageVideoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(twoLab2.frame)+6, _window_width, (_window_width-40)/3.0+20) config:configL];
//    _eChooseImageVideoV.delegate_ = self;
//    _eChooseImageVideoV.navigationController = self.navigationController;
//    self.eChooseImageVideoV.backgroundColor = UIColor.whiteColor;
//    [scrollVV addSubview:self.eChooseImageVideoV];
//    self.eChooseImageVideoV.viewHeightChanged = ^(CGFloat height) {
//
//        addPlayBtn2.frame = CGRectMake(20, CGRectGetMaxY(twoLab2.frame)+6+height+20+20, _window_width-40, 46);
//
//        scrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(addPlayBtn2.frame)+_window_width/3);
//        dddBtn.frame = CGRectMake(0, 0, _window_width, CGRectGetMaxY(addPlayBtn2.frame)+_window_width/3);
//    };
//
//    addPlayBtn2.frame = CGRectMake(20, CGRectGetMaxY(twoLab2.frame)+6+(_window_width-40)/3.0+20+20, _window_width-40, 46);
//    [addPlayBtn2 setBackgroundImage:[UIImage imageNamed:@"ModeImgs13"] forState:UIControlStateNormal];
//    [addPlayBtn2 setTitle:eLocalizedString(@"home_done") forState:UIControlStateNormal];
//    [addPlayBtn2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    addPlayBtn2.titleLabel.font = SYS_Font(18);
//    [addPlayBtn2 addTarget:self action:@selector(addPlayMethodTwo) forControlEvents:UIControlEventTouchUpInside];
//    [scrollVV addSubview:addPlayBtn2];
//
//    scrollVV.contentSize = CGSizeMake(_window_width, CGRectGetMaxY(addPlayBtn2.frame)+_window_width/3);
//    dddBtn.frame = CGRectMake(0, 0, _window_width, CGRectGetMaxY(addPlayBtn2.frame)+_window_width/3);
}

//MARK: 提交
- (void)addPlayMethodTwo
{
    [self.textV resignFirstResponder];

    if ((self.textV.text.length > 0)&&(self.photos.count > 0)) {
        if(self.isBooo) {
            return;
        }
        self.isBooo = YES;
        [SVProgressHUD show];
        
        NSMutableArray *dataMut = [NSMutableArray array];
        NSArray *aaphotos = [self.eChooseImageVideoV getPhotos];
        for (int i=0; i<aaphotos.count; i++) {
            UIImage *newImage = aaphotos[i];
            NSData *data = UIImageJPEGRepresentation(newImage, 0.5);
            [dataMut addObject:data];
        }
        
        [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            [LYUserDefault saveQCloudDic:info];
            
            [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages typMehtod:1 andImageData:dataMut success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                NSString *imgUrlStr = @"";
                NSArray *oneAr = info;
                for (NSString *liUrl in oneAr) {
                    if(imgUrlStr.length > 0) {
                        imgUrlStr = [NSString stringWithFormat:@"%@,%@", imgUrlStr, liUrl];
                    }else {
                        imgUrlStr = liUrl;
                    }
                }
                [requestToolClass postNetworkWithUrl:request_feedback_report andParameter:@{@"content":self.textV.text, @"images":imgUrlStr} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                    
                    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"request_success")];
                    [self.navigationController popViewControllerAnimated:YES];
                } fail:^(NSString * _Nonnull msg) {
                    [SVProgressHUD dismiss];
                }];
            } fail:^(NSString * _Nonnull msg) {
                [SVProgressHUD dismiss];
            }];
        } fail:^(NSString * _Nonnull msg) {
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)clicListTagsMethod:(UIButton *)btn
{
    [self.textV resignFirstResponder];
    if(btn.tag == 500) {
        Q_AListController *vc = [[Q_AListController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        MHUserGuideController *vc = [[MHUserGuideController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)deleteBtnMethod
{
    [self.textV resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        _placeLab.hidden = YES;
        self.numLL.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length];
    }else {
        _placeLab.hidden = NO;
        self.numLL.text = @"0/200";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length > 0) {
        _placeLab.hidden = YES;
        self.numLL.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length];
    }else {
        _placeLab.hidden = NO;
        self.numLL.text = @"0/200";
    }
    
    
    if ([text isEqualToString:@"\n"]) {

        [self.textV resignFirstResponder];

        return NO;
    }
    if (textView.text.length > 199) {
        text = @"";
        self.numLL.text = [NSString stringWithFormat:@"%lu/200", (unsigned long)textView.text.length];
        return NO;
    }
    return YES;
}

#pragma mark -选择
- (void)eChooseImageVideoUrl:(NSURL *)url
{
//    [self playVideoMethod:url];
}

- (void)eChooseImageVideoDelete:(NSInteger)num
{
    [self.photos removeObjectAtIndex:num];
}

- (void)pickPhotosChoose:(NSInteger)typeN
{
    [self.textV resignFirstResponder];
    [self choosePhotosMethod];
}

- (void)choosePhotosMethod {
    
    NSInteger numImg = 6-self.photos.count;
    
    LFImagePickerController *imagePicker = [[LFImagePickerController alloc] initWithMaxImagesCount:numImg delegate:self];
    //根据需求设置
    imagePicker.allowTakePicture = NO;
    imagePicker.maxVideosCount = 0; /** 解除混合选择- 要么1个视频，要么9个图片 */
    imagePicker.supportAutorotate = NO; /** 适配横屏 */
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) {
        imagePicker.syncAlbum = YES; /** 实时同步相册 */
    }
    imagePicker.doneBtnTitleStr = eLocalizedString(@"home_edit_save"); //最终确定按钮名称
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)lf_imagePickerController:(LFImagePickerController *)picker didFinishPickingResult:(NSArray<LFResultObject *> *)results {
    
    for (NSInteger i = 0; i < results.count; i++) {
        LFResultObject *result = results[i];
        if ([result isKindOfClass:[LFResultImage class]]) {
           
            LFResultImage *resultImage = (LFResultImage *)result;

            LFResultVideo *resultVideo = [[LFResultVideo alloc] init];
            resultVideo.smallImage = resultImage.originalImage;
            resultVideo.typeModel = 2;
            [self.photos addObject:resultVideo];
            
            [self.eChooseImageVideoV refreshPhotoOrVideoArray:self.photos isVideo:NO];
        } else {
            
        }
    }
}

@end
