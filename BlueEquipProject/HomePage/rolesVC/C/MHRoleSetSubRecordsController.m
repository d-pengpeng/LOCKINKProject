//
//  MHRoleSetSubRecordsController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/18.
//

#import "MHRoleSetSubRecordsController.h"
#import "MHRoleRecordmmCell.h"
#import "MHfindSubPatternsModel.h"
#import "MWPhotoBrowser.h"
#import "MHSquareRankingController.h"
#import "MHfindDetailController.h"
#import "MHfindChooseView.h"

@interface MHRoleSetSubRecordsController ()<UITableViewDelegate, UITableViewDataSource, MHRoleRecordmmCellDelaget, MWPhotoBrowserDelegate>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@property (nonatomic, assign) int pageN;

@property (nonatomic, strong) NSMutableArray *photos;
@end

@implementation MHRoleSetSubRecordsController

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
    self.redNavView = YES;
    self.titleName.text = eLocalizedString(@"role_name36");
    self.titleName.textColor = UIColor.blackColor;
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    [self.view addSubview:self.navView];
    
    self.photos = [NSMutableArray array];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    _appTableView.dragInteractionEnabled = YES;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHRoleRecordmmCell class] forCellReuseIdentifier:@"MHRoleRecordmmCell"];
    [self.view addSubview:_appTableView];
    
    self.noDataImgV = [[noDataImgView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT)];
    [self.view addSubview:self.noDataImgV];
    self.noDataImgV.hidden = YES;
    
    [self loadrefreshing];
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
    NSDictionary *dicMM = @{@"page":minIntStr(self.pageN), @"size":@"10", @"deviceId":self.devicId};
    [requestToolClass postNetworkWithUrl:request_voteRecord_pageVoteRecord andParameter:dicMM success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSDictionary class]]) {
            
            if(self.pageN == 1) {
                [self.datasMut removeAllObjects];
            }
            NSArray *listAr = info[@"records"];
            for (NSDictionary *dicM in listAr) {
                MHfindSubPatternsModel *model = [MHfindSubPatternsModel mj_objectWithKeyValues:dicM];
                model.type = @"VOTE";
                model.participantCount = [minStr(dicM[@"voterCount"]) intValue];
                NSMutableArray *ar_mut = [NSMutableArray array];
                NSArray *voter_ar = dicM[@"voterProfileList"];
                for (int i=0; i<voter_ar.count; i++) {
                    if([voter_ar[i] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *dicm = voter_ar[i];
                        [ar_mut addObject:minStr(dicm[@"profile"])];
                    }else {
                        [ar_mut addObject:minStr(voter_ar[i])];
                    }
                }
               
                model.participantProfileList = ar_mut;
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
    } fail:^(NSString * _Nonnull msg) {
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasMut.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHRoleRecordmmCell *cell = [MHRoleRecordmmCell cellWithTabelView:tableView];
    [cell addDataToMeDic:self.datasMut[indexPath.row] row:indexPath typMethod:1];
    cell.delegate_ = self;
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHfindDetailController *vc = [[MHfindDetailController alloc] init];
    vc.modelM = self.datasMut[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)focusOrGoodOrComment:(NSInteger)typeN indexPath:(NSIndexPath *)indexPath
{
//    request_square_likeOrDislike
    if(typeN == 2) {
        
        
    }else if (typeN == 3) {
        MHfindDetailController *vc = [[MHfindDetailController alloc] init];
        vc.modelM = self.datasMut[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
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
