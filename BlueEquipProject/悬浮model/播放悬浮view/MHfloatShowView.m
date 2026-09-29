//
//  MHfloatShowView.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/10/30.
//

#import "MHfloatShowView.h"
#import "MHLibraryModel.h"
#import "musicWindowModel.h"

@interface MHfloatShowView ()
{
    NSTimer *timeLL;
}
@property (nonatomic, strong) UIImageView *headImgV;
@property (nonatomic, strong) UILabel *namLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIButton *playBB;

@property (nonatomic, assign) BOOL isMMusicPlay;
@property (nonatomic, assign) BOOL isPlayB;
@property (nonatomic, assign) int adNum;
@property (nonatomic, assign) int adNum2;
@property (nonatomic, assign) int al_second;
@property (nonatomic, assign) NSInteger backRow;
@property (nonatomic, strong) NSArray *oneArr;
@property (nonatomic, strong) NSArray *twoArr;
@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) FloatingWindowModel *floatMode;
@property (nonatomic, strong) musicWindowModel *playerModel;

@property (nonatomic, copy) NSString *oneCy;
@property (nonatomic, copy) NSString *twoCy;
@property (nonatomic, assign) CGFloat fneCy;
@end
@implementation MHfloatShowView

- (instancetype)initWithFrame:(CGRect)frame isMusicPlay:(BOOL)boo
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.playerModel = [musicWindowModel shareInstance];
        self.floatMode = [FloatingWindowModel shareInstance];
        
        self.isMMusicPlay = YES;
        self.pArrList = self.floatMode.musicList;
        self.pRowL = self.floatMode.musRow;
        self.playTNum = self.floatMode.timeL;
        self.spedR = 2;
        
        UIButton *ddBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        ddBBB.backgroundColor = RGBA(255, 255, 255, 0.6);
        [ddBBB addTarget:self action:@selector(ddBBMethods) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ddBBB];
        
        _oneVV = [HistoryRecordModel createViewUIUI];
        _oneVV.frame = CGRectMake(_window_width-164-6, _window_height/3, 164, 82);
        _oneVV.backgroundColor = RGB(128, 90, 151);
        [self addSubview:_oneVV];
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.image = app_placeAA1_img;
        self.headImgV.layer.cornerRadius = 14;
        [_oneVV addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_oneVV.mas_left).offset(8);
            make.top.equalTo(_oneVV.mas_top).offset(8);
            make.width.height.offset(28);
        }];
     
        self.namLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.namLab.text = eLocalizedString(@"home_mode28");
        [_oneVV addSubview:self.namLab];
        [self.namLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(6);
            make.top.equalTo(self.headImgV.mas_top);
        }];
        
        self.timeLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:10 textAlignment:NSTextAlignmentLeft];
        self.timeLab.text = @"00:00";
        [_oneVV addSubview:self.timeLab];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(6);
            make.bottom.equalTo(self.headImgV.mas_bottom);
        }];
        
        UIButton *clicMMMMM = [[UIButton alloc] init];
        [clicMMMMM addTarget:self action:@selector(clickMMMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:clicMMMMM];
        [clicMMMMM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_oneVV);
            make.width.height.offset(44);
            
        }];
        
        UIView *linV = [HistoryRecordModel createLineViewUIUI];
        [_oneVV addSubview:linV];
        [linV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_oneVV);
            make.top.equalTo(self.headImgV.mas_bottom).offset(8);
            make.height.offset(1);
        }];
        
        self.playBB = [HistoryRecordModel createImgBtn];
        [self.playBB setBackgroundImage:[UIImage imageNamed:@"float_all3"] forState:UIControlStateNormal];
        [self.playBB setBackgroundImage:[UIImage imageNamed:@"float_all3_3"] forState:UIControlStateSelected];
        [self.playBB addTarget:self action:@selector(playBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:self.playBB];
        [self.playBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(linV.mas_bottom).offset(6);
            make.centerX.equalTo(_oneVV.mas_centerX);
            make.width.height.offset(23);
        }];
        self.playBB.selected = self.floatMode.isMusicPlay;
        self.isPlayB = NO;
        
        UIButton *lefBBB = [HistoryRecordModel createImgBtn];
        [lefBBB setImage:[UIImage imageNamed:@"float_all2"] forState:UIControlStateNormal];
        [lefBBB addTarget:self action:@selector(lefBBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:lefBBB];
        [lefBBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.playBB.mas_left).offset(-10);
            make.centerY.equalTo(self.playBB.mas_centerY);
            make.width.height.offset(23);
        }];
        
        UIButton *rigBBB = [HistoryRecordModel createImgBtn];
        [rigBBB setImage:[UIImage imageNamed:@"float_all4"] forState:UIControlStateNormal];
        [rigBBB addTarget:self action:@selector(rigBBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:rigBBB];
        [rigBBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playBB.mas_right).offset(10);
            make.centerY.equalTo(self.playBB.mas_centerY);
            make.width.height.offset(23);
        }];
        
        
        UIButton *ddddeteBBB = [HistoryRecordModel createImgBtn];
        [ddddeteBBB setImage:[UIImage imageNamed:@"float_allDelete"] forState:UIControlStateNormal];
        [ddddeteBBB addTarget:self action:@selector(ddBBMethodsTwo) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:ddddeteBBB];
        [ddddeteBBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(_oneVV);
            make.width.height.offset(20);
        }];
        
        
        self.adNum = self.playTNum>0 ? self.playTNum:0;
        self.adNum2 = self.playTNum>0 ? self.playTNum:0;
        self.backRow = 10000;
        
        if(self.floatMode.musicList.count>self.pRowL) {
            
            NSMutableArray *musicUrl = [NSMutableArray array];
            NSMutableArray *musicName = [NSMutableArray array];
            for (int i=0; i<self.floatMode.musicList.count; i++) {
                MHLibraryModel *model = self.floatMode.musicList[i];
                [musicUrl addObject:model.musicUrl];
                [musicName addObject:model.nameL];
            }
            self.pRowL = self.floatMode.musRow;
            self.playerModel.numLLL = (int)self.pRowL;
            self.playerModel.musicListAr = musicUrl;
            self.playerModel.nameListAr = musicName;
            self.playerModel.playTime = self.floatMode.timeL/10;
            self.isPlayB = NO;
            if([self.playerModel getPlayVice]) {
                
                MHLibraryModel *model = self.floatMode.musicList[self.pRowL];
                self.namLab.text = model.nameL;
                self.adNum = self.playTNum;
                self.al_second = model.timeLL*10;
                self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:(model.timeLL*10-self.playTNum)/10];
                self.isPlayB = YES;
                self.playBB.selected = YES;
                self.floatMode.isMusicPlay = YES;
            }else {
                [self.playerModel newStartPlayNoVoiceMP3];
                self.playerModel.finishBlock_ = ^(NSString * _Nonnull filePath) {
                    MHLibraryModel *model = self.floatMode.musicList[self.pRowL];
                    self.adNum = self.playTNum;
                    self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:(model.timeLL*10-self.playTNum)/10];
                    self.isPlayB = NO;
                    self.playBB.selected = NO;
                    self.floatMode.isMusicPlay = NO;
                };
                MHLibraryModel *model = self.floatMode.musicList[self.pRowL];
                self.namLab.text = model.nameL;
                self.adNum = self.playTNum;
                self.al_second = model.timeLL*10;
                self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:(model.timeLL*10-self.playTNum)/10];
                self.isPlayB = YES;
                self.playBB.selected = YES;
                self.floatMode.isMusicPlay = YES;
            }
        }
        
        timeLL = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeMethodUI) userInfo:nil repeats:YES];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame ArrLis:(NSArray *)arlist rowL:(NSInteger)rowN playT:(int)playTT sped:(NSInteger)spedN
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.isMMusicPlay = NO;
        self.pArrList = arlist;
        self.pRowL = rowN;
        self.playTNum = playTT;
        self.spedR = spedN;
        
        self.oneCy = @"0";
        self.twoCy = @"0";
        
        UIButton *ddBBB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        ddBBB.backgroundColor = RGBA(255, 255, 255, 0.6);
        [ddBBB addTarget:self action:@selector(ddBBMethods) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ddBBB];
        
        _oneVV = [HistoryRecordModel createViewUIUI];
        _oneVV.frame = CGRectMake(_window_width-164-6, _window_height/3, 164, 82);
        _oneVV.backgroundColor = RGB(128, 90, 151);
        [self addSubview:_oneVV];
        
        self.headImgV = [HistoryRecordModel createImgImgView];
        self.headImgV.image = app_placeAA1_img;
        self.headImgV.layer.cornerRadius = 14;
        [_oneVV addSubview:self.headImgV];
        [self.headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_oneVV.mas_left).offset(8);
            make.top.equalTo(_oneVV.mas_top).offset(8);
            make.width.height.offset(28);
        }];
     
        self.namLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.namLab.text = eLocalizedString(@"home_mode28");
        [_oneVV addSubview:self.namLab];
        [self.namLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(6);
            make.top.equalTo(self.headImgV.mas_top);
        }];
        
        self.timeLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:10 textAlignment:NSTextAlignmentLeft];
        self.timeLab.text = @"00:00";
        [_oneVV addSubview:self.timeLab];
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgV.mas_right).offset(6);
            make.bottom.equalTo(self.headImgV.mas_bottom);
        }];
        
        UIButton *clicMMMMM = [[UIButton alloc] init];
        [clicMMMMM addTarget:self action:@selector(clickMMMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:clicMMMMM];
        [clicMMMMM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_oneVV);
            make.width.height.offset(44);
            
        }];
        
        UIView *linV = [HistoryRecordModel createLineViewUIUI];
        [_oneVV addSubview:linV];
        [linV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_oneVV);
            make.top.equalTo(self.headImgV.mas_bottom).offset(8);
            make.height.offset(1);
        }];
        
        self.playBB = [HistoryRecordModel createImgBtn];
        [self.playBB setBackgroundImage:[UIImage imageNamed:@"float_all3"] forState:UIControlStateNormal];
        [self.playBB setBackgroundImage:[UIImage imageNamed:@"float_all3_3"] forState:UIControlStateSelected];
        [self.playBB addTarget:self action:@selector(playBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:self.playBB];
        [self.playBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(linV.mas_bottom).offset(6);
            make.centerX.equalTo(_oneVV.mas_centerX);
            make.width.height.offset(23);
        }];
        self.playBB.selected = [LYUserDefault userDefault].play_start;
        self.isPlayB = [LYUserDefault userDefault].play_start;
        
        UIButton *lefBBB = [HistoryRecordModel createImgBtn];
        [lefBBB setImage:[UIImage imageNamed:@"float_all2"] forState:UIControlStateNormal];
        [lefBBB addTarget:self action:@selector(lefBBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:lefBBB];
        [lefBBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.playBB.mas_left).offset(-10);
            make.centerY.equalTo(self.playBB.mas_centerY);
            make.width.height.offset(23);
        }];
        
        UIButton *rigBBB = [HistoryRecordModel createImgBtn];
        [rigBBB setImage:[UIImage imageNamed:@"float_all4"] forState:UIControlStateNormal];
        [rigBBB addTarget:self action:@selector(rigBBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:rigBBB];
        [rigBBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playBB.mas_right).offset(10);
            make.centerY.equalTo(self.playBB.mas_centerY);
            make.width.height.offset(23);
        }];
        
        
        UIButton *ddddeteBBB = [HistoryRecordModel createImgBtn];
        [ddddeteBBB setImage:[UIImage imageNamed:@"float_allDelete"] forState:UIControlStateNormal];
        [ddddeteBBB addTarget:self action:@selector(ddBBMethodsTwo) forControlEvents:UIControlEventTouchUpInside];
        [_oneVV addSubview:ddddeteBBB];
        [ddddeteBBB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(_oneVV);
            make.width.height.offset(20);
        }];
        
        
        self.adNum = self.playTNum>0 ? self.playTNum:0;
        self.adNum2 = self.playTNum>0 ? self.playTNum:0;
        self.backRow = 10000;
        
        if(self.pArrList.count>self.pRowL) {
            NSString *ff_str = self.pArrList[self.pRowL];
            NSArray *thrAr = [ff_str componentsSeparatedByString:@"-&-"];
            if(thrAr.count==8) {
                self.oneArr = [minStr(thrAr[6]) componentsSeparatedByString:@","];
                self.twoArr = [minStr(thrAr[7]) componentsSeparatedByString:@","];
                self.namLab.text = minStr(thrAr[1]);
                int MMM = self.oneArr.count>self.twoArr.count ? (int)(self.twoArr.count):(int)(self.oneArr.count);
                self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:(MMM-self.playTNum)/10];
            }
        }else {
            self.pRowL = 0;
            NSString *ff_str = self.pArrList[0];
            NSArray *thrAr = [ff_str componentsSeparatedByString:@"-&-"];
            if(thrAr.count==8) {
                self.oneArr = [minStr(thrAr[6]) componentsSeparatedByString:@","];
                self.twoArr = [minStr(thrAr[7]) componentsSeparatedByString:@","];
                self.namLab.text = minStr(thrAr[1]);
                int MMM = self.oneArr.count>self.twoArr.count ? (int)(self.twoArr.count):(int)(self.oneArr.count);
                self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:(MMM-self.playTNum)/10];
            }
        }
        
        float wwH = 0.1;
        switch (self.spedR) {
            case 0:
            {
                wwH = 0.03;
            }
                break;
            case 1:
            {
                wwH = 0.06;
            }
                break;
            case 2:
            {
                wwH = 0.1;
            }
                break;
            case 3:
            {
                wwH = 0.2;
            }
                break;
            case 4:
            {
                wwH = 0.4;
            }
                break;
                
            default:
                break;
        }
        timeLL = [NSTimer scheduledTimerWithTimeInterval:wwH target:self selector:@selector(timeMethodUI) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)uploadYyy:(CGFloat)yYY LeftRig:(BOOL)isLef
{
    self.playBB.selected = [LYUserDefault userDefault].play_start;
    self.isPlayB = [LYUserDefault userDefault].play_start;
    if(isLef) {
        _oneVV.frame = CGRectMake(_window_width-164-6, yYY-41, 164, 82);
    }else {
        _oneVV.frame = CGRectMake(6, yYY-41, 164, 82);
    }
}

- (void)clickMMMethod
{
    if(self.isMMusicPlay) {

        self.floatMode.musRow = self.pRowL;
        self.floatMode.timeL = self.adNum;
        
//        UIViewController *selVC = [[FloatingWindowModel shareInstance] getCurrentViewController];
//        MHMusicController *vc = [[MHMusicController alloc] init];
//        [selVC.navigationController pushViewController:vc animated:YES];
        
        [timeLL invalidate];
        timeLL = nil;
        
        if(self.block_) {
            self.block_(1, NO);
        }
        [self removeFromSuperview];
    }else {
//        UIViewController *selVC = [[FloatingWindowModel shareInstance] getCurrentViewController];
//        MHModePlayController *vc = [[MHModePlayController alloc] init];
//        vc.arrList = self.pArrList;
//        vc.rowL = self.pRowL;
//        vc.isMode = self.isPlayLis;
//        vc.id_id = self.id_id;
//        vc.playTime = self.adNum;
//        vc.modalPresentationStyle = UIModalPresentationFullScreen;
//        [selVC presentViewController:vc animated:YES completion:nil];
    }
}

- (void)playBtnMethod
{
    self.playBB.selected = !self.playBB.selected;
    [LYUserDefault savePlayStart:self.playBB.selected];
    
    self.isPlayB = !self.isPlayB;
    self.floatMode.isMusicPlay = self.isPlayB;
    
    if(self.isMMusicPlay) {
        if(self.isPlayB) {
            [self.playerModel playPlayMethod];
        }else {
            [self.playerModel pausePlay];
            
        }
    }
    
    if(self.block_) {
        self.block_(2, self.playBB.selected);
    }
    if(!self.isPlayB) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"0", @"strong":@"0", @"strong2":@"0"}];
        });
    }
}

- (void)lefBBtnMethod
{
    if(self.backRow<10000) {
        if(self.isMMusicPlay) {
            if(self.floatMode.musicList.count>self.backRow) {
                
//                MHLibraryModel *model = self.floatMode.musicList[self.backRow];
                self.playerModel.numLLL = (int)self.backRow;
                self.playerModel.playTime = 0;
                self.isPlayB = NO;
                [self.playerModel newStartPlayNoVoiceMP3];
                self.playerModel.finishBlock_ = ^(NSString * _Nonnull filePath) {
                    MHLibraryModel *model = self.floatMode.musicList[self.backRow];
                    self.namLab.text = model.nameL;
                    self.adNum = 0;
                    self.al_second = model.timeLL*10;
                    self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:model.timeLL*10/10];
                    self.isPlayB = YES;
                };
            }
        }else {
            if(self.pArrList.count>self.backRow) {
                NSString *ff_str = self.pArrList[self.backRow];
                NSArray *thrAr = [ff_str componentsSeparatedByString:@"-&-"];
                if(thrAr.count>4) {
                    self.oneArr = [minStr(thrAr[6]) componentsSeparatedByString:@","];
                    self.twoArr = [minStr(thrAr[7]) componentsSeparatedByString:@","];
                    self.namLab.text = minStr(thrAr[1]);
                    int MMM = self.oneArr.count>self.twoArr.count ? (int)(self.twoArr.count):(int)(self.oneArr.count);
                    self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:MMM/10];
                    //                self.timeLab.text = @"00:00";
                    self.adNum = 0;
                    self.adNum2 = 0;
                    self.isPlayB = YES;
                }
            }
        }
    }
}

- (void)rigBBtnMethod
{
    if(self.isMMusicPlay) {
        self.backRow = self.pRowL;
        if([LYUserDefault userDefault].play_type == 0) {
            self.pRowL = rand()%self.floatMode.musicList.count;
        }else if([LYUserDefault userDefault].play_type == 1) {
            if(self.pArrList.count>self.pRowL+1) {
                self.pRowL = self.pRowL+1;
            }else {
                self.pRowL = 0;
            }
        }
        if(self.floatMode.musicList.count>self.pRowL) {
            
            MHLibraryModel *model = self.floatMode.musicList[self.pRowL];
            self.playerModel.numLLL = (int)self.pRowL;
            self.playerModel.playTime = 0;
            self.isPlayB = NO;
            [self.playerModel newStartPlayNoVoiceMP3];
            self.playerModel.finishBlock_ = ^(NSString * _Nonnull filePath) {
                self.namLab.text = model.nameL;
                self.adNum = 0;
                self.al_second = model.timeLL*10;
                self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:model.timeLL*10/10];
                self.isPlayB = YES;
            };
        }
    }else {
        self.backRow = self.pRowL;
        if([LYUserDefault userDefault].play_type == 0) {
            self.pRowL = rand()%self.pArrList.count;
        }else if([LYUserDefault userDefault].play_type == 1) {
            if(self.pArrList.count>self.pRowL+1) {
                self.pRowL = self.pRowL+1;
            }else {
                self.pRowL = 0;
            }
        }
        self.isPlayB = NO;
        if(self.pArrList.count>self.pRowL) {
            NSString *ff_str = self.pArrList[self.pRowL];
            NSArray *thrAr = [ff_str componentsSeparatedByString:@"-&-"];
            if(thrAr.count>5) {
                self.oneArr = [minStr(thrAr[6]) componentsSeparatedByString:@","];
                self.twoArr = [minStr(thrAr[7]) componentsSeparatedByString:@","];
                self.namLab.text = minStr(thrAr[1]);
                int MMM = self.oneArr.count>self.twoArr.count ? (int)(self.twoArr.count):(int)(self.oneArr.count);
                self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:MMM/10];
                //            self.timeLab.text = @"00:00";
                self.adNum = 0;
                self.adNum2 = 0;
                self.isPlayB = YES;
            }
        }
    }
}

- (void)timeMethodUI
{
    if(self.isPlayB) {
       
        if(self.isMMusicPlay) {
            
            if(self.al_second > self.adNum) {
                self.adNum = self.adNum+1;
                self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:(self.al_second-self.adNum)/10];
            }else {
                self.backRow = self.pRowL;
                if([LYUserDefault userDefault].play_type == 0) {
                    self.pRowL = rand()%self.floatMode.musicList.count;
                }else if([LYUserDefault userDefault].play_type == 1) {
                    if(self.pArrList.count>self.pRowL+1) {
                        self.pRowL = self.pRowL+1;
                    }else {
                        self.pRowL = 0;
                    }
                }
                if(self.floatMode.musicList.count>self.pRowL) {
                    
                    MHLibraryModel *model = self.floatMode.musicList[self.pRowL];
                    self.playerModel.numLLL = (int)self.pRowL;
                    self.playerModel.playTime = 0;
                    self.isPlayB = NO;
                    [self.playerModel newStartPlayNoVoiceMP3];
                    self.playerModel.finishBlock_ = ^(NSString * _Nonnull filePath) {
                        
                        self.namLab.text = model.nameL;
                        self.adNum = 0;
                        self.al_second = model.timeLL*10;
                        self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:model.timeLL*10/10];
                        self.isPlayB = YES;
                    };
                }
            }
            
            CGFloat nn_ff = [self.playerModel getpeakPowerForChannelMM];
//            NSLog(@"--音乐起伏--%.2f", nn_ff);
            if(fabs(self.fneCy-nn_ff) > 0.10) {
                self.fneCy = nn_ff;
                [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"0", @"strong":[NSString stringWithFormat:@"%.f", self.fneCy*100], @"strong2":[NSString stringWithFormat:@"%.f", self.fneCy*100]}];
            }
        }else {
            
            if((self.oneArr.count > self.adNum2)&&(self.twoArr.count > self.adNum2)) {
                
                if((abs([self.oneCy intValue] - [minStr(self.oneArr[self.adNum]) intValue]) > pattNum) || (abs([self.twoCy intValue] - [minStr(self.twoArr[self.adNum]) intValue]) > pattNum)) {
                    self.oneCy = minStr(self.oneArr[self.adNum]);
                    self.twoCy = minStr(self.twoArr[self.adNum]);
                    [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"0", @"strong":self.oneCy, @"strong2":self.twoCy}];
                }
                
                self.adNum2 = self.adNum2+1;
                self.adNum = self.adNum+1;
                int MMM = self.oneArr.count>self.twoArr.count ? (int)(self.twoArr.count):(int)(self.oneArr.count);
                if(MMM > self.adNum) {
                    self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:(MMM-self.adNum)/10];
                }else {
                    self.timeLab.text = @"00:00";
                }
                
            }else {
                self.backRow = self.pRowL;
                if([LYUserDefault userDefault].play_type == 0) {
                    self.pRowL = rand()%self.pArrList.count;
                }else if([LYUserDefault userDefault].play_type == 1) {
                    if(self.pArrList.count>self.pRowL+1) {
                        self.pRowL = self.pRowL+1;
                    }else {
                        self.pRowL = 0;
                    }
                }
                self.isPlayB = NO;
                if(self.pArrList.count>self.pRowL) {
                    NSString *ff_str = self.pArrList[self.pRowL];
                    NSArray *thrAr = [ff_str componentsSeparatedByString:@"-&-"];
                    if(thrAr.count>5) {
                        self.oneArr = [minStr(thrAr[6]) componentsSeparatedByString:@","];
                        self.twoArr = [minStr(thrAr[7]) componentsSeparatedByString:@","];
                        self.namLab.text = minStr(thrAr[1]);
                        int MMM = self.oneArr.count>self.twoArr.count ? (int)(self.twoArr.count):(int)(self.oneArr.count);
                        self.timeLab.text = [HistoryRecordModel secondToHourMinutesSecond:MMM/10];
                        //                    self.timeLab.text = @"00:00";
                        self.adNum = 0;
                        self.adNum2 = 0;
                        self.isPlayB = YES;
                        
                    }
                }
            }
        }
    }
}

//MARK: 音乐删除
- (void)ddBBMethodsTwo
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:app_sendCustomNotifName object:nil userInfo:@{@"motor":@"0", @"strong":@"0", @"strong2":@"0"}];
    });
    [LYUserDefault savePlayStart:NO];
    if(self.isMMusicPlay) {
        self.floatMode.musRow = self.pRowL;
        self.floatMode.timeL = self.adNum;
        self.floatMode.isMusicPlay = NO;
        [self.playerModel stopPlayNoVoiceMP3];
    }
    [timeLL invalidate];
    timeLL = nil;
    
    if(self.block_) {
        self.block_(1, NO);
    }
    [self removeFromSuperview];
}

- (void)ddBBMethodsTwoMMMMM
{
    [LYUserDefault savePlayStart:NO];
    
    [timeLL invalidate];
    timeLL = nil;
    
    [self removeFromSuperview];
}

- (void)ddBBMethodsThrBoo:(BOOL)isBBB
{
    if(self.isMMusicPlay) {
        self.floatMode.musRow = self.pRowL;
        self.floatMode.timeL = self.adNum;
        if(isBBB) {
            
        }else {
            self.floatMode.isMusicPlay = NO;
            [self.playerModel stopPlayNoVoiceMP3];
        }
    }
    [LYUserDefault savePlayStart:NO];
    
    [timeLL invalidate];
    timeLL = nil;
    [self removeFromSuperview];
}


- (void)ddBBMethods
{
    if(self.block_) {
        self.block_(3, YES);
    }
}


@end
