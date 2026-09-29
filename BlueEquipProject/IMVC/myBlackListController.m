//
//  myBlackListController.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/30.
//

#import "myBlackListController.h"
#import "TUIBlackListController.h"
#import "ReactiveObjC.h"
#import "TUIDefine.h"

#define kContactCellReuseId @"ContactCellReuseId"
@interface myBlackListController ()<V2TIMFriendshipListener, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) TUIBlackListController *contactVC;
@property (nonatomic, strong) UITableView *tableView;

@property TUIBlackListViewDataProvider *viewModel;
@end

@implementation myBlackListController

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

    self.titleName.text = eLocalizedString(@"message_tile5");
    
    self.redNavView = YES;
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    [self.view addSubview:self.navView];
    
    [self.backBnt setImage:[UIImage imageNamed:@"e下拉"] forState:0];
    self.titleName.textColor = UIColor.blackColor;
    
    
//    self.contactVC = [[TUIBlackListController alloc] init];
//    self.contactVC.delegate_ = self;
//    [self addChildViewController:self.contactVC];
//    self.contactVC.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
//    [self.view addSubview:self.contactVC.view];
//    self.contactVC.view.frame = CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT);
//    [self.contactVC uploadUIUIUIUIMehtod];
//    self.contactVC.didSelectCellBlock = ^(TUICommonContactCell * _Nonnull cell) {
//
//        if(self.black_) {
//            self.black_(cell);
//        }
//    };
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0);
    [self.tableView setSectionIndexColor:[UIColor whiteColor]];
    [self.tableView setBackgroundColor:UIColor.clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.sectionHeaderTopPadding = 0;
    [self.tableView registerClass:[TUICommonContactCell class] forCellReuseIdentifier:@"FriendCell"];
    [self.view addSubview:_tableView];
    
    if (!self.viewModel) {
        self.viewModel = TUIBlackListViewDataProvider.new;
        @weakify(self)
        [RACObserve(self.viewModel, isLoadFinished) subscribeNext:^(id finished) {
            @strongify(self)
            if ([(NSNumber *)finished boolValue])
                [self.tableView reloadData];
        }];
        [self.viewModel loadBlackList];
    }
    
    [[V2TIMManager sharedInstance] addFriendListener:self];
}

#pragma mark - V2TIMFriendshipListener
- (void)onBlackListAdded:(NSArray<V2TIMFriendInfo *>*)infoList {
    [self.viewModel loadBlackList];
}

- (void)onBlackListDeleted:(NSArray*)userIDList {
    [self.viewModel loadBlackList];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.blackListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TUICommonContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    TUICommonContactCellData *data = self.viewModel.blackListData[indexPath.row];
    data.cselector = @selector(didSelectBlackList:);
    [cell fillWithData:data];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.clearColor;
    cell.contentView.backgroundColor = UIColor.clearColor;
    cell.selected = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

-(void)didSelectBlackList:(TUICommonContactCell *)cell
{
    if(self.black_) {
        self.black_(cell);
    }
}

@end
