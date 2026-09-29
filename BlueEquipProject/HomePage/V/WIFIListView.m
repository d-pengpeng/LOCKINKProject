//
//  WIFIListView.m
//  MachineGlory
//
//  Created by Edwin on 2021/8/21.
//  Copyright © 2021 time. All rights reserved.
//

#import "WIFIListView.h"
#import "WIFIListViewCell.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface WIFIListView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic,strong) NSArray *datasMut;
@property (nonatomic,strong) NSArray *readMut;
@property (nonatomic,strong) NSArray *choseMut;
@property (nonatomic,strong) NSArray *macsssMut;
@end
@implementation WIFIListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *botmVV = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        botmVV.backgroundColor = RGBA(0, 0, 0, 0.3);
        [botmVV addTarget:self action:@selector(deleteBBBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:botmVV];
        
        UIView *ccontVVV = [[UIView alloc] initWithFrame:CGRectMake((_window_width-280)/2, (_window_height-285)/2, 280, 285)];
        ccontVVV.backgroundColor = UIColor.clearColor;
        ccontVVV.layer.cornerRadius = 12;
        ccontVVV.clipsToBounds = YES;
        [self addSubview:ccontVVV];
        
        UIImageView *imgV = [HistoryRecordModel createImgImgView];
        imgV.frame = CGRectMake(0, 0, 280, 285);
        imgV.image = [UIImage imageNamed:@"toysAllImg3"];
        [ccontVVV addSubview:imgV];
        
        
        _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,50, ccontVVV.width, ccontVVV.height-90) style:UITableViewStylePlain];
        _appTableView.delegate = self;
        _appTableView.dataSource = self;
        _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _appTableView.rowHeight = UITableViewAutomaticDimension;
        _appTableView.estimatedRowHeight = 70;
        _appTableView.backgroundColor = UIColor.clearColor;
        self.appTableView.sectionHeaderTopPadding = 0;
        [self.appTableView registerClass:[WIFIListViewCell class] forCellReuseIdentifier:@"WIFIListViewCell"];
        [ccontVVV addSubview:_appTableView];
        
        UILabel *oneLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 40, ccontVVV.width-24, 21)];
        oneLab.text = eLocalizedString(@"home_bluetooth1");
        oneLab.textColor = UIColor.clearColor;
        oneLab.font = SYS_Font(15);
        [ccontVVV addSubview:oneLab];
        
        
    }
    return self;
}

- (void)isBBLEBooMehtodBoo:(BOOL)isBBLEBoo
{
    UILabel *twolll = [self viewWithTag:48888];
    if (isBBLEBoo) {
        twolll.text = eLocalizedString(@"home_bluetooth2");
    }else {
        twolll.text = eLocalizedString(@"home_bluetooth3");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.choseMut.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WIFIListViewCell *cell = [WIFIListViewCell cellWithTabelView:tableView];
    cell.readNNam = self.readMut[indexPath.row];
    [cell addModelToDataModel:self.choseMut[indexPath.row] choseName:self.datasMut[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.block_) {
        self.block_(indexPath.row, self.datasMut[indexPath.row]);
    }
}

- (void)addDataList:(NSArray *)arr choseArr:(nonnull NSArray *)chosArr rowN:(NSArray *)rowN
{
    NSMutableArray *namsDD = [NSMutableArray array];
    NSMutableArray *namsDDRead = [NSMutableArray array];
    NSMutableArray *namsDD2 = [NSMutableArray array];
    NSMutableArray *namsDD3 = [NSMutableArray array];
    NSMutableArray *namsDD3_3 = [NSMutableArray array];
    NSMutableArray *namsDD4 = [NSMutableArray array];
    NSMutableArray *namsDD5 = [NSMutableArray array];
    for (NSDictionary *dic in rowN) {
        [namsDD2 addObject:dic[@"mac"]];
        [namsDD3 addObject:dic[@"name"]];
        [namsDD3_3 addObject:dic[@"realName"]];
    }
    for (int i=0; i<chosArr.count; i++) {
        NSString *macL = chosArr[i];
        if([namsDD2 containsObject:macL]) {
            for (int j=0; j<namsDD2.count; j++) {
                if([minStr(namsDD2[j]) isEqualToString:macL]) {
                    [namsDD addObject:minStr(namsDD3[j])];
                    [namsDDRead addObject:minStr(namsDD3_3[j])];
                    if([LYUserDefault userDefault].macName.length > 0) {
                        if([minStr(namsDD2[j]) isEqualToString:[LYUserDefault userDefault].macName]) {
                            [namsDD4 addObject:@"2"];
                        }else {
                            [namsDD4 addObject:@"0"];
                        }
                    }else {
                        [namsDD4 addObject:@"0"];
                    }
                    [namsDD5 addObject:macL];
                }
            }
        }else {
            if(arr.count > i) {
                if([LYUserDefault userDefault].macName.length > 0) {
                    if([macL isEqualToString:[LYUserDefault userDefault].macName]) {
                        [namsDD4 addObject:@"2"];
                    }else {
                        [namsDD4 addObject:@"0"];
                    }
                }else {
                    [namsDD4 addObject:@"1"];
                }
                CBPeripheral *peripheral = arr[i];
                [namsDD addObject:minStr(peripheral.name)];
                [namsDDRead addObject:minStr(peripheral.name)];
                [namsDD5 addObject:macL];
            }
        }
    }
    self.choseMut = namsDD;
    self.datasMut = namsDD4;
    self.macsssMut = namsDD5;
    self.readMut = namsDDRead;
    [self.appTableView reloadData];
}

- (void)deleteBBBtnMethod
{
    if (self.block_) {
        self.block_(10000, @"1");
    }
}

@end
