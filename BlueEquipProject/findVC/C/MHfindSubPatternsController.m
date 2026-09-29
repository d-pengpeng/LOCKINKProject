//
//  MHfindSubPatternsController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/3.
//

#import "MHfindSubPatternsController.h"
#import "MHfindSubPatternsCell.h"
#import "MHfindSubPatternsModel.h"
#import "MWPhotoBrowser.h"
#import "MHPostSquareController.h"
#import "MHSquareRankingController.h"
#import "MHfindDetailController.h"
#import "MHfindChooseView.h"
#import "MHPlaceVCell.h"

@interface MHfindSubPatternsController ()<UITableViewDelegate, UITableViewDataSource, MHfindSubPatternsCelDelaget, MWPhotoBrowserDelegate, postTopicContrDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) int pageN;
@property (nonatomic, assign) BOOL isRRRR;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) UIView *topVVV;
@property (nonatomic, copy) NSString *two_categoy;
@property (nonatomic, strong) NSArray *toys_arr;
@property (nonatomic, strong) NSArray *toys_arr2;
@end

@implementation MHfindSubPatternsController
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
    
    CGFloat yy_y = (_window_width-24)*130/351;
    if(yy_y>200) {
        yy_y = 200;
    }
    self.view.backgroundColor = RGB(1, 0, 2);
    
    /*
     NSURL *url = [NSURL URLWithString:@"music://"];
     [[UIApplication sharedApplication] openURL:url];
     */
    self.photos = [NSMutableArray array];
//    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 16+yy_y, _window_width, _window_height-NAVHEIGHT-14-16-yy_y) style:UITableViewStylePlain];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 16, _window_width, _window_height-NAVHEIGHT-14-16) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    _appTableView.dragInteractionEnabled = YES;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHfindSubPatternsCell class] forCellReuseIdentifier:@"MHfindSubPatternsCell"];
    [self.appTableView registerClass:[MHPlaceVCell class] forCellReuseIdentifier:@"MHPlaceVCell"];
    [self.view addSubview:_appTableView];
    
//    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, 16+yy_y, _window_width, _window_height-NAVHEIGHT-14-16-yy_y)];
//    [self.view addSubview:self.noDataImgV];
//    self.noDataImgV.hidden = YES;
    
    self.topVVV = [[UIView alloc] initWithFrame:CGRectMake(0, 12, _window_width, yy_y+4)];
    self.topVVV.backgroundColor = RGB(1, 0, 2);
//    [self.view addSubview:self.topVVV];
    
    UIButton *cycycyMM = [[UIButton alloc] initWithFrame:CGRectMake(12, 0, _window_width-24, yy_y)];
    cycycyMM.clipsToBounds = YES;
    cycycyMM.layer.cornerRadius = 8;
    [cycycyMM setBackgroundImage:[UIImage imageNamed:@"squareRankImg"] forState:UIControlStateNormal];
    [cycycyMM addTarget:self action:@selector(clickRankingMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.topVVV addSubview:cycycyMM];
    
    if(self.typeN>0) {
        self.topVVV.frame = CGRectMake(12, 12, _window_width-24, yy_y+86);
//        self.appTableView.frame = CGRectMake(0, 16+yy_y+86, _window_width, _window_height-NAVHEIGHT-14-16-yy_y-86);
//        self.noDataImgV.frame = CGRectMake(0, 16+yy_y+86, _window_width, _window_height-NAVHEIGHT-14-16-yy_y-86);
        
        _appTableView.tableHeaderView = self.topVVV;
        
        CGFloat ff_two = (_window_width-24)/4;
        self.two_categoy = @"2";
        if(self.typeN == 1) {
            self.two_categoy = @"2";
            NSArray *imgAr = @[@"plaza_imgs1", @"plaza_imgs2", @"plaza_imgs3", @"plaza_imgs4"];
            NSArray *namAr = @[@"plaza_all3", @"plaza_all4", @"plaza_all5", @"plaza_all6"];
            
            for (int i=0; i<imgAr.count; i++) {
                UIView *fouMV = [[UIView alloc] initWithFrame:CGRectMake(ff_two*i, yy_y+10, ff_two, 56)];
                fouMV.backgroundColor = UIColor.clearColor;
                [self.topVVV addSubview:fouMV];
                
                UIImageView *imgTT = [[UIImageView alloc] initWithFrame:CGRectMake((ff_two-28)/2, 0, 28, 28)];
                imgTT.image = [UIImage imageNamed:imgAr[i]];
                [fouMV addSubview:imgTT];
                
                UILabel *nnMLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
                nnMLab.frame = CGRectMake(0, 38, ff_two, 16);
                nnMLab.text = eLocalizedString(namAr[i]);
                nnMLab.tag = 1400+i;
                [fouMV addSubview:nnMLab];
                if(i==1) {
                    nnMLab.textColor = normalColors;
                }
                UIButton *btnsMMM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ff_two, 52)];
                btnsMMM.tag = 1300+i;
                [btnsMMM addTarget:self action:@selector(btnsMMethod:) forControlEvents:UIControlEventTouchUpInside];
                [fouMV addSubview:btnsMMM];
            }
        }else {
            self.two_categoy = @"1";
            self.toys_arr = @[@"1", @"18", @"70", @"", @"", @"", @"0", @""];
         
            NSArray *imgAr = @[@"plaza_imgs5", @"plaza_imgs6", @"plaza_imgs7", @"plaza_imgs8"];
            NSArray *namAr = @[@"plaza_all11", @"plaza_all12", @"plaza_all13", @""];
            
            for (int i=0; i<imgAr.count; i++) {
                UIView *fouMV = [[UIView alloc] initWithFrame:CGRectMake(ff_two*i, yy_y+10, ff_two, 66)];
                fouMV.backgroundColor = UIColor.clearColor;
                [self.topVVV addSubview:fouMV];
                
                UIImageView *imgTT = [[UIImageView alloc] initWithFrame:CGRectMake((ff_two-28)/2, 0, 28, 28)];
                imgTT.image = [UIImage imageNamed:imgAr[i]];
                [fouMV addSubview:imgTT];
                
                UILabel *nnMLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
                nnMLab.frame = CGRectMake(0, 28, ff_two, 38);
                nnMLab.text = eLocalizedString(namAr[i]);
                nnMLab.tag = 1400+i;
                nnMLab.numberOfLines = 2;
                [fouMV addSubview:nnMLab];
                if(i==0) {
                    nnMLab.textColor = normalColors;
                }
                
                UIButton *btnsMMM = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ff_two, 52)];
                btnsMMM.tag = 1304+i;
                [btnsMMM addTarget:self action:@selector(btnsMMethod:) forControlEvents:UIControlEventTouchUpInside];
                [fouMV addSubview:btnsMMM];
                
                if(i==3) {
                    imgTT.frame = CGRectMake(ff_two-24, 0, 24, 24);
                    btnsMMM.frame = CGRectMake(ff_two-40, 0, 40, 40);
                }
            }
            
            [requestToolClass getNetworkWithUrl:request_square_listProduct andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                self.toys_arr2 = info;
            } fail:^(NSString * _Nonnull msg) {
                
            }];
        }
    }else {
        _appTableView.tableHeaderView = self.topVVV;
    }
    
    [self loadrefreshing];
    
    if(self.typeN<2) {
        UIButton *sureBBB = [HistoryRecordModel createImgBtn];
        sureBBB.frame = CGRectMake((_window_width-168)/2, _window_height-NAVHEIGHT-14-38-TARBARHEIGHT-62, 168, 42);
        [sureBBB setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
        [sureBBB setImage:[UIImage imageNamed:@"center_img13"] forState:UIControlStateNormal];
        [sureBBB setTitle:eLocalizedString(@"home_Publish") forState:UIControlStateNormal];
        [sureBBB setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        sureBBB.titleLabel.font = SYS_Font(14);
        [sureBBB addTarget:self action:@selector(publishBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:sureBBB];
    }
    
}

- (void)publishBtnMethod
{
    MHPostSquareController *vc = [[MHPostSquareController alloc] init];
    vc.delegate_ = self;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)postTopicContrDelegateMethod
{
    [SVProgressHUD showInfoWithStatus:eLocalizedString(@"find_push1")];
//    self.pageN = 1;
//    [self RequestListData];
}

- (void)clickRankingMethod
{
    MHSquareRankingController *vc = [[MHSquareRankingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnsMMethod:(UIButton *)btn
{
    if(btn.tag < 1304) {
        
        UILabel *nnMLab = [self.view viewWithTag:1400];
        UILabel *nnMLab2 = [self.view viewWithTag:1401];
        UILabel *nnMLab3 = [self.view viewWithTag:1402];
        UILabel *nnMLab4 = [self.view viewWithTag:1403];
        
        switch (btn.tag) {
            case 1300:
            {
                nnMLab.textColor = normalColors;
                nnMLab2.textColor = UIColor.whiteColor;
                nnMLab3.textColor = UIColor.whiteColor;
                nnMLab4.textColor = UIColor.whiteColor;
            }
                break;
            case 1301:
            {
                nnMLab2.textColor = normalColors;
                nnMLab.textColor = UIColor.whiteColor;
                nnMLab3.textColor = UIColor.whiteColor;
                nnMLab4.textColor = UIColor.whiteColor;
            }
                break;
            case 1302:
            {
                nnMLab3.textColor = normalColors;
                nnMLab2.textColor = UIColor.whiteColor;
                nnMLab.textColor = UIColor.whiteColor;
                nnMLab4.textColor = UIColor.whiteColor;
            }
                break;
            case 1303:
            {
                nnMLab4.textColor = normalColors;
                nnMLab2.textColor = UIColor.whiteColor;
                nnMLab3.textColor = UIColor.whiteColor;
                nnMLab.textColor = UIColor.whiteColor;
            }
                break;
                
            default:
                break;
        }
        
        self.two_categoy = [NSString stringWithFormat:@"%ld", btn.tag-1299];
        
        if(self.isRRRR) {
            return;
        }
        self.isRRRR = YES;
        [self.appTableView.mj_header beginRefreshing];
    }else {
        UILabel *nnMLab = [self.view viewWithTag:1400];
        UILabel *nnMLab2 = [self.view viewWithTag:1401];
        UILabel *nnMLab3 = [self.view viewWithTag:1402];
        
        switch (btn.tag) {
            case 1304:
            {
                nnMLab.textColor = normalColors;
                nnMLab2.textColor = UIColor.whiteColor;
                nnMLab3.textColor = UIColor.whiteColor;
                self.two_categoy = [NSString stringWithFormat:@"%ld", btn.tag-1303];
                
                if(self.isRRRR) {
                    return;
                }
                self.isRRRR = YES;
                [self.appTableView.mj_header beginRefreshing];
            }
                break;
            case 1305:
            {
                nnMLab2.textColor = normalColors;
                nnMLab.textColor = UIColor.whiteColor;
                nnMLab3.textColor = UIColor.whiteColor;
                self.two_categoy = [NSString stringWithFormat:@"%ld", btn.tag-1303];
                
                if(self.isRRRR) {
                    return;
                }
                self.isRRRR = YES;
                [self.appTableView.mj_header beginRefreshing];
            }
                break;
            case 1306:
            {
                nnMLab3.textColor = normalColors;
                nnMLab2.textColor = UIColor.whiteColor;
                nnMLab.textColor = UIColor.whiteColor;
                self.two_categoy = [NSString stringWithFormat:@"%ld", btn.tag-1303];
                
                if(self.isRRRR) {
                    return;
                }
                self.isRRRR = YES;
                [self.appTableView.mj_header beginRefreshing];
            }
                break;
            case 1307:
            {
                MHfindChooseView *vc = [[MHfindChooseView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                vc.arrFind = self.toys_arr;
                vc.arrFind2 = self.toys_arr2;
                [self.tabBarController.view addSubview:vc];
                vc.block_ = ^(NSArray * _Nonnull arrList) {
                  
                    self.toys_arr = arrList;
                    if(self.isRRRR) {
                        return;
                    }
                    self.isRRRR = YES;
                    [self.appTableView.mj_header beginRefreshing];
                };
                [vc addUIUIU];
            }
                break;
                
            default:
                break;
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
    NSDictionary *dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10"};
    NSString *url_url = request_square_pageFollowUpActivity;
    if(self.typeN == 1) {
        url_url = request_square_pageRecommendedActivity;
        dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"category":self.two_categoy};
    }
    if(self.typeN == 2) {
        url_url = request_square_pageToysActivity;
        if([minStr(self.toys_arr[1]) intValue] <= 18 && [minStr(self.toys_arr[2]) intValue] >= 70) {
            dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"category":self.two_categoy, @"status":self.toys_arr[0], @"ageRangeStart":@"0", @"ageRangeEnd":@"0", @"gender":self.toys_arr[3], @"genderPreference":self.toys_arr[4], @"rolePreference":self.toys_arr[5], @"locationId":self.toys_arr[6], @"productId":self.toys_arr[7]};
        }else {
            dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"category":self.two_categoy, @"status":self.toys_arr[0], @"ageRangeStart":self.toys_arr[1], @"ageRangeEnd":self.toys_arr[2], @"gender":self.toys_arr[3], @"genderPreference":self.toys_arr[4], @"rolePreference":self.toys_arr[5], @"locationId":self.toys_arr[6], @"productId":self.toys_arr[7]};
        }
    }
    
    [requestToolClass postNetworkWithUrl:url_url andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            
            if(self.pageN == 1) {
                [self.datasMut removeAllObjects];
            }
            NSArray *listAr = info[@"records"];
            for (NSDictionary *dicM in listAr) {
                MHfindSubPatternsModel *model = [MHfindSubPatternsModel mj_objectWithKeyValues:dicM];
                [self.datasMut addObject:model];
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
        self.isRRRR = NO;
    } fail:^(NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
        self.isRRRR = NO;
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
        MHfindSubPatternsCell *cell = [MHfindSubPatternsCell cellWithTabelView:tableView];
        if(self.typeN == 2) {
            [cell addDataToMeDic:self.datasMut[indexPath.row] row:indexPath typMethod:1];
        }else {
            [cell addDataToDic:self.datasMut[indexPath.row] row:indexPath];
        }
        cell.delegate_ = self;
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHfindDetailController *vc = [[MHfindDetailController alloc] init];
    vc.modelM = self.datasMut[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)focusOrGoodOrComment:(NSInteger)typeN indexPath:(NSIndexPath *)indexPath
{
    MHfindSubPatternsModel *model = self.datasMut[indexPath.row];
    
    if(typeN == 2) {
        if(![model.uid isEqualToString:[LYUserDefault userDefault].t_id]) {
            [requestToolClass postNetworkWithUrl:request_square_likeOrDislike andParameter:@{@"activityId":model.activityId} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                model.isLikes = !model.isLikes;
                if(model.isLikes) {
                    model.likeCount = model.likeCount+1;
                }else {
                    if(model.likeCount>0) {
                        model.likeCount = model.likeCount-1;
                    }
                }
                [self.appTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            } fail:^(NSString * _Nonnull msg) {
                
            }];
        }
    }else if (typeN == 3) {
        MHfindDetailController *vc = [[MHfindDetailController alloc] init];
        vc.modelM = self.datasMut[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        if(model.isFollowed) {
            
            [[FloatingWindowModel shareInstance] switchChatDetailControlNick:model.nickName hostId:model.uid];
        }else {
            NSString *urlMM = [NSString stringWithFormat:@"%@?followingId=%@", request_user_followOrUnfollow, model.uid];
            [requestToolClass getNetworkWithUrl:urlMM andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                
                model.isFollowed = !model.isFollowed;
                [self.appTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            } fail:^(NSString * _Nonnull msg) {
                
            }];
        }
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

@end
