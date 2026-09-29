//
//  myGroupInfoController.m
//  DragonTeethLive
//
//  Created by Edwin on 2023/9/20.
//

#import "myGroupInfoController.h"
#import "TUIGroupInfoController.h"
#import "myGroupMemberController.h"
#import "mySelectGroupMemberViewController.h"
#import "PopBottomView.h"
#import "myGroupMangeController.h"
#import "myContactSelectController.h"
#import "TUIGroupMemberCellData.h"
#import "myGroupBXScanController.h"

@interface myGroupInfoController ()<TUIGroupInfoControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) TUIGroupInfoController *TUIGroupInfoC;
@end

@implementation myGroupInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleName.text = eLocalizedString(@"expertTitl_detail");
    self.TUIGroupInfoC = [[TUIGroupInfoController alloc] init];
    self.TUIGroupInfoC.groupId = self.chatId;
    self.TUIGroupInfoC.delegate = self;
    self.TUIGroupInfoC.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
    [self addChildViewController:self.TUIGroupInfoC];
    [self.view addSubview:self.TUIGroupInfoC.view];
    [self.TUIGroupInfoC updateData];
    
    
}

- (void)groupInfoControllerGroupZhuanRangQunZuMethodmembers:(NSArray<TUIGroupMemberCellData *> *)members
{
    //转让群主
    if(members.count >1) {
        NSMutableArray *idenMut = [NSMutableArray array];
        for (TUIGroupMemberCellData *modelLL in members) {
            if(![[LYUserDefault userDefault].t_id isEqualToString:modelLL.identifier]) {
//                [idenMut addObject:modelLL.identifier];
                [idenMut addObject:modelLL];
            }
        }
        myContactSelectController *vc = [[myContactSelectController alloc] init];
        vc.isGroupBoo = YES;
        vc.groupId = self.chatId;
        vc.typeGroup = 3;
        vc.groupArr = idenMut;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^(NSString * _Nonnull nickNN, NSString * _Nonnull grouId) {
            [self.TUIGroupInfoC updateData];
        };
    }
}

//查看全部人员
- (void)groupInfoControllerGroupLookAllMemberMethod
{
    myGroupMemberController *vc = [[myGroupMemberController alloc] init];
    vc.chatId = self.chatId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)groupInfoControllerGroupGuanLiMethod
{
    V2TIMGroupInfo *modeInfo = [self.TUIGroupInfoC getDataMethodp];
    myGroupMangeController *vc = [[myGroupMangeController alloc] init];
    vc.chatId = self.chatId;
    vc.allMuted = modeInfo.allMuted;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)groupInfoController:(TUIGroupInfoController *)controller didSelectMembersInGroup:(NSString *)groupId
{
   
}

- (void)groupInfoController:(TUIGroupInfoController *)controller didAddMembersInGroup:(NSString *)groupId members:(NSArray<TUIGroupMemberCellData *> *)members
{
    if(members.count >0) {
        NSMutableArray *idenMut = [NSMutableArray array];
        for (TUIGroupMemberCellData *modelLL in members) {
            [idenMut addObject:modelLL.identifier];
        }
        myContactSelectController *vc = [[myContactSelectController alloc] init];
        vc.isGroupBoo = YES;
        vc.groupId = self.chatId;
        vc.typeGroup = 1;
        vc.groupArr = idenMut;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^(NSString * _Nonnull nickNN, NSString * _Nonnull grouId) {
            [self.TUIGroupInfoC updateData];
        };
    }
}

- (void)groupInfoController:(TUIGroupInfoController *)controller didDeleteMembersInGroup:(NSString *)groupId members:(NSArray<TUIGroupMemberCellData *> *)members
{
    if(members.count >1) {
        NSMutableArray *idenMut = [NSMutableArray array];
        for (TUIGroupMemberCellData *modelLL in members) {
            if(![[LYUserDefault userDefault].t_id isEqualToString:modelLL.identifier]) {
                [idenMut addObject:modelLL];
            }
        }
        myContactSelectController *vc = [[myContactSelectController alloc] init];
        vc.isGroupBoo = YES;
        vc.groupId = self.chatId;
        vc.typeGroup = 2;
        vc.groupArr = idenMut;
        [self.navigationController pushViewController:vc animated:YES];
        vc.block_ = ^(NSString * _Nonnull nickNN, NSString * _Nonnull grouId) {
            [self.TUIGroupInfoC updateData];
        };
    }
}

- (void)groupInfoController:(TUIGroupInfoController *)controller didDeleteGroup:(NSString *)groupId
{
    [self.navigationController popViewControllerAnimated:NO];
    if(self.block_) {
        self.block_();
    }
}
- (void)groupInfoController:(TUIGroupInfoController *)controller didQuitGroup:(NSString *)groupId
{
    [self.navigationController popViewControllerAnimated:NO];
    if(self.block_) {
        self.block_();
    }
}
- (void)groupInfoController:(TUIGroupInfoController *)controller didClearMsgGroup:(NSString *)groupId
{
    [self.navigationController popViewControllerAnimated:NO];
    if(self.block_) {
        self.block_();
    }
}

- (void)groupInfoController:(TUIGroupInfoController *)controller didSelectChangeBXScan:(NSString *)groupId
{
    V2TIMGroupInfo *modeInfo = [self.TUIGroupInfoC getDataMethodp];
    myGroupBXScanController *vc = [[myGroupBXScanController alloc] init];
    vc.titGroupNam = modeInfo.groupName;
    vc.avatUrl = modeInfo.faceURL;
    vc.groupStr = modeInfo.groupID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)groupInfoController:(TUIGroupInfoController *)controller didSelectChangeAvatar:(NSString *)groupId
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
        [self editerAvatorMethod:url];
    }];
}

- (void)editerAvatorMethod:(NSString *)qiniuStr
{
    [SVProgressHUD dismiss];
    NSString *faceUrl = [NSString stringWithFormat:@"%@/%@", [LYUserDefault userDefault].QiNiuDomain, qiniuStr];
    
    [[V2TIMManager sharedInstance] getGroupsInfo:@[self.chatId] succ:^(NSArray<V2TIMGroupInfoResult *> *groupResultList) {
            
        if(groupResultList.count>0) {
            V2TIMGroupInfoResult *resultModel = groupResultList[0];
            V2TIMGroupInfo *info = resultModel.info;
            info.faceURL = faceUrl;
            info.groupID = self.chatId;
            [[V2TIMManager sharedInstance] setGroupInfo:info succ:^{
                [self.TUIGroupInfoC updateData];
            } fail:^(int code, NSString *desc) {
                [SVProgressHUD showInfoWithStatus:desc];
            }];
        }
    } fail:^(int code, NSString *desc) {
        [SVProgressHUD showInfoWithStatus:desc];
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
