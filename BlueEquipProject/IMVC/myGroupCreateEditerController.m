//
//  myGroupCreateEditerController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/18.
//

#import "myGroupCreateEditerController.h"
#import "PopBottomView.h"

@interface myGroupCreateEditerController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textFF;
@property (nonatomic, strong) UIImageView *faceImgV;
@property (nonatomic, copy) NSString *faceUrl;
@end

@implementation myGroupCreateEditerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleName.text = eLocalizedString(@"contact_friend4");
    self.navView.backgroundColor = GroupBackColor;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.faceUrl = @"";
    
    self.faceImgV = [HistoryRecordModel createImgImgView];
    self.faceImgV.layer.cornerRadius = 30;
    self.faceImgV.image = [UIImage imageNamed:@"creatGroupImgs1"];
    [self.view addSubview:self.faceImgV];
    [self.faceImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.offset(60);
    }];
    
    UIButton *faBtn = [[UIButton alloc] init];
    [faBtn addTarget:self action:@selector(uploadHeadImgBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:faBtn];
    [faBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.offset(60);
    }];
    
    self.textFF = [[UITextField alloc] init];
    self.textFF.textColor = GrayTextColor;
    self.textFF.font = SYS_Font(14);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:eLocalizedString(@"message_tile5") attributes:@{NSForegroundColorAttributeName:RGBA(220, 220, 220, 1),NSFontAttributeName:self.textFF.font}];
    self.textFF.attributedPlaceholder = attrString;
    self.textFF.delegate = self;
    [self.view addSubview:self.textFF];
    [self.textFF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.faceImgV.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(40);
        make.width.offset(120);
    }];
    
    UIView *lineV = [HistoryRecordModel createLineViewUIUI];
    [self.view addSubview:lineV];
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textFF.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.offset(1);
        make.width.offset(220);
    }];
    
    UIButton *creatBtn = [HistoryRecordModel createImgBtn];
    creatBtn.backgroundColor = RGB(227, 172, 114);
    creatBtn.layer.cornerRadius = 4;
    [creatBtn setTitle:eLocalizedString(@"contact_friend5") forState:UIControlStateNormal];
    [creatBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    creatBtn.titleLabel.font = SYS_Font(16);
    [creatBtn addTarget:self action:@selector(createBtnMerthodMMM) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:creatBtn];
    [creatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(12);
        make.right.equalTo(self.view.mas_right).offset(-12);
        make.top.equalTo(lineV.mas_bottom).offset(50);
        make.height.offset(42);
    }];
    
}

- (void)createBtnMerthodMMM
{
    if(self.textFF.text.length > 1) {
        [self.navigationController popViewControllerAnimated:NO];
        if(self.block_) {
            self.block_(minStr(self.textFF.text), self.faceUrl);
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if((textField.text.length > 19)&&(string.length>0)) {
        return NO;
    }
    return YES;
}

- (void)uploadHeadImgBtn
{
    NSArray *array = @[@{@"name":eLocalizedString(@"home_Shoot"),@"id":@"3"},@{@"name":eLocalizedString(@"home_SelectFromAlbum"),@"id":@"2"},@{@"name":eLocalizedString(@"home_Cancel")}];
    PopBottomView *pop = [[PopBottomView alloc]initWithFrame:self.view.frame];
    pop.cancelColor = GrayTextColor;
    pop.data = array;
    pop.blockCallBackIndex = ^(NSDictionary *dictionary){
        NSLog(@"index = %@",dictionary);
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        picker.delegate = self;
        picker.modalPresentationStyle = UIModalPresentationFullScreen;
        
        if ([dictionary[@"id"]intValue] == 2) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:^{
                if (@available(iOS 13.0, *)) {
                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
                } else {
                    // Fallback on earlier versions
                    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                }
            }];
        }else if ([dictionary[@"id"]intValue] == 3) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:^{
                    if (@available(iOS 13.0, *)) {
                        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDarkContent;
                    } else {
                        // Fallback on earlier versions
                        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                    }
                }];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:eLocalizedString(@"home_Prompt") message:eLocalizedString(@"home_DeviceSupportTakingPhotos") delegate:nil cancelButtonTitle:eLocalizedString(@"event_Sure") otherButtonTitles: nil];
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
    [QiNiuUpload uploadToQiNiu:newImage loading:YES resetSize:YES complete:^(NSString * _Nonnull url) {
        self.faceImgV.image = newImage;
        [self editerAvatorMethod:url];
    }];
}

- (void)editerAvatorMethod:(NSString *)qiniuStr
{
    [SVProgressHUD dismiss];
    self.faceUrl = [NSString stringWithFormat:@"%@/%@", [LYUserDefault userDefault].QiNiuDomain, qiniuStr];
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
