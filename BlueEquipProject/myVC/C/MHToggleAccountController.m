//
//  MHToggleAccountController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/5.
//

#import "MHToggleAccountController.h"
#import "MHToggleAccountCell.h"
#import "MHToggleAccountModel.h"
#import "MHToggleAccountAddCell.h"

@interface MHToggleAccountController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) NSMutableArray *datasMut;

@end

@implementation MHToggleAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleName.text = eLocalizedString(@"my_settings9");
    self.navView.backgroundColor = RGB(247, 247, 247);
    
    UIImageView *placeImV = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height)];
    placeImV.image = [UIImage imageNamed:@"allBackImgsMsg"];
    [self.view addSubview:placeImV];
    
    self.datasMut = [NSMutableArray array];
    _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) style:UITableViewStylePlain];
    _appTableView.delegate = self;
    _appTableView.dataSource = self;
    _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _appTableView.rowHeight = UITableViewAutomaticDimension;
    _appTableView.estimatedRowHeight = 10;
    _appTableView.backgroundColor = UIColor.clearColor;
    self.appTableView.sectionHeaderTopPadding = 0;
    [self.appTableView registerClass:[MHToggleAccountCell class] forCellReuseIdentifier:@"MHToggleAccountCell"];
    [self.appTableView registerClass:[MHToggleAccountAddCell class] forCellReuseIdentifier:@"MHToggleAccountAddCell"];
    [self.view addSubview:_appTableView];
    
//    NSArray *lisAAr = [HistoryRecordModel requestAccountAllDataPlist];
    
    [self uploadRequest];
}

- (void)uploadRequest
{
    [requestToolClass getNetworkWithUrl:request_config_listAccountLink andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        if([info isKindOfClass:[NSArray class]]) {
            
            [HistoryRecordModel deletAccountAllListPlist];
            
            NSMutableArray *arMut = [NSMutableArray array];
            for (NSDictionary *dcMMM in info) {
                MHToggleAccountModel *model = [MHToggleAccountModel mj_objectWithKeyValues:dcMMM];
                if([[LYUserDefault userDefault].t_id isEqualToString:minStr(model.uid)]) {
                    model.isShhh = YES;
                }
                NSDictionary *dcMM = @{@"recordId":minStr(dcMMM[@"recordId"]), @"uid":minStr(dcMMM[@"uid"])};
                [arMut addObject:dcMM];
                [self.datasMut addObject:model];
            }
            
            [HistoryRecordModel addNewAccountDataPlist:arMut];
        }
        [self.appTableView reloadData];
    } fail:^(NSString * _Nonnull msg) {
        
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
        
        MHToggleAccountAddCell *cell = [MHToggleAccountAddCell cellWithTabelView:tableView];
        if(self.datasMut.count >2) {
            cell.nickLab.textColor = RGB(217, 217, 217);
            cell.headImgV.image = [UIImage imageNamed:@"addAccount_selImg"];
        }else {
            cell.nickLab.textColor = UIColor.blackColor;
            cell.headImgV.image = [UIImage imageNamed:@"addAccount_NorImg"];
        }
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MHToggleAccountCell *cell = [MHToggleAccountCell cellWithTabelView:tableView];
        [cell addDataToDic:self.datasMut[indexPath.row]];
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        
        if(self.datasMut.count < 3) {
            if(self.datasMut.count > 0) {
                [LYUserDefault saveIsSealing:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFF" object:nil];
        }
    }else {
        MHToggleAccountModel *model = self.datasMut[indexPath.row];
        if(!model.isShhh) {
            [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"my_about21") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
                if (index == 1) {

                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutImNotifFFTwo" object:nil];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[NSUserDefaults standardUserDefaults] setValue:model.token forKey:@"AppToken"];
                        [[NSUserDefaults standardUserDefaults] setValue:minStr(model.uid) forKey:@"user_id"];
                        [[NSUserDefaults standardUserDefaults] setValue:model.nickName forKey:@"user_nickname"];
                        [[NSUserDefaults standardUserDefaults] setValue:model.profile forKey:@"user_avatar"];
                        
                        [LYUserDefault saveUIimUserSig:@""];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotifMethod" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginImNotifFF" object:nil];
                    });
                    
                }
            }];
        }
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        MHToggleAccountModel *model = self.datasMut[indexPath.row];
        if([minStr(model.recordId) intValue] == 0) {
            return NO;
        }else {
            return YES;
        }
    }else {
        return NO;
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:eLocalizedString(@"home_delete") handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [SGActionView showAlertWithTitle:nil message:eLocalizedString(@"homeMsg_delete") leftButtonTitle:eLocalizedString(@"home_Cancel") rightButtonTitle:eLocalizedString(@"home_Sure") selectedHandle:^(NSInteger index) {
            if (index == 1) {
                MHToggleAccountModel *model = self.datasMut[indexPath.row];
                if([minStr(model.recordId) intValue] == 0) {
                
                }else {
                    [requestToolClass getNetworkWithUrl:request_config_deleteLink andParameter:@{@"recordId":minStr(model.recordId)} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
                        
                        [self.datasMut removeObjectAtIndex:indexPath.row];
                        [self.appTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                    } fail:^(NSString * _Nonnull msg) {
                        
                    }];
                }
            }
        }];
        NSLog(@"点击了删除");
    }];
    action0.backgroundColor = UIColor.redColor;
    
//    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"关注" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        NSLog(@"点击了关注");
//      // 收回左滑出现的按钮(退出编辑模式)
//        tableView.editing = NO;
//    }];
//    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//
//        NSLog(@"点击了编辑");
//
//        tableView.editing = NO;
//    }];
    return @[action0];
}

@end
