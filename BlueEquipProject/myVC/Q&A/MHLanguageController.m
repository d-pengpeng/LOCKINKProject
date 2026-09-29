//
//  MHLanguageController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import "MHLanguageController.h"
#import "MHLanguageCell.h"
#import "MHLanguageModel.h"

@interface MHLanguageController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;

@end

@implementation MHLanguageController
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
    self.titleName.text = eLocalizedString(@"my_settings7");
    self.navView.backgroundColor = RGB(247, 247, 247);
     
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    UIButton *rightBnt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBnt2.frame = CGRectMake(_window_width-15.5-60, TIMESTATUSHEIGHT, 60, 40);
    rightBnt2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    rightBnt2.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBnt2 setTitle:eLocalizedString(@"home_ok") forState:0];
    [rightBnt2 setTitleColor:normalColors forState:0];
    [rightBnt2 addTarget:self action:@selector(saveMethodM) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:rightBnt2];
     
    self.datasMut = [NSMutableArray array];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHLanguageCell class] forCellReuseIdentifier:@"MHLanguageCell"];
    [self.view addSubview:_appTableView];
    
    NSArray *arlIs = @[@{@"name":eLocalizedString(@"language_zh"), @"idN":@"zh-Hans"}, @{@"name":eLocalizedString(@"language_en"), @"idN":@"en"}];
    
    NSString *lang_st = [[SwichLanguage shareInstance] userLanguage];
    for (NSDictionary *dcidic in arlIs) {
        MHLanguageModel *model = [MHLanguageModel mj_objectWithKeyValues:dcidic];
        if ([lang_st hasPrefix:@"zh"]) {
            if ([model.idN hasPrefix:@"zh"]) {
                model.isShow = YES;
            }
        }else {
            if([model.idN isEqualToString:@"en"]) {
                model.isShow = YES;
            }
        }
        [self.datasMut addObject:model];
    }
    [self.appTableView reloadData];
}

- (void)saveMethodM
{
    NSString *smm = @"";
    for (MHLanguageModel *model in self.datasMut) {
        if(model.isShow) {
            smm = model.idN;
        }
    }
    if(smm.length > 0) {
        [[SwichLanguage shareInstance] setUserlanguage:smm];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"languageChagneMethodNotif" object:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasMut.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHLanguageCell *cell = [MHLanguageCell cellWithTabelView:tableView];
    [cell addModelData:self.datasMut[indexPath.row]];
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i=0; i<self.datasMut.count; i++) {
        MHLanguageModel *model = self.datasMut[i];
        if(i==indexPath.row) {
            model.isShow = YES;
        }else {
            model.isShow = NO;
        }
    }
    [self.appTableView reloadData];
}

@end
