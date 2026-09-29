//
//  Q_AListController.m
//  DragonTeethLive
//
//  东莞梦幻网络科技有限公司 注 on 2021/10/12.
//

#import "Q_AListController.h"
#import "Q_AOneCell.h"
#import "Q_AOneModel.h"

@interface Q_AListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;
@property (nonatomic, strong) noDataImgView *noDataImgV;
@end

@implementation Q_AListController
- (void)viewWillAppear:(BOOL)animated {
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
    self.hideNavView = YES;

    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    self.datasMut = [NSMutableArray array];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-NAVHEIGHT-50) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[Q_AOneCell class] forCellReuseIdentifier:@"Q_AOneCell"];
    [self.view addSubview:_appTableView];
    
    for (NSDictionary *dic in self.arrLList) {
        Q_AOneModel *model = [Q_AOneModel addModelFromDictionary:dic];
        [self.datasMut addObject:model];
    }
    [self.appTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datasMut.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Q_AOneCell *cell = [Q_AOneCell cellWithTabelView:tableView];
    [cell addModelData:self.datasMut[indexPath.section]];
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        Q_AOneModel *model = self.datasMut[indexPath.section];
        model.isShow = !model.isShow;
        [self.appTableView reloadData];
    }
}

@end
