//
//  MHRealNameVerifyViewController.m
//  BlueEquipProject
//
//  实名认证表单页
//  - 首次进入显示空表单
//  - 已有记录则根据 status 显示：已通过 / 审核中 / 驳回
//  - 身份证照片走 COS 直传（requestToolClass postNetworkHeadImageWithUrl）
//

#import "MHRealNameVerifyViewController.h"
#import "MHRealNameManager.h"
#import "requestToolClass.h"
#import "requestUrlRFile.h"
#import "LYUserDefault.h"
#import "SVProgressHUD.h"
#import <Masonry/Masonry.h>

@interface MHRealNameVerifyViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

/// 当前查询到的实名信息（可能为 nil）
@property (nonatomic, strong, nullable) MHRealNameInfo *currentInfo;
/// 当前实名状态
@property (nonatomic, assign) MHRealNameStatus currentStatus;

/// 两个身份证照片的本地图片（上传前暂存）
@property (nonatomic, strong, nullable) UIImage *frontImage;
@property (nonatomic, strong, nullable) UIImage *backImage;
/// 两个身份证照片的 COS URL（上传后赋值）
@property (nonatomic, copy, nullable) NSString *frontURL;
@property (nonatomic, copy, nullable) NSString *backURL;

/// 当前选中要选图的位置：0=正面 1=反面
@property (nonatomic, assign) NSInteger pickingImageIndex;

#pragma mark - UI

@property (nonatomic, strong) UIScrollView *scrollView;

/// 顶部状态卡片（根据 status 动态显示/隐藏）
@property (nonatomic, strong) UIView *statusCardView;
@property (nonatomic, strong) UILabel *statusTitleLabel;
@property (nonatomic, strong) UILabel *statusDetailLabel;

/// 表单区
@property (nonatomic, strong) UIView *formContainer;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *idCardField;
@property (nonatomic, strong) UITextField *phoneField;

/// 两张身份证照片容器
@property (nonatomic, strong) UIView *frontContainer;
@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UILabel *frontPlaceholderLabel;

@property (nonatomic, strong) UIView *backContainer;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *backPlaceholderLabel;

/// 提交按钮
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation MHRealNameVerifyViewController

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.97 alpha:1.0];
    self.currentStatus = MHRealNameStatusUnknown;

    [self setupUI];
    [self loadRealnameStatus];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - 搭建 UI

- (void)setupUI {
    UIScrollView *sv = [[UIScrollView alloc] init];
    sv.backgroundColor = [UIColor clearColor];
    sv.alwaysBounceVertical = YES;
    sv.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:sv];
    self.scrollView = sv;
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.bottom.equalTo(self.view);
    }];

    UIView *content = [[UIView alloc] init];
    content.backgroundColor = [UIColor clearColor];
    [sv addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv);
        make.width.equalTo(sv);
    }];

    // ===== 状态卡片 =====
    self.statusCardView = [self _buildStatusCard];
    [content addSubview:self.statusCardView];
    [self.statusCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(content).offset(12);
        make.left.equalTo(content).offset(16);
        make.right.equalTo(content).offset(-16);
    }];

    // ===== 表单容器 =====
    self.formContainer = [[UIView alloc] init];
    self.formContainer.backgroundColor = [UIColor whiteColor];
    self.formContainer.layer.cornerRadius = 12;
    self.formContainer.layer.masksToBounds = YES;
    [content addSubview:self.formContainer];
    [self.formContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusCardView.mas_bottom).offset(12);
        make.left.equalTo(content).offset(16);
        make.right.equalTo(content).offset(-16);
        make.bottom.equalTo(content).offset(-30);
    }];

    // ---- 姓名 ----
    self.nameField = [self _buildTextField:@"请输入真实姓名"];
    [self.formContainer addSubview:self.nameField];
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.formContainer).offset(16);
        make.left.equalTo(self.formContainer).offset(12);
        make.right.equalTo(self.formContainer).offset(-12);
        make.height.mas_equalTo(44);
    }];

    // ---- 身份证号 ----
    self.idCardField = [self _buildTextField:@"请输入 18 位身份证号"];
    self.idCardField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.formContainer addSubview:self.idCardField];
    [self.idCardField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameField.mas_bottom).offset(10);
        make.left.right.height.equalTo(self.nameField);
    }];

    // ---- 手机号 ----
    self.phoneField = [self _buildTextField:@"手机号（选填）"];
    self.phoneField.keyboardType = UIKeyboardTypePhonePad;
    [self.formContainer addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.idCardField.mas_bottom).offset(10);
        make.left.right.height.equalTo(self.nameField);
    }];

    // ---- 身份证正面照片 ----
    UIView *frontC = [self _buildImageContainer];
    self.frontContainer = frontC;
    [self.formContainer addSubview:frontC];

    self.frontImageView = [[UIImageView alloc] init];
    self.frontImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.frontImageView.clipsToBounds = YES;
    self.frontImageView.hidden = YES;
    [frontC addSubview:self.frontImageView];

    self.frontPlaceholderLabel = [[UILabel alloc] init];
    self.frontPlaceholderLabel.text = @"点击上传身份证正面\n（人像面）";
    self.frontPlaceholderLabel.numberOfLines = 0;
    self.frontPlaceholderLabel.textAlignment = NSTextAlignmentCenter;
    self.frontPlaceholderLabel.textColor = [UIColor lightGrayColor];
    self.frontPlaceholderLabel.font = [UIFont systemFontOfSize:13];
    [frontC addSubview:self.frontPlaceholderLabel];

    [frontC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneField.mas_bottom).offset(14);
        make.left.equalTo(self.formContainer).offset(12);
        make.right.equalTo(self.formContainer).offset(-12);
        make.height.mas_equalTo(160);
    }];
    [self.frontImageView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(frontC); }];
    [self.frontPlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(frontC); }];

    // ---- 身份证反面照片 ----
    UIView *backC = [self _buildImageContainer];
    self.backContainer = backC;
    [self.formContainer addSubview:backC];

    self.backImageView = [[UIImageView alloc] init];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backImageView.clipsToBounds = YES;
    self.backImageView.hidden = YES;
    [backC addSubview:self.backImageView];

    self.backPlaceholderLabel = [[UILabel alloc] init];
    self.backPlaceholderLabel.text = @"点击上传身份证反面\n（国徽面）";
    self.backPlaceholderLabel.numberOfLines = 0;
    self.backPlaceholderLabel.textAlignment = NSTextAlignmentCenter;
    self.backPlaceholderLabel.textColor = [UIColor lightGrayColor];
    self.backPlaceholderLabel.font = [UIFont systemFontOfSize:13];
    [backC addSubview:self.backPlaceholderLabel];

    [backC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(frontC.mas_bottom).offset(10);
        make.left.right.height.equalTo(frontC);
    }];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.equalTo(backC); }];
    [self.backPlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) { make.center.equalTo(backC); }];

    // ---- 提交按钮 ----
    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.submitButton setTitle:@"提交认证" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.submitButton.backgroundColor = [UIColor colorWithRed:0.30 green:0.59 blue:0.98 alpha:1.0];
    self.submitButton.layer.cornerRadius = 22;
    self.submitButton.layer.masksToBounds = YES;
    [self.submitButton addTarget:self action:@selector(_onSubmitTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.formContainer addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backC.mas_bottom).offset(18);
        make.left.equalTo(self.formContainer).offset(12);
        make.right.equalTo(self.formContainer).offset(-12);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(self.formContainer).offset(-18);
    }];

    // 默认隐藏状态卡片（只改 hidden 不动约束）
    self.statusCardView.hidden = YES;
}

#pragma mark - 辅助构建

- (UIView *)_buildStatusCard {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    v.layer.cornerRadius = 12;
    v.layer.masksToBounds = YES;

    self.statusTitleLabel = [[UILabel alloc] init];
    self.statusTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    [v addSubview:self.statusTitleLabel];
    [self.statusTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v).offset(14);
        make.left.equalTo(v).offset(14);
        make.right.equalTo(v).offset(-14);
    }];

    self.statusDetailLabel = [[UILabel alloc] init];
    self.statusDetailLabel.font = [UIFont systemFontOfSize:13];
    self.statusDetailLabel.textColor = [UIColor grayColor];
    self.statusDetailLabel.numberOfLines = 0;
    [v addSubview:self.statusDetailLabel];
    [self.statusDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusTitleLabel.mas_bottom).offset(6);
        make.left.right.equalTo(self.statusTitleLabel);
        make.bottom.equalTo(v).offset(-14);
    }];
    return v;
}

- (UITextField *)_buildTextField:(NSString *)placeholder {
    UITextField *tf = [[UITextField alloc] init];
    tf.borderStyle = UITextBorderStyleNone;
    tf.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.98 alpha:1.0];
    tf.layer.cornerRadius = 6;
    tf.layer.masksToBounds = YES;
    tf.placeholder = placeholder;
    tf.font = [UIFont systemFontOfSize:14];
    tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.delegate = self;
    return tf;
}

- (UIView *)_buildImageContainer {
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.98 alpha:1.0];
    v.layer.cornerRadius = 6;
    v.layer.masksToBounds = YES;
    v.layer.borderWidth = 1;
    v.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    v.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_onImageContainerTapped:)];
    [v addGestureRecognizer:tap];
    return v;
}

#pragma mark - 加载实名状态

- (void)loadRealnameStatus {
    __weak typeof(self) weakSelf = self;
    [[MHRealNameManager shared] fetchStatus:^(BOOL required, MHRealNameStatus status, MHRealNameInfo * _Nullable info, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) return;
            if (error) {
                NSLog(@"[RealName] fetchStatus error: %@", error.localizedDescription);
                // 网络错误就当未提交处理，空表单
                return;
            }
            strongSelf.currentInfo = info;
            strongSelf.currentStatus = status;
            [strongSelf _applyStatusUI];
        });
    }];
}

#pragma mark - 根据 status 渲染 UI

/// 核心思路：不再重新 remakeConstraints，只通过 hidden 和 enabled 切换。
/// 状态卡片只切换 hidden，它的 size 由子 label 的 intrinsicContentSize 决定。
- (void)_applyStatusUI {
    switch (self.currentStatus) {
        case MHRealNameStatusApproved:
            [self _renderApprovedUI];
            break;
        case MHRealNameStatusPending:
            [self _renderPendingUI];
            break;
        case MHRealNameStatusRejected:
            [self _renderRejectedUI];
            break;
        case MHRealNameStatusNone:
        case MHRealNameStatusUnknown:
        default:
            [self _renderNoneUI];
            break;
    }
}

- (void)_renderApprovedUI {
    self.statusTitleLabel.text = @"✓ 已实名认证";
    self.statusTitleLabel.textColor = [UIColor colorWithRed:0.20 green:0.78 blue:0.35 alpha:1.0];
    self.statusDetailLabel.text = [NSString stringWithFormat:@"身份证：%@", self.currentInfo.idCardMasked ?: @"—"];
    self.statusCardView.backgroundColor = [UIColor colorWithRed:0.92 green:0.99 blue:0.94 alpha:1.0];
    self.statusCardView.hidden = NO;

    self.nameField.enabled = NO;
    self.idCardField.enabled = NO;
    self.phoneField.enabled = NO;
    self.frontContainer.userInteractionEnabled = NO;
    self.backContainer.userInteractionEnabled = NO;

    [self.submitButton setTitle:@"完成" forState:UIControlStateNormal];
    self.submitButton.backgroundColor = [UIColor colorWithRed:0.20 green:0.78 blue:0.35 alpha:1.0];
    [self.submitButton removeTarget:self action:@selector(_onSubmitTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton addTarget:self action:@selector(_onDoneTapped) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_renderPendingUI {
    self.statusTitleLabel.text = @"⏳ 审核中";
    self.statusTitleLabel.textColor = [UIColor orangeColor];
    self.statusDetailLabel.text = @"请耐心等待，通常 1-3 个工作日完成审核";
    self.statusCardView.backgroundColor = [UIColor colorWithRed:1.0 green:0.97 blue:0.90 alpha:1.0];
    self.statusCardView.hidden = NO;

    self.nameField.enabled = NO;
    self.idCardField.enabled = NO;
    self.phoneField.enabled = NO;
    self.frontContainer.userInteractionEnabled = NO;
    self.backContainer.userInteractionEnabled = NO;
    self.submitButton.hidden = YES;
}

- (void)_renderRejectedUI {
    NSString *reason = self.currentInfo.rejectReason.length > 0 ? self.currentInfo.rejectReason : @"信息不符合要求";
    self.statusTitleLabel.text = @"✗ 认证未通过";
    self.statusTitleLabel.textColor = [UIColor redColor];
    self.statusDetailLabel.text = [NSString stringWithFormat:@"原因：%@\n请修改后重新提交", reason];
    self.statusCardView.backgroundColor = [UIColor colorWithRed:1.0 green:0.93 blue:0.93 alpha:1.0];
    self.statusCardView.hidden = NO;

    self.nameField.enabled = YES;
    self.idCardField.enabled = YES;
    self.phoneField.enabled = YES;
    self.frontContainer.userInteractionEnabled = YES;
    self.backContainer.userInteractionEnabled = YES;
    self.submitButton.hidden = NO;

    [self.submitButton setTitle:@"重新提交" forState:UIControlStateNormal];
    self.submitButton.backgroundColor = [UIColor colorWithRed:0.30 green:0.59 blue:0.98 alpha:1.0];
}

- (void)_renderNoneUI {
    self.statusCardView.hidden = YES;

    self.nameField.enabled = YES;
    self.idCardField.enabled = YES;
    self.phoneField.enabled = YES;
    self.frontContainer.userInteractionEnabled = YES;
    self.backContainer.userInteractionEnabled = YES;
    self.submitButton.hidden = NO;

    [self.submitButton setTitle:@"提交认证" forState:UIControlStateNormal];
    self.submitButton.backgroundColor = [UIColor colorWithRed:0.30 green:0.59 blue:0.98 alpha:1.0];
}

#pragma mark - 图片选择

- (void)_onImageContainerTapped:(UITapGestureRecognizer *)tap {
    if (tap.view == self.frontContainer) {
        self.pickingImageIndex = 0;
    } else {
        self.pickingImageIndex = 1;
    }
    [self _presentImagePickerActionSheet];
}

- (void)_presentImagePickerActionSheet {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [sheet addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self _presentPickerWithSource:UIImagePickerControllerSourceTypeCamera];
        }]];
    }
    [sheet addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self _presentPickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:sheet animated:YES completion:nil];
}

- (void)_presentPickerWithSource:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage] ?: info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];

    if (!image) return;

    UIImage *fixed = [self _fixOrientation:image];
    NSData *data = [self _compressImage:fixed toMaxBytes:1024 * 1024];
    if (!data) return;

    if (self.pickingImageIndex == 0) {
        self.frontImage = fixed;
        self.frontImageView.image = fixed;
        self.frontImageView.hidden = NO;
        self.frontPlaceholderLabel.hidden = YES;
    } else {
        self.backImage = fixed;
        self.backImageView.image = fixed;
        self.backImageView.hidden = NO;
        self.backPlaceholderLabel.hidden = YES;
    }

    [SVProgressHUD showWithStatus:@"上传中..."];
    __weak typeof(self) weakSelf = self;

    // ===== 先拿临时凭证（和其他页面完全一致的链路） =====
    [requestToolClass getNetworkTwoWithUrl:request_upload_getTmpCredential isShow:NO success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        [LYUserDefault saveQCloudDic:info];

        // ===== 再 COS 直传 =====
        [requestToolClass postNetworkHeadImageWithUrl:request_login_uploadImages
                                             typMehtod:1
                                        andImageData:@[data]
                                              success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [SVProgressHUD dismiss];
                if (!strongSelf) return;
                if (code != 200) {
                    [SVProgressHUD showErrorWithStatus:msg.length > 0 ? msg : @"上传失败"];
                    [strongSelf _revertImageUI:strongSelf.pickingImageIndex];
                    return;
                }
                NSArray *urls = [info isKindOfClass:[NSArray class]] ? info : nil;
                NSString *url = urls.firstObject;
                if (![url isKindOfClass:[NSString class]] || url.length == 0) {
                    [SVProgressHUD showErrorWithStatus:@"上传失败"];
                    [strongSelf _revertImageUI:strongSelf.pickingImageIndex];
                    return;
                }
                if (strongSelf.pickingImageIndex == 0) {
                    strongSelf.frontURL = url;
                } else {
                    strongSelf.backURL = url;
                }
                [SVProgressHUD showSuccessWithStatus:@"上传成功"];
            });
        } fail:^(NSString * _Nonnull errorStr) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [SVProgressHUD dismiss];
                if (!strongSelf) return;
                [SVProgressHUD showErrorWithStatus:errorStr.length > 0 ? errorStr : @"上传失败"];
                [strongSelf _revertImageUI:strongSelf.pickingImageIndex];
            });
        }];
    } fail:^(NSString * _Nonnull errorStr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:errorStr.length > 0 ? errorStr : @"获取凭证失败"];
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (!strongSelf) return;
            [strongSelf _revertImageUI:strongSelf.pickingImageIndex];
        });
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)_revertImageUI:(NSInteger)index {
    if (index == 0) {
        self.frontImage = nil;
        self.frontURL = nil;
        self.frontImageView.image = nil;
        self.frontImageView.hidden = YES;
        self.frontPlaceholderLabel.hidden = NO;
    } else {
        self.backImage = nil;
        self.backURL = nil;
        self.backImageView.image = nil;
        self.backImageView.hidden = YES;
        self.backPlaceholderLabel.hidden = NO;
    }
}

#pragma mark - 图片工具

- (UIImage *)_fixOrientation:(UIImage *)image {
    if (image.imageOrientation == UIImageOrientationUp) return image;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalized ?: image;
}

- (NSData *)_compressImage:(UIImage *)image toMaxBytes:(NSUInteger)maxBytes {
    CGFloat quality = 0.8;
    NSData *data = UIImageJPEGRepresentation(image, quality);
    while (data.length > maxBytes && quality > 0.1) {
        quality -= 0.1;
        data = UIImageJPEGRepresentation(image, quality);
    }
    return data;
}

#pragma mark - 表单校验 & 提交

- (BOOL)_validateForm {
    NSString *name = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *idCard = [self.idCardField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *phone = [self.phoneField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    if (name.length < 2 || name.length > 20) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的真实姓名"];
        return NO;
    }
    if (idCard.length != 18) {
        [SVProgressHUD showErrorWithStatus:@"请输入 18 位身份证号"];
        return NO;
    }
    NSString *regex = @"^[0-9]{17}[0-9Xx]$";
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex] evaluateWithObject:idCard]) {
        [SVProgressHUD showErrorWithStatus:@"身份证号格式不正确"];
        return NO;
    }
    if (phone.length > 0) {
        if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]{11}$"] evaluateWithObject:phone]) {
            [SVProgressHUD showErrorWithStatus:@"手机号格式不正确"];
            return NO;
        }
    }
    if (self.frontURL.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传身份证正面照片"];
        return NO;
    }
    if (self.backURL.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请上传身份证反面照片"];
        return NO;
    }
    return YES;
}

- (void)_onSubmitTapped {
    if (![self _validateForm]) return;

    [SVProgressHUD showWithStatus:@"提交中..."];
    __weak typeof(self) weakSelf = self;
    [[MHRealNameManager shared] submitWithRealName:self.nameField.text
                                         idCardNo:self.idCardField.text
                                            phone:self.phoneField.text.length > 0 ? self.phoneField.text : nil
                                       idCardFront:self.frontURL
                                        idCardBack:self.backURL
                                        completion:^(BOOL success, MHRealNameStatus status, NSString * _Nullable msg, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [SVProgressHUD dismiss];
            if (!strongSelf) return;
            if (!success) {
                [SVProgressHUD showErrorWithStatus:msg.length > 0 ? msg : (error.localizedDescription ?: @"提交失败")];
                return;
            }
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            strongSelf.currentStatus = status;
            [strongSelf loadRealnameStatus];

            if (status == MHRealNameStatusApproved && strongSelf.onVerifiedBlock) {
                strongSelf.onVerifiedBlock();
            }
        });
    }];
}

- (void)_onDoneTapped {
    if (self.onVerifiedBlock) {
        self.onVerifiedBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.idCardField) {
        NSUInteger newLen = textField.text.length - range.length + string.length;
        if (newLen > 18) return NO;
        if ([string isEqualToString:@"x"]) {
            textField.text = [textField.text stringByReplacingCharactersInRange:range withString:@"X"];
            return NO;
        }
    }
    if (textField == self.phoneField) {
        NSUInteger newLen = textField.text.length - range.length + string.length;
        if (newLen > 11) return NO;
    }
    return YES;
}

@end
