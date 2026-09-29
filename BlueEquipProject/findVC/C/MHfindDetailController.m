//
//  MHfindDetailController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import "MHfindDetailController.h"
#import "MHfindDetailModel.h"
#import "MHfindDetailSubCell.h"
#import "MHfindDetailCell.h"
#import "MWPhotoBrowser.h"
#import "MHfindDetailOneView.h"
#import "communityTHotDetaillBottomView.h"
#import "communityTHDetailInputView.h"
#import "MHReportJBViewController.h"
#import "MHApplyVoteListController.h"

@interface MHfindDetailController ()<UITableViewDelegate, UITableViewDataSource, MHfindDetailCellDelegate, MHfindDetailSubCellDelegate, MWPhotoBrowserDelegate, MHfindDetailOneViewDelaget>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) int pageN;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic,strong) communityTHDetailInputView *communityTHDetailInputV;//输入界面
@property (nonatomic,strong) communityTHotDetaillBottomView *communityTHotDetaillBottomV;
@property (nonatomic, strong) NSDictionary *detaiDic;
@property (nonatomic, copy) NSString *cid_str;
@property (nonatomic, copy) NSString *toUserId_str;
@property (nonatomic, assign) BOOL isRRRRR;
@end

@implementation MHfindDetailController

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
    self.titleName.text = eLocalizedString(@"plaza_all29");
    self.navView.backgroundColor = RGB(247, 247, 247);
    
    self.cid_str = @"";
    self.toUserId_str = @"";

    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    self.photos = [NSMutableArray array];
    self.datasMut = [NSMutableArray array];
 
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT-TARBARHEIGHT-5) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    _appTableView.dragInteractionEnabled = YES;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHfindDetailOneView class] forCellReuseIdentifier:@"MHfindDetailOneView"];
    [self.appTableView registerClass:[MHfindDetailCell class] forCellReuseIdentifier:@"MHfindDetailCell"];
    [self.appTableView registerClass:[MHfindDetailSubCell class] forCellReuseIdentifier:@"MHfindDetailSubCell"];
    [self.view addSubview:_appTableView];
    
//    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, 300+NAVHEIGHT, _window_width, _window_height-NAVHEIGHT-300-TARBARHEIGHT-5)];
//    [self.appTableView addSubview:self.noDataImgV];
//    self.noDataImgV.hidden = YES;
    
    self.communityTHotDetaillBottomV = [[communityTHotDetaillBottomView alloc] initWithFrame:CGRectMake(0, _window_height-TARBARHEIGHT-5, _window_width, 54)];
    [self.view addSubview:self.communityTHotDetaillBottomV];

    WEAKSELF
    self.communityTHotDetaillBottomV.block_ = ^(NSInteger typeN) {
      
        [weakSelf showUIUIUI];
    };
    
    [self loadrefreshing];
    [self uploadDataMehtod];
    
    if(![self.modelM.uid isEqualToString:[LYUserDefault userDefault].t_id]) {
        UIButton *rightImgBnt2 = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-50, TIMESTATUSHEIGHT, 44, 44)];
        [rightImgBnt2 setImage:[UIImage imageNamed:@"ModeImgs7_77"] forState:UIControlStateNormal];
        [rightImgBnt2 addTarget:self action:@selector(rightImageActiUIUI) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:rightImgBnt2];
    }
}

- (void)uploadDataMehtod
{
    NSDictionary *dicWWW = @{};
    if(self.modelM.activityId) {
        dicWWW = @{@"recordId":minStr(self.modelM.activityId), @"type":self.modelM.type};
    }else {
        dicWWW = @{@"recordId":minStr(self.modelM.recordId), @"type":self.modelM.type};
    }
    [requestToolClass postNetworkWithUrl:request_square_detail andParameter:dicWWW success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            self.detaiDic = info;
            if([info[@"basicInfo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dc_MM = info[@"basicInfo"];
                self.modelM = [MHfindSubPatternsModel mj_objectWithKeyValues:dc_MM];
                [self.appTableView reloadData];
            }
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
    
}

//MARK: 举报
- (void)rightImageActiUIUI
{
    MHReportJBViewController *vc = [[MHReportJBViewController alloc] init];
    vc.typeL = self.modelM.type;
    if(self.modelM.activityId) {
        vc.targetIId = self.modelM.activityId;
    }else {
        vc.targetIId = self.modelM.recordId;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showUIUIUI
{
    self.cid_str = @"";
    self.toUserId_str = @"";
    [self.communityTHDetailInputV removeFromSuperview];
    self.communityTHDetailInputV = [[communityTHDetailInputView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:self.communityTHDetailInputV];
    [self.communityTHDetailInputV.input_textF becomeFirstResponder];
    self.communityTHDetailInputV.photo_Btn.enabled = YES;
    self.communityTHDetailInputV.video_Btn.enabled = YES;
    self.communityTHDetailInputV.face_Btn.enabled = YES;
//    if (self.msgVideos.count > 0) {
//        self.communityTHDetailInputV.video_Btn.enabled = YES;
//        self.communityTHDetailInputV.photo_Btn.enabled = NO;
//
//        [self.communityTHDetailInputV addImgsArr:@[] video:self.msgPhotos];
//    }else if (self.msgPhotos.count > 0) {
//        self.communityTHDetailInputV.video_Btn.enabled = NO;
//        self.communityTHDetailInputV.photo_Btn.enabled = YES;
//
//        [self.communityTHDetailInputV addImgsArr:self.msgPhotos video:@[]];
//    }
    
    WEAKSELF
    self.communityTHDetailInputV.block_ = ^(NSInteger tyepN, NSString * _Nonnull nameS) {
      
        if (tyepN == 1) {
            weakSelf.communityTHDetailInputV.hidden = YES;
        }
        else if (tyepN == 3) {

//            [weakSelf choosePhotosMethod];
        }else if (tyepN == 4) {

//            [weakSelf chooseVideoMethod];
        }else if (tyepN == 2) {

            [weakSelf rightRImageHAction];
        }else if (tyepN == 5) {
//            [weakSelf deleImgsss:[nameS integerValue]];
        }
    };
}

- (void)showUIUIUITwoSub
{
    [self.communityTHDetailInputV removeFromSuperview];
    self.communityTHDetailInputV = [[communityTHDetailInputView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    [self.view addSubview:self.communityTHDetailInputV];
    [self.communityTHDetailInputV.input_textF becomeFirstResponder];
    self.communityTHDetailInputV.photo_Btn.enabled = YES;
    self.communityTHDetailInputV.video_Btn.enabled = YES;
    self.communityTHDetailInputV.face_Btn.enabled = YES;
    WEAKSELF
    self.communityTHDetailInputV.block_ = ^(NSInteger tyepN, NSString * _Nonnull nameS) {
      
        if (tyepN == 1) {
            weakSelf.communityTHDetailInputV.hidden = YES;
        }else if (tyepN == 2) {
            [weakSelf rightRImageHAction];
        }
    };
}

//MARK: 发布评论
- (void)rightRImageHAction
{
    if (self.communityTHDetailInputV.input_textF.text.length > 0) {
        
        if(self.isRRRRR) {
            return;
        }
        self.isRRRRR = YES;
        [SVProgressHUD show];
        if(self.cid_str.length > 0) {
            
            NSDictionary *dicM = @{@"cid":self.cid_str, @"toUserId":self.toUserId_str, @"content":minStr(self.communityTHDetailInputV.input_textF.text)};
            
            [requestToolClass postNetworkWithUrl:request_comment_reply andParameter:dicM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                self.isRRRRR = NO;
//                [self loadHeadData];
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err4")];
            } fail:^(NSString * _Nonnull msg) {
                self.isRRRRR = NO;
            }];
        }else {
            NSDictionary *dicM = @{@"mappingId":minStr(self.modelM.recordId), @"type":self.modelM.type, @"content":minStr(self.communityTHDetailInputV.input_textF.text)};
            if(self.modelM.activityId) {
                dicM = @{@"mappingId":minStr(self.modelM.activityId), @"type":self.modelM.type, @"content":minStr(self.communityTHDetailInputV.input_textF.text)};
            }
            [requestToolClass postNetworkWithUrl:request_comment_post andParameter:dicM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                self.isRRRRR = NO;
//                [self loadHeadData];
                [SVProgressHUD showInfoWithStatus:eLocalizedString(@"login_err4")];
            } fail:^(NSString * _Nonnull msg) {
                self.isRRRRR = NO;
            }];
        }
    }
}


-(void)loadrefreshing {
    
    WEAKSELF
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeadData];
    }];
    
    // 马上进入刷新状态
    [self.appTableView.mj_header beginRefreshing];

//     设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
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
    NSDictionary *dicMM = @{};
    if(self.modelM.activityId) {
        dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"mappingId":self.modelM.activityId, @"type":self.modelM.type};
    }else {
        dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"mappingId":self.modelM.recordId, @"type":self.modelM.type};
    }
//    if([self.modelM.type isEqualToString:@"ACTIVITY"]) {
//        dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"mappingId":self.modelM.activityId, @"type":self.modelM.type};
//    }else {
//        dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"mappingId":self.modelM.recordId, @"type":self.modelM.type};
//    }
    
    [requestToolClass postNetworkWithUrl:request_comment_pageComment andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            
            if(self.pageN == 1) {
                [self.datasMut removeAllObjects];
            }
            NSArray *listAr = info[@"records"];
            for (NSDictionary *dicM in listAr) {
                
                NSArray *arrTwo = dicM[@"subCommentList"];
                
                NSMutableArray *listA = [NSMutableArray array];
                MHfindDetailModel *model = [MHfindDetailModel mj_objectWithKeyValues:dicM];
                for (NSDictionary *dicDIc in arrTwo) {
                    MHfindDetailModel *modelSub = [MHfindDetailModel mj_objectWithKeyValues:dicDIc];
                    [listA addObject:modelSub];
                }
                model.subArr = listA;
                [self.datasMut addObject:model];
            }
            if(listAr <= 0) {
                [self.appTableView.mj_header endRefreshing];
                [self.appTableView.mj_footer endRefreshingWithNoMoreData];
            }else {
                [self.appTableView.mj_header endRefreshing];
                [self.appTableView.mj_footer endRefreshing];
            }
            [self.appTableView reloadData];
        }else {
            [self.appTableView.mj_header endRefreshing];
            [self.appTableView.mj_footer endRefreshing];
        }
        self.isRRRRR = NO;
    } fail:^(NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
        self.isRRRRR = NO;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1+self.datasMut.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 1;
    }else {
        MHfindDetailModel *modelSub = self.datasMut[section-1];
        return modelSub.subArr.count+1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        
        MHfindDetailOneView *cell = [MHfindDetailOneView cellWithTabelView:tableView];
        [cell addDataToDic:self.modelM row:indexPath dicDetail:self.detaiDic];
        cell.delegate_ = self;
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MHfindDetailModel *modelSub = self.datasMut[indexPath.section-1];
        if(indexPath.row == 0) {
            MHfindDetailCell *cell = [MHfindDetailCell cellWithTabelView:tableView];
            [cell addDataToModel:modelSub indeP:indexPath];
            cell.delegate_ = self;
            cell.backgroundColor = UIColor.whiteColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            MHfindDetailSubCell *cell = [MHfindDetailSubCell cellWithTabelView:tableView];
            [cell addDataToModel:modelSub.subArr[indexPath.row-1] indeP:indexPath];
            cell.delegate_ = self;
            cell.backgroundColor = UIColor.whiteColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

//MARK:  一级评论
- (void)findDetailCellDelegateNum:(NSInteger)typeN indP:(NSIndexPath *)indPP
{
    MHfindDetailModel *modelSub = self.datasMut[indPP.section-1];
    if(typeN == 1) {
        self.cid_str = minStr(modelSub.cid);
        [self showUIUIUITwoSub];
    }else if (typeN == 2) {
        
        //删除
        if(self.isRRRRR) {
            return;
        }
        self.isRRRRR = YES;
        
        [requestToolClass getNetworkWithUrl:request_comment_delete andParameter:@{@"cid":minStr(modelSub.cid)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.isRRRRR = NO;
            
            [self.datasMut removeObjectAtIndex:indPP.section-1];
            [self.appTableView reloadData];
        } fail:^(NSString * _Nonnull msg) {
            self.isRRRRR = NO;
        }];
    }else if (typeN == 3) {
        
        //点赞
        if(self.isRRRRR) {
            return;
        }
        self.isRRRRR = YES;
        
        [requestToolClass getNetworkWithUrl:request_comment_likeOrDislike andParameter:@{@"cid":minStr(modelSub.cid)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.isRRRRR = NO;
            
            modelSub.isLikes = !modelSub.isLikes;
            if(modelSub.isLikes) {
                modelSub.likesCount = modelSub.likesCount+1;
            }else {
                if(modelSub.likesCount>0) {
                    modelSub.likesCount = modelSub.likesCount-1;
                }
            }
//            [self.appTableView reloadData];
            [self.appTableView reloadRowsAtIndexPaths:@[indPP] withRowAnimation:UITableViewRowAnimationNone];
        } fail:^(NSString * _Nonnull msg) {
            self.isRRRRR = NO;
        }];
    }else {
        if(![minStr(modelSub.uid) isEqualToString:[LYUserDefault userDefault].t_id]) {
            MHReportJBViewController *vc = [[MHReportJBViewController alloc] init];
            vc.typeL = @"COMMENT";
            vc.targetIId = minStr(modelSub.id);
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}
//MARK: 二级评论
- (void)findDetailSubCellDelegateNum:(NSInteger)typeN indP:(NSIndexPath *)indPP
{
    MHfindDetailModel *modelSub = self.datasMut[indPP.section-1];
    MHfindDetailModel *SubMol = modelSub.subArr[indPP.row-1];
    if(typeN == 1) {
        
        self.cid_str = minStr(modelSub.cid);
        self.toUserId_str = minStr(SubMol.uid);
        [self showUIUIUITwoSub];
    }else if (typeN == 2) {
        
        //删除
        if(self.isRRRRR) {
            return;
        }
        self.isRRRRR = YES;
        
        [requestToolClass getNetworkWithUrl:request_comment_delete andParameter:@{@"cid":minStr(SubMol.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.isRRRRR = NO;
            
            [modelSub.subArr removeObjectAtIndex:indPP.row-1];
            [self.appTableView reloadData];
        } fail:^(NSString * _Nonnull msg) {
            self.isRRRRR = NO;
        }];
    }else if (typeN == 3) {
        
        //点赞
        if(self.isRRRRR) {
            return;
        }
        self.isRRRRR = YES;
        
        [requestToolClass getNetworkWithUrl:request_comment_likeOrDislike andParameter:@{@"cid":minStr(SubMol.id)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
            
            self.isRRRRR = NO;
            
            SubMol.isLikes = !SubMol.isLikes;
            if(SubMol.isLikes) {
                SubMol.likesCount = SubMol.likesCount+1;
            }else {
                if(SubMol.likesCount>0) {
                    SubMol.likesCount = SubMol.likesCount-1;
                }
            }
            [self.appTableView reloadRowsAtIndexPaths:@[indPP] withRowAnimation:UITableViewRowAnimationNone];
        } fail:^(NSString * _Nonnull msg) {
            self.isRRRRR = NO;
        }];
    }else {
        
        if(![minStr(SubMol.uid) isEqualToString:[LYUserDefault userDefault].t_id]) {
            MHReportJBViewController *vc = [[MHReportJBViewController alloc] init];
            vc.typeL = @"COMMENT";
            vc.targetIId = minStr(SubMol.id);
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

//MARK: 刷新
- (void)findDetailUploadMethod
{
    [self uploadDataMehtod];
}

-(void)focusOrGoodOrComment:(NSInteger)typeN indexPath:(NSIndexPath *)indexPath
{
    if(typeN == 1) {
        if(!self.modelM.isFollowed) {
            NSString *urlMM = [NSString stringWithFormat:@"%@?followingId=%@", request_user_followOrUnfollow, self.modelM.uid];
            [requestToolClass getNetworkWithUrl:urlMM andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                self.modelM.isFollowed = !self.modelM.isFollowed;
                [self.appTableView reloadData];
            } fail:^(NSString * _Nonnull msg) {
                
            }];
        }else {
            [[FloatingWindowModel shareInstance] switchChatDetailControlNick:self.modelM.nickName hostId:self.modelM.uid];
        }
    }else {
        
        //MARK: 查看申请列表
        MHApplyVoteListController *listVC = [[MHApplyVoteListController alloc] init];
        listVC.recordId = self.modelM.recordId;
        listVC.typeMML = self.modelM.type;
        [self.navigationController pushViewController:listVC animated:YES];
    }
}
- (void)fileClick:(NSArray *)array row:(NSInteger)row indexPath:(NSIndexPath *)indexPath
{
    if (row == 39000) {
        
        [self playVideoMethod:[NSURL URLWithString:array[0]]];
    }else {
        
        [self.photos removeAllObjects];
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

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if(section == 0) {
//        if([self.modelM.type isEqualToString:@"ACTIVITY"]) {
//            return 52;
//        }else {
//            return 0;
//        }
//    }else {
//        return 0;
//    }
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if(section == 0){
//        if([self.modelM.type isEqualToString:@"ACTIVITY"]) {
//            UIView *tpppV = [tableView viewWithTag:21001];
//            if(!tpppV) {
//                tpppV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 52)];
//                tpppV.backgroundColor = UIColor.whiteColor;
//                
//                UIView *linvV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 10)];
//                linvV.backgroundColor = RGB(243, 224, 251);
//                [tpppV addSubview:linvV];
//                
//                UILabel *pingLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
//                pingLab.frame = CGRectMake(12, 10, _window_width-24, 42);
//                pingLab.text = eLocalizedString(@"find_detail5");
//                [tpppV addSubview:pingLab];
//            }
//            return tpppV;
//        }else {
//            return nil;
//        }
//    }else {
//        return nil;
//    }
//}

@end
