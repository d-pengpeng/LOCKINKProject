//
//  MHDetailEquipmentController.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/13.
//

#import "MHDetailEquipmentController.h"
#import "MHMeEquipmentModel.h"
@interface MHDetailEquipmentController ()

@end

@implementation MHDetailEquipmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backIMgV = [HistoryRecordModel createImgImgView];
    backIMgV.frame = CGRectMake(0, 0, _window_width, _window_height);
    backIMgV.image = [UIImage imageNamed:@"backNormalImg"];
    [self.view addSubview:backIMgV];
   
    [self.view addSubview:self.navView];
    
    UIView *linVV = [HistoryRecordModel createLineViewUIUI];
    linVV.frame = CGRectMake(0, self.navView.height-1, _window_width, 1);
    linVV.backgroundColor = GrayTextColor;
    [self.navView addSubview:linVV];
    
    self.redNavView = YES;
    
    MHMeEquipmentModel *model = [MHMeEquipmentModel mj_objectWithKeyValues:self.dicM];
    self.titleName.text = model.name;
    
    [self addHeadImgUIUIUrl:model type:YES];
    [self addHeadImgUIUIUrl:model type:NO];
    
    
}

- (void)addHeadImgUIUIUrl:(MHMeEquipmentModel *)model type:(BOOL)isLefBoo
{
    UIImageView *headImgVV = [HistoryRecordModel createImgImgView];
    if(isLefBoo) {
        headImgVV.frame = CGRectMake((_window_width/2-81), NAVHEIGHT+23, 68, 68);
    }else {
        headImgVV.frame = CGRectMake((_window_width/2+13), NAVHEIGHT+23, 68, 68);
    }
    headImgVV.layer.cornerRadius = 34;
    [self.view addSubview:headImgVV];
    
    UIImageView *imgPlacV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 68, 68)];
    imgPlacV.image = [UIImage imageNamed:@"rankingBackImg4"];
    [headImgVV addSubview:imgPlacV];
    
    UIImageView *imgPlacV1 = [[UIImageView alloc] init];
    if(isLefBoo) {
        [headImgVV sd_setImageWithURL:[NSURL URLWithString:model.masterProfile] placeholderImage:normal_placeHeadImg];
        imgPlacV1.image = [UIImage imageNamed:@"device_leftImg"];
    }else {
        [headImgVV sd_setImageWithURL:[NSURL URLWithString:model.servantProfile] placeholderImage:normal_placeHeadImg];
        imgPlacV1.image = [UIImage imageNamed:@"device_leftImg2"];
    }
    [self.view addSubview:imgPlacV1];
    [imgPlacV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImgVV.mas_bottom).offset(10);
        make.centerX.equalTo(headImgVV.mas_centerX);
        make.width.height.offset(18);
    }];
    
    
    UIView *lefVVV1 = [HistoryRecordModel createViewUIUI];
    lefVVV1.layer.cornerRadius = 4;
    lefVVV1.backgroundColor = RGB(89, 26, 115);
    [self.view addSubview:lefVVV1];
    
    UIView *lefVVV2 = [HistoryRecordModel createViewUIUI];
    lefVVV2.layer.cornerRadius = 4;
    lefVVV2.backgroundColor = RGB(89, 26, 115);
    [self.view addSubview:lefVVV2];
    
    UIView *lefVVV3 = [HistoryRecordModel createViewUIUI];
    lefVVV3.layer.cornerRadius = 4;
    lefVVV3.backgroundColor = RGB(89, 26, 115);
    [self.view addSubview:lefVVV3];
    
    if(isLefBoo) {
        [lefVVV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImgVV.mas_top).offset(-3);
            make.right.equalTo(headImgVV.mas_left).offset(-20);
            make.height.offset(22);
            make.width.offset(54);
        }];
        
        UILabel *subXXLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        subXXLab.text = minIntStr(model.masterAge);
        [lefVVV1 addSubview:subXXLab];
        [subXXLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(lefVVV1);
//            make.right.equalTo(lefVVV1.mas_right).offset(0);
//            make.top.bottom.equalTo(lefVVV1);
//            make.width.offset(33);
        }];
        
//        UIImageView *sexIIIMM = [HistoryRecordModel createImgImgView];
//        sexIIIMM.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@SexImg", model.masterGender]]; // masterGender = MTF;
//        [lefVVV1 addSubview:sexIIIMM];
//        [sexIIIMM mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(lefVVV1.mas_left).offset(8);
//            make.centerY.equalTo(lefVVV1.mas_centerY);
//            make.width.height.offset(12);
//        }];
        
        [lefVVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lefVVV1.mas_bottom).offset(4);
            make.right.equalTo(headImgVV.mas_left).offset(-20);
            make.height.offset(22);
            make.width.mas_greaterThanOrEqualTo(54);
        }];
        
        UILabel *subXXLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        subXXLab2.text = minStr(model.masterRolePreference);
        [lefVVV2 addSubview:subXXLab2];
        [subXXLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(lefVVV2);
        }];
        
        [lefVVV3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lefVVV2.mas_bottom).offset(4);
            make.right.equalTo(headImgVV.mas_left).offset(-20);
            make.height.offset(22);
            make.width.mas_greaterThanOrEqualTo(54);
        }];
        
        UILabel *subXXLab3 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        subXXLab3.text = minStr(model.masterGenderPreference);
        [lefVVV3 addSubview:subXXLab3];
        [subXXLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(lefVVV3);
        }];
    }else {
        [lefVVV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImgVV.mas_top).offset(-3);
            make.left.equalTo(headImgVV.mas_right).offset(20);
            make.height.offset(22);
            make.width.offset(54);
        }];
        
        UILabel *subXXLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        subXXLab.text = minIntStr(model.servantAge);
        [lefVVV1 addSubview:subXXLab];
        [subXXLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(lefVVV1);
//            make.left.equalTo(lefVVV1.mas_left).offset(0);
//            make.top.bottom.equalTo(lefVVV1);
//            make.width.offset(33);
        }];
        
//        UIImageView *sexIIIMM = [HistoryRecordModel createImgImgView];
//        sexIIIMM.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@SexImg", model.servantGender]]; //servantGender = FTM;
//        [lefVVV1 addSubview:sexIIIMM];
//        [sexIIIMM mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(lefVVV1.mas_right).offset(-8);
//            make.centerY.equalTo(lefVVV1.mas_centerY);
//            make.width.height.offset(12);
//        }];
        
        [lefVVV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lefVVV1.mas_bottom).offset(4);
            make.left.equalTo(headImgVV.mas_right).offset(20);
            make.height.offset(22);
            make.width.mas_greaterThanOrEqualTo(54);
        }];
        
        UILabel *subXXLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        subXXLab2.text = minStr(model.servantRolePreference);
        [lefVVV2 addSubview:subXXLab2];
        [subXXLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(lefVVV2);
        }];
        
        [lefVVV3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lefVVV2.mas_bottom).offset(4);
            make.left.equalTo(headImgVV.mas_right).offset(20);
            make.height.offset(22);
            make.width.mas_greaterThanOrEqualTo(54);
        }];
        
        UILabel *subXXLab3 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentCenter];
        subXXLab3.text = minStr(model.servantGenderPreference);
        [lefVVV3 addSubview:subXXLab3];
        [subXXLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(lefVVV3);
        }];
    }
    
}



@end
