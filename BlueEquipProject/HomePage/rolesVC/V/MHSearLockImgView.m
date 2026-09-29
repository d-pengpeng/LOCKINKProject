//
//  MHSearLockImgView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/9.
//

#import "MHSearLockImgView.h"
#import "MHSearLockImgCell.h"

@interface MHSearLockImgView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSArray *arList;
@property (nonatomic, strong) UILabel *placLab;
@property (nonatomic, assign) CLLocationCoordinate2D coorNew;
@end
@implementation MHSearLockImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        UIImageView *imgLCC = [[UIImageView alloc] init];
        imgLCC.image = [UIImage imageNamed:@"searLock_img"];
        [self addSubview:imgLCC];
        [imgLCC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        
        _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(8,6, self.width-16, 62) style:UITableViewStylePlain];
        _appTableView.delegate = self;
        _appTableView.dataSource = self;
        _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _appTableView.rowHeight = UITableViewAutomaticDimension;
        _appTableView.estimatedRowHeight = 70;
        _appTableView.clipsToBounds = YES;
        _appTableView.layer.cornerRadius = 8;
        _appTableView.backgroundColor = UIColor.clearColor;
        self.appTableView.sectionHeaderTopPadding = 0;
        [self.appTableView registerClass:[MHSearLockImgCell class] forCellReuseIdentifier:@"MHSearLockImgCell"];
        [self addSubview:_appTableView];
        [self.appTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(8);
            make.top.equalTo(self.mas_top).offset(6);
            make.right.equalTo(self.mas_right).offset(-8);
            make.bottom.equalTo(self.mas_bottom).offset(-6);
//            make.height.offset(62);
        }];
        
        self.placLab = [HistoryRecordModel createLabLabTextColor:GrayText fontFloat:15 textAlignment:NSTextAlignmentCenter];
        self.placLab.text = eLocalizedString(@"noData_msg1");
        [self addSubview:self.placLab];
        [self.placLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self);
        }];
        self.placLab.hidden = YES;
    }
    return self;
}

- (void)addListArr:(NSArray *)arr coor:(CLLocationCoordinate2D)coor
{
    self.coorNew = coor;
    if(arr.count > 3) {
        self.placLab.hidden = YES;
//        [self.appTableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.offset(62*3);
//        }];
        self.arList = arr;
        [self.appTableView reloadData];
    }else {
        
        if(arr.count > 0) {
            self.placLab.hidden = YES;
//            [self.appTableView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.offset(62*arr.count);
//            }];
            self.arList = arr;
            [self.appTableView reloadData];
        }else {
            
//            [self.appTableView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.offset(62);
//            }];
            self.arList = @[];
            [self.appTableView reloadData];
            self.placLab.hidden = NO;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHSearLockImgCell *cell = [MHSearLockImgCell cellWithTabelView:tableView];
    if(self.isAppleMapBoo) {
        [cell addTwoModelToDataModel:self.arList[indexPath.row] coor:self.coorNew];
    }else {
//        [cell addModelToDataModel:self.arList[indexPath.row] coor:self.coorNew];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = UIColor.whiteColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.block_) {
        self.block_(indexPath.row);
    }
}

@end
