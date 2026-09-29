//
//  MHFourthRoleJDBXController.m
//  BlueEquipProject
//
//  Created by Edwin on 2025/10/29.
//

#import "MHFourthRoleJDBXController.h"
#import "MHRoleThrSDMSView.h"

@interface MHFourthRoleJDBXController ()
@property (nonatomic, strong) UIView *oneVV;
@property (nonatomic, strong) UIScrollView *scrollVVV;
@property (nonatomic, strong) UILabel *strong_Lab;
@property (nonatomic, assign) int strongType;

//@property (nonatomic, assign) int strongTypeB;
//@property (nonatomic, strong) UILabel *channlelef_Lab;
//@property (nonatomic, strong) UILabel *channlerig_Lab;
//@property (nonatomic, strong) UIImageView *channlelef_Img;
//@property (nonatomic, strong) UIImageView *channlerig_Img;
@property (nonatomic, strong) NSMutableArray *chose_mutAr;
//@property (nonatomic, strong) NSMutableArray *chose_mutArB;

@property (nonatomic, assign) BOOL isSuijiBoo;
@property (nonatomic, assign) int jiShiType; //计时
@property (nonatomic, assign) BOOL jiShiBoo;
@property (nonatomic, assign) int play_modelType;//播放model

//@property (nonatomic, assign) BOOL isSuijiBooB;
//@property (nonatomic, assign) int jiShiTypeB; //计时
//@property (nonatomic, assign) BOOL jiShiBooB;
//@property (nonatomic, assign) int play_modelTypeB;//播放model

@property (nonatomic, assign) int jiShiSecond; //计时秒数
@property (nonatomic, assign) int jiShiSecond_sub;
@property (nonatomic, assign) BOOL isContinuBoo;
//@property (nonatomic, assign) BOOL isChannelBoo; //yes B通道,  no A通道
@property (nonatomic, assign) BOOL isChannelBooW;
@end

@implementation MHFourthRoleJDBXController

- (NSMutableArray *)chose_mutAr
{
    if (!_chose_mutAr) {
        _chose_mutAr = [NSMutableArray array];
    }
    return _chose_mutAr;
}

//- (NSMutableArray *)chose_mutArB
//{
//    if (!_chose_mutArB) {
//        _chose_mutArB = [NSMutableArray array];
//    }
//    return _chose_mutArB;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavView = YES;
    
    self.jiShiSecond = 5;
    self.jiShiSecond_sub = 5;
    self.jiShiType = 1;
//    self.jiShiTypeB = 1;
    _oneVV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height-334)];
    _oneVV.layer.cornerRadius = 0;
    _oneVV.clipsToBounds = YES;
    _oneVV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:_oneVV];
    
    self.scrollVVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _window_width, self.oneVV.height)];
    self.scrollVVV.showsVerticalScrollIndicator = NO;
    self.scrollVVV.showsHorizontalScrollIndicator = NO;
    self.scrollVVV.bounces = NO;
    self.scrollVVV.backgroundColor = UIColor.clearColor;
    [self.oneVV addSubview:self.scrollVVV];
    
    UIImageView *oneImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 472)];
    oneImgV.image = [UIImage imageNamed:@"fourth_backSub_Img"];
    [self.scrollVVV addSubview:oneImgV];
    
    self.scrollVVV.contentSize = CGSizeMake(_window_width, oneImgV.height+34);
    
//    if ([self.devicTyp isEqualToString:kCharactName13]) {
        
        UIImageView *tit_lab2 = [HistoryRecordModel createImgImgView];
        tit_lab2.frame = CGRectMake(16, 28, _window_width-32, 36);
        tit_lab2.image = [UIImage imageNamed:@"fourth_strongBack_Img"];
        [self.scrollVVV addSubview:tit_lab2];
        
        UIButton *lefNumBtn2 = [HistoryRecordModel createImgBtn];
        lefNumBtn2.frame = CGRectMake(0, tit_lab2.y-10, 76, 56);
        lefNumBtn2.tag = 1002;
        [lefNumBtn2 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollVVV addSubview:lefNumBtn2];
        UIImageView *lef_subIII_2 = [HistoryRecordModel createImgImgView];
        lef_subIII_2.frame = CGRectMake(29, 19, 18, 18);
        lef_subIII_2.image = [UIImage imageNamed:@"fourth_strongSub_Img"];
        [lefNumBtn2 addSubview:lef_subIII_2];
        
        UIButton *rigNumBtn2 = [HistoryRecordModel createImgBtn];
        rigNumBtn2.frame = CGRectMake(_window_width-56-20, tit_lab2.y-10, 76, 56);
        rigNumBtn2.tag = 1003;
        [rigNumBtn2 addTarget:self action:@selector(btnAllBtnMethodTag:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollVVV addSubview:rigNumBtn2];
        UIImageView *rig_subIII_2 = [HistoryRecordModel createImgImgView];
    rig_subIII_2.frame = CGRectMake(29, 19, 18, 18); //CGRectMake(9, 9, 18, 18);
        rig_subIII_2.image = [UIImage imageNamed:@"fourth_strongAdd_Img"];
        [rigNumBtn2 addSubview:rig_subIII_2];
        
        UIImageView *numberImg1 = [HistoryRecordModel createImgImgView];
        numberImg1.frame = CGRectMake(tit_lab2.center.x-57, 12, 114, 68);
        numberImg1.image = [UIImage imageNamed:@"fourth_strongCent_Img"];
        [self.scrollVVV addSubview:numberImg1];
        self.strong_Lab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:40 textAlignment:NSTextAlignmentCenter];
        self.strong_Lab.frame = CGRectMake(0, 0, 114, 68);
        self.strong_Lab.text = @"50";
        [numberImg1 addSubview:self.strong_Lab];
        self.strongType = 50;
//        self.strongTypeB = 50;
        
        CGFloat fiv_msgff = (_window_width-48*5-16*5)/2;
        UIView *sub_oneVV2 = [[UIView alloc] initWithFrame:CGRectMake(fiv_msgff, CGRectGetMaxY(numberImg1.frame)+24, _window_width-fiv_msgff*2, 88*2)];
        sub_oneVV2.backgroundColor = UIColor.clearColor;
        [self.scrollVVV addSubview:sub_oneVV2];
        
        CGFloat one_fivFF = 48+16;
        for (int i=0; i<10; i++) {
            UIButton *ten_BBtn = [HistoryRecordModel createImgBtn];
            if (i>4) {
                ten_BBtn.frame = CGRectMake((i-5)*one_fivFF, 88, one_fivFF, 88);
            }else {
                ten_BBtn.frame = CGRectMake(i*one_fivFF, 0, one_fivFF, 88);
            }
            ten_BBtn.tag = 2300+i;
            [ten_BBtn addTarget:self action:@selector(tenBtnMethodUIUIUIUTag:) forControlEvents:UIControlEventTouchUpInside];
            [sub_oneVV2 addSubview:ten_BBtn];
            
            UIImageView *teImgVV = [HistoryRecordModel createImgImgView];
            teImgVV.frame = CGRectMake(8, 0, 48, 48);
            teImgVV.image = [UIImage imageNamed:[NSString stringWithFormat:@"fourth_model%d_Img", i+1]];
            [ten_BBtn addSubview:teImgVV];
            
            UIImageView *teImgVV2 = [HistoryRecordModel createImgImgView];
            teImgVV2.frame = CGRectMake(8, 0, 48, 48);
            teImgVV2.image = [UIImage imageNamed:@"fourth_modelSel_Img"];
            teImgVV2.tag = 2400+i;
            [ten_BBtn addSubview:teImgVV2];
            teImgVV2.hidden = YES;
            
            NSString *nam_sttt = [NSString stringWithFormat:@"fourthModel2_nams%d", i+1];
            UILabel *nam_LLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
//            nam_LLab.tag = 2500+i;
            nam_LLab.numberOfLines = 3;
            nam_LLab.text = eLocalizedString(nam_sttt);
            [ten_BBtn addSubview:nam_LLab];
            [nam_LLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ten_BBtn.mas_left).offset(3);
                make.top.equalTo(ten_BBtn.mas_top).offset(48);
                make.right.equalTo(ten_BBtn.mas_right).offset(-3);
                make.height.mas_greaterThanOrEqualTo(34);
            }];
        }
        
        //MARK: 列表、定时、随机
        NSArray *imgsA = @[@"fourth_listbook_Img", @"fourth_timingNor_Img", @"fourth_random_Img"];
        NSArray *imgsA_sel = @[@"fourth_listbook_Img", @"fourth_timingSel_Img", @"fourth_randomSel_Img"];
        NSArray *tagsA = @[@"0", @"1", @"2"];
        
        CGFloat thr_topyy = sub_oneVV2.y+sub_oneVV2.height+76 + 20;
        for (int i=0; i<imgsA.count; i++) {
            
            switch (i) {
                case 0:
                {
                    UIButton *selBBtn = [HistoryRecordModel createImgBtn];
                    [selBBtn setBackgroundImage:[UIImage imageNamed:imgsA[i]] forState:UIControlStateNormal];
                    [selBBtn setBackgroundImage:[UIImage imageNamed:imgsA_sel[i]] forState:UIControlStateSelected];
                    selBBtn.tag = 2600+[minStr(tagsA[i]) intValue];
                    [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                    [self.scrollVVV addSubview:selBBtn];
                    selBBtn.frame = CGRectMake(36, thr_topyy, 48, 48);
                }
                    break;
                case 1:
                {
                    UIImageView *backImgV = [HistoryRecordModel createImgImgView];
                    backImgV.frame = CGRectMake((_window_width-108)/2, thr_topyy, 108, 48);
                    backImgV.image = [UIImage imageNamed:imgsA[i]];
                    [self.scrollVVV addSubview:backImgV];
                    
                    UIButton *selBBtn = [HistoryRecordModel createImgBtn];
                    [selBBtn setBackgroundImage:[UIImage imageNamed:@"fourth_timing1_Img"] forState:UIControlStateNormal];
                    selBBtn.tag = 2600+[minStr(tagsA[i]) intValue];
                    [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                    [self.scrollVVV addSubview:selBBtn];
                    selBBtn.frame = CGRectMake((_window_width-108)/2+16, thr_topyy+8, 40, 32);
                    
                    UIButton *playBBtn = [HistoryRecordModel createImgBtn];
                    [playBBtn setImage:[UIImage imageNamed:@"fourth_playNor_Img"] forState:UIControlStateNormal];
                    [playBBtn setImage:[UIImage imageNamed:@"fourth_playSel_Img"] forState:UIControlStateSelected];
                    playBBtn.tag = 2700+[minStr(tagsA[i]) intValue];
                    [playBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                    [self.scrollVVV addSubview:playBBtn];
                    playBBtn.frame = CGRectMake((_window_width-108)/2+56, thr_topyy+6, 36, 36);
                    
                }
                    break;
                case 2:
                {
                    UIButton *selBBtn = [HistoryRecordModel createImgBtn];
                    [selBBtn setBackgroundImage:[UIImage imageNamed:imgsA[i]] forState:UIControlStateNormal];
                    [selBBtn setBackgroundImage:[UIImage imageNamed:imgsA_sel[i]] forState:UIControlStateSelected];
                    selBBtn.tag = 2600+[minStr(tagsA[i]) intValue];
                    [selBBtn addTarget:self action:@selector(selBBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
                    [self.scrollVVV addSubview:selBBtn];
                    selBBtn.frame = CGRectMake(_window_width-36-48, thr_topyy, 48, 48);
                }
                    break;
                    
                default:
                    break;
            }
            
        }
       
//        CGFloat ww_widchan = (_window_width-36-40)/2;
//        NSArray *channel_arr = @[@"fourth_channel_A", @"fourth_channel_B"];
//        for (int i=0; i<channel_arr.count; i++) {
//            
//            UIImageView *channel_imgV1 = [HistoryRecordModel createImgImgView];
//            channel_imgV1.image = [UIImage imageNamed:@"fourth_channel_Img"];
//            [self.scrollVVV addSubview:channel_imgV1];
//            if (i==0) {
//                channel_imgV1.frame = CGRectMake(18, thr_topyy+48+18, ww_widchan, 36);
//            }else {
//                channel_imgV1.frame = CGRectMake(18+ww_widchan+40, thr_topyy+48+18, ww_widchan, 36);
//            }
//            
//            UIButton *channelBtn = [HistoryRecordModel createImgBtn];
//            channelBtn.tag = 3300+i;
//            [channelBtn addTarget:self action:@selector(channelBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
//            [self.scrollVVV addSubview:channelBtn];
//            
//            UIButton *channelBtn2 = [HistoryRecordModel createImgBtn];
//            channelBtn2.tag = 3400+i;
//            [channelBtn2 addTarget:self action:@selector(channelBtnMethodPlay:) forControlEvents:UIControlEventTouchUpInside];
//            [self.scrollVVV addSubview:channelBtn2];
//            
//            if (i==0) {
//                channelBtn.frame = CGRectMake(18, thr_topyy+48+18, ww_widchan-58, 36);
//                channelBtn2.frame = CGRectMake(18+ww_widchan-58, thr_topyy+48+18, 58, 36);
//                
//                self.channlelef_Lab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:13 textAlignment:NSTextAlignmentLeft];
//                self.channlelef_Lab.frame = CGRectMake(14, 0, channelBtn.width-14, 36);
//                self.channlelef_Lab.text = eLocalizedString(channel_arr[0]);
//                [channelBtn addSubview:self.channlelef_Lab];
//                
//                self.channlelef_Img = [HistoryRecordModel createImgImgView];
//                self.channlelef_Img.frame = CGRectMake(20, 9, 18, 18);
//                self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//                [channelBtn2 addSubview:self.channlelef_Img];
//                
//            }else {
//                channelBtn.frame = CGRectMake(18+ww_widchan+40, thr_topyy+48+18, ww_widchan-58, 36);
//                channelBtn2.frame = CGRectMake(channel_imgV1.x+ww_widchan-58, thr_topyy+48+18, 58, 36);
//                
//                self.channlerig_Lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:13 textAlignment:NSTextAlignmentLeft];
//                self.channlerig_Lab.frame = CGRectMake(14, 0, channelBtn.width-14, 36);
//                self.channlerig_Lab.text = eLocalizedString(channel_arr[i]);
//                [channelBtn addSubview:self.channlerig_Lab];
//                
//                self.channlerig_Img = [HistoryRecordModel createImgImgView];
//                self.channlerig_Img.frame = CGRectMake(20, 9, 18, 18);
//                self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//                [channelBtn2 addSubview:self.channlerig_Img];
//            }
//        }
        
//    }else {
//       
//    }
    
}

- (void)channelBtnChooseMethodOne
{
    for (int i=0; i<10; i++) {

        UIImageView *teImgVV2 = [self.scrollVVV viewWithTag:2400+i];
        if ([self.chose_mutAr containsObject:minIntStr(i)]) {
            teImgVV2.hidden = NO;
        }else {
            teImgVV2.hidden = YES;
        }
    }

    UIButton *jishi_btn = [self.scrollVVV viewWithTag:2601];
    NSString *str_str = [NSString stringWithFormat:@"fourth_timing%d_Img", self.jiShiType];
    [jishi_btn setBackgroundImage:[UIImage imageNamed:str_str] forState:UIControlStateNormal];

    UIButton *jplay_btn = [self.scrollVVV viewWithTag:2701];
    jplay_btn.selected = self.jiShiBoo;

    UIButton *suiji_btn = [self.scrollVVV viewWithTag:2602];
    suiji_btn.selected = self.isSuijiBoo;

    self.strong_Lab.text = minIntStr(self.strongType);

    self.jiShiSecond = [self getJiShiTime:self.jiShiType];
}
- (void)channelStartChooseMethodTwo
{
    
    if (self.isChannelBoo>0) {
        if (self.chose_mutAr.count > 0) {
            
            if (self.isChannelBoo_play > 0) {
                
                self.jiShiSecond = [self getJiShiTime:self.jiShiType];
                self.jiShiSecond_sub = 5;
                [self sendSocketThreeDataMethod];
                [self daojishiMethod];
            }else {
                
                [self sendSocketThreeDataMethodstop];
            }
        }
    }
    
}

//MARK: 通道选择
- (void)channelBtnMethod:(UIButton *)btn
{
//    if (btn.tag == 3300) {
//        
//        if (self.isChannelBoo) {
//            
//            if (!self.isChannelBoo_play) {
//                self.isChannelBoo = NO;
//                self.channlelef_Lab.textColor = normalColors;
//                self.channlerig_Lab.textColor = UIColor.whiteColor;
//                
//                for (int i=0; i<10; i++) {
//                    
//                    UIImageView *teImgVV2 = [self.scrollVVV viewWithTag:2400+i];
//                    if ([self.chose_mutAr containsObject:minIntStr(i)]) {
//                        teImgVV2.hidden = NO;
//                    }else {
//                        teImgVV2.hidden = YES;
//                    }
//                }
//                
//                UIButton *jishi_btn = [self.scrollVVV viewWithTag:2601];
//                NSString *str_str = [NSString stringWithFormat:@"fourth_timing%d_Img", self.jiShiType];
//                [jishi_btn setBackgroundImage:[UIImage imageNamed:str_str] forState:UIControlStateNormal];
//                
//                UIButton *jplay_btn = [self.scrollVVV viewWithTag:2701];
//                jplay_btn.selected = self.jiShiBoo;
//                
//                UIButton *suiji_btn = [self.scrollVVV viewWithTag:2602];
//                suiji_btn.selected = self.isSuijiBoo;
//                
//                self.strong_Lab.text = minIntStr(self.strongType);
//                
//                self.jiShiSecond = [self getJiShiTime:self.jiShiType];
//            }
//        }else {
//            self.isChannelBoo = NO;
//            self.channlelef_Lab.textColor = normalColors;
//            self.channlerig_Lab.textColor = UIColor.whiteColor;
//        }
//        
//    }else {
//        if (!self.isChannelBoo) {
//            
//            if (!self.isChannelBoo_play) {
//                self.isChannelBoo = YES;
//                self.channlerig_Lab.textColor = normalColors;
//                self.channlelef_Lab.textColor = UIColor.whiteColor;
//                
//                for (int i=0; i<10; i++) {
//                    
//                    UIImageView *teImgVV2 = [self.scrollVVV viewWithTag:2400+i];
//                    if ([self.chose_mutArB containsObject:minIntStr(i)]) {
//                        teImgVV2.hidden = NO;
//                    }else {
//                        teImgVV2.hidden = YES;
//                    }
//                }
//                
//                UIButton *jishi_btn = [self.scrollVVV viewWithTag:2601];
//                NSString *str_str = [NSString stringWithFormat:@"fourth_timing%d_Img", self.jiShiTypeB];
//                [jishi_btn setBackgroundImage:[UIImage imageNamed:str_str] forState:UIControlStateNormal];
//                
//                UIButton *jplay_btn = [self.scrollVVV viewWithTag:2701];
//                jplay_btn.selected = self.jiShiBooB;
//                
//                UIButton *suiji_btn = [self.scrollVVV viewWithTag:2602];
//                suiji_btn.selected = self.isSuijiBoo;
//                
//                self.strong_Lab.text = minIntStr(self.strongTypeB);
//                self.jiShiSecond = [self getJiShiTime:self.jiShiType];
//            }
//        }else {
//            self.isChannelBoo = YES;
//            self.channlerig_Lab.textColor = normalColors;
//            self.channlelef_Lab.textColor = UIColor.whiteColor;
//        }
//    }
}

//MARK: 倒计时
- (void)daojishiMethod
{
    if (self.isChannelBooW) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.isChannelBooW) {
            return;
        }
        if (self.isChannelBoo_play>0) {
            
            BOOL isJJ_boo = NO;
//            if (self.isChannelBoo) {
//                isJJ_boo = self.jiShiBooB;
//            }else {
                isJJ_boo = self.jiShiBoo;
//            }
            
            if (isJJ_boo) {
                if (self.jiShiSecond>0) {
                    self.jiShiSecond = self.jiShiSecond-1;
                    
                    if (self.jiShiSecond==0) {
                        [self sendSocketThreeDataMethodstop];
                        if (self.stopWBlock_) {
                            self.stopWBlock_(1);
                        }
                    }else {
                        
                        if (self.jiShiSecond_sub > 0) {
                         
                            self.jiShiSecond_sub = self.jiShiSecond_sub-1;
                            if (self.jiShiSecond_sub==0) {
                                
                                self.jiShiSecond_sub = 5;
                                
//                                if (self.isChannelBoo) {
//                                    if (self.isSuijiBooB) {
//                                        
//                                        self.play_modelTypeB = arc4random_uniform((int)self.chose_mutArB.count);  // 生成随机整数
//
//                                    }else {
//                                        if (self.chose_mutArB.count > self.play_modelTypeB+1) {
//                                            self.play_modelTypeB = self.play_modelTypeB+1;
//                                        }else {
//                                            self.play_modelTypeB = 0;
//                                        }
//                                    }
//                                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifUploadQiuiPlayListNote object:minIntStr(self.play_modelTypeB)];
//                                }else {
                                    if (self.isSuijiBoo) {
                                        
                                        self.play_modelType = arc4random_uniform((int)self.chose_mutAr.count);  // 生成随机整数

                                    }else {
                                        if (self.chose_mutAr.count > self.play_modelType+1) {
                                            self.play_modelType = self.play_modelType+1;
                                        }else {
                                            self.play_modelType = 0;
                                        }
                                    }
                                    
                                    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifUploadQiuiPlayListNote object:minIntStr(self.play_modelType)];
//                                }
                                
                                [self sendSocketThreeDataMethod];
                            }
                        }
                        
                        [self daojishiMethod];
                    }
                }
            }else {
                if (self.jiShiSecond_sub > 0) {
                 
                    self.jiShiSecond_sub = self.jiShiSecond_sub-1;
                    if (self.jiShiSecond_sub==0) {
                        
                        self.jiShiSecond_sub = 5;
                        
//                        if (self.isChannelBoo) {
//                            if (self.isSuijiBooB) {
//                                
//                                self.play_modelTypeB = arc4random_uniform((int)self.chose_mutArB.count);  // 生成随机整数
//
//                            }else {
//                                if (self.chose_mutArB.count > self.play_modelTypeB+1) {
//                                    self.play_modelTypeB = self.play_modelTypeB+1;
//                                }else {
//                                    self.play_modelTypeB = 0;
//                                }
//                            }
//                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifUploadQiuiPlayListNote object:minIntStr(self.play_modelTypeB)];
//                        }else {
                            
                            if (self.isSuijiBoo) {
                                
                                self.play_modelType = arc4random_uniform((int)self.chose_mutAr.count);  // 生成随机整数

                            }else {
                                if (self.chose_mutAr.count > self.play_modelType+1) {
                                    self.play_modelType = self.play_modelType+1;
                                }else {
                                    self.play_modelType = 0;
                                }
                            }
              
                            [[NSNotificationCenter defaultCenter] postNotificationName:kNotifUploadQiuiPlayListNote object:minIntStr(self.play_modelType)];
//                        }
                        
                        [self sendSocketThreeDataMethod];
                    }
                }
                
                [self daojishiMethod];
            }
        }
    });
}

//MARK: 通道 播放
- (void)channelBtnMethodPlay:(UIButton *)btn
{
//    if (btn.tag == 3400) {
//        
//        if (!self.isChannelBoo) {
//            
//            if (self.chose_mutAr.count > 0) {
//                self.isChannelBoo_play = !self.isChannelBoo_play;
//                
//                if (self.isChannelBoo_play) {
//                    self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playSel_Img"];
//                    
//                    self.jiShiSecond = [self getJiShiTime:self.jiShiType];
//                    self.jiShiSecond_sub = 5;
//                    [self sendSocketThreeDataMethod];
//                    [self daojishiMethod];
//                }else {
//                    self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//                    
//                    [self sendSocketThreeDataMethodstop];
//                }
//            }
//            
//        }
//    }else {
//        if (self.isChannelBoo) {
//            
//            if (self.chose_mutArB.count > 0) {
//                self.isChannelBoo_play = !self.isChannelBoo_play;
//                
//                if (self.isChannelBoo_play) {
//                    self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playSel_Img"];
//                    
//                    self.jiShiSecond = [self getJiShiTime:self.jiShiTypeB];
//                    self.jiShiSecond_sub = 5;
//                    [self sendSocketThreeDataMethod];
//                    [self daojishiMethod];
//                }else {
//                    self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//                    
//                    [self sendSocketThreeDataMethodstop];
//                }
//            }
//        }
//    }
}

- (void)stopMethodUIUIUI
{
    self.isChannelBooW = YES;
//    if (!self.isChannelBoo) {
//        
//        self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//        
//    }else {
//        self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//    }
}

- (BOOL)getBooMEthod
{
    return self.chose_mutAr.count > 0 ? YES:NO;
}

- (void)uploadUIUIUI
{
//    if (self.isChannelBoo_play==0) {
//        return;
//    }
    if (self.time_Boo2) {
        self.isChannelBooW = YES;
        if (self.time_Boo2_old) {
            
            [self sendSocketThreeDataMethodstop];
            
//            NSString *num_num = @"0";
//            NSString *channel_ab = @"1";
//            if (self.isChannelBoo) {
//                if (self.chose_mutArB.count > self.play_modelTypeB) {
//                    num_num = minIntStr([minStr(self.chose_mutArB[self.play_modelTypeB]) intValue]+1);
//                }
//                
//                channel_ab = @"2";
//            }else {
//                if (self.chose_mutAr.count > self.play_modelType) {
//                    num_num = minIntStr([minStr(self.chose_mutAr[self.play_modelType]) intValue]+1);
//                }
//            }
//            
//            BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
//            if(isEEEqq) {
//                
//                [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":num_num, @"channel":channel_ab, @"voltage":@"0"}];
//
//            }else {
//                if(self.isConnDevic) {
//                    
//                    [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":num_num, @"channel":channel_ab, @"voltage":@"0"}];
//                    
//                }else {
//                    if(self.twoBBlock_) {
//                        self.twoBBlock_(1);
//                    }
//                }
//            }
        }
    }else {
        
        self.isChannelBooW = NO;
        
        [self daojishiMethod];
        
//        if (self.isChannelBoo_play) {
//            [self sendSocketThreeDataMethod];
//        }
        
    }
}

- (void)sendSocketThreeDataMethod
{
//    if (self.isChannelBoo) {
//        if (self.chose_mutArB.count <= 0) {
//            self.isContinuBoo = NO;
//            return;
//        }
//    }else {
        if (self.chose_mutAr.count <= 0) {
            self.isContinuBoo = NO;
            return;
        }
//    }

    NSString *num_num = @"0";
    NSString *channel_ab = minIntStr(self.isChannelBoo_play); //@"1";
    NSString *channel_strong = @"0";
//    if (self.isChannelBoo) {
//        if (self.chose_mutArB.count > self.play_modelTypeB) {
//            num_num = minIntStr([minStr(self.chose_mutArB[self.play_modelTypeB]) intValue]+1);
//        }
//        channel_ab = @"2";
//        channel_strong = minIntStr(self.strongTypeB);
//    }else {
        if (self.chose_mutAr.count > self.play_modelType) {
            num_num = minIntStr([minStr(self.chose_mutAr[self.play_modelType]) intValue]+1);
        }
        channel_strong = minIntStr(self.strongType);
//    }
    
    NSLog(@"发送动态指令-qiui-- %@", num_num);
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":num_num, @"channel":channel_ab, @"voltage":channel_strong}];
        
    }else {
        if(self.isConnDevic) {
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":num_num, @"channel":channel_ab, @"voltage":channel_strong}];
            
        }else {
//            if(self.twoBBlock_) {
//                self.twoBBlock_(1);
//            }
        }
    }
    
    self.isContinuBoo = NO;
}

- (void)sendSocketThreeDataMethodstop
{
    NSLog(@"发送暂停指令-qiui");
    
    NSString *num_num = @"0";
    NSString *channel_ab = @"3";
//    if (self.isChannelBoo) {
//        if (self.chose_mutArB.count > self.play_modelTypeB) {
//            num_num = minIntStr([minStr(self.chose_mutArB[self.play_modelTypeB]) intValue]+1);
//        }
//        channel_ab = @"2";
//    }else {
        if (self.chose_mutAr.count > self.play_modelType) {
            num_num = minIntStr([minStr(self.chose_mutAr[self.play_modelType]) intValue]+1);
        }
//    }
//    self.isChannelBoo_play = NO;
//    self.channlelef_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
//    self.channlerig_Img.image = [UIImage imageNamed:@"fourth_playNor_Img"];
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(isEEEqq) {
        
        [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":num_num, @"channel":channel_ab, @"voltage":@"0"}];
    }else {
        if(self.isConnDevic) {
            
            [[eSocketRocketUtility sharedInstance] SRWebSocketSendJsonDic:@{@"type":@"QIUI-COLLAR-CONTROL-UPLOAD", @"deviceId":self.devicId, @"frequency":num_num, @"channel":channel_ab, @"voltage":@"0"}];
        }
    }
    
}

//MARK: 十个模式 状态改变
- (void)tenModelUploadStatusMethod
{
//    if (self.isChannelBoo) {
//        
//        for (int i=0; i<10; i++) {
//            
//            UIImageView *teImgVV2 = [self.scrollVVV viewWithTag:2400+i];
//            if ([self.chose_mutArB containsObject:minIntStr(i)]) {
//                teImgVV2.hidden = NO;
//            }else {
//                teImgVV2.hidden = YES;
//            }
//        }
//    }else {
        for (int i=0; i<10; i++) {
            
            UIImageView *teImgVV2 = [self.scrollVVV viewWithTag:2400+i];
            if ([self.chose_mutAr containsObject:minIntStr(i)]) {
                teImgVV2.hidden = NO;
            }else {
                teImgVV2.hidden = YES;
            }
        }
//    }
}

//MARK: 列表、定时、随机
- (void)selBBtnMethod:(UIButton *)btn
{
    switch (btn.tag) {
        case 2600:
        {
//            if (self.isChannelBoo) {
//               
//                if (self.chose_mutArB.count > 0) {
//                    MHFourthChannelJDBXView *jdbVC = [[MHFourthChannelJDBXView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
//                    jdbVC.listArr = self.chose_mutArB;
//                    jdbVC.playNumb = self.play_modelTypeB;
//                    [self.selfUpVC.view addSubview:jdbVC];
//                    [jdbVC addDataUploadUIUIMethod:NO];
//                    WEAKSELF
//                    jdbVC.block_ = ^(NSMutableArray * _Nonnull listArr, BOOL isBoo) {
//                        STRONG_SELF
//                        self.chose_mutArB = listArr;
//                        if (self.chose_mutArB.count<=0) {
//                            if (self.isChannelBoo_play) {
//                                
//                                [self sendSocketThreeDataMethodstop];
//                            }
//                            self.play_modelTypeB = 0;
//                        }
//                        if (self.chose_mutArB.count <= self.play_modelTypeB) {
//                            self.play_modelTypeB = 0;
//                        }
//                        [self tenModelUploadStatusMethod];
//                    };
//                }
//            }else {
                if (self.chose_mutAr.count > 0) {
                    MHFourthChannelJDBXView *jdbVC = [[MHFourthChannelJDBXView alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
                    jdbVC.listArr = self.chose_mutAr;
                    jdbVC.playNumb = self.play_modelType;
                    [self.selfUpVC.view addSubview:jdbVC];
                    [jdbVC addDataUploadUIUIMethod:NO];
                    WEAKSELF
                    jdbVC.block_ = ^(NSMutableArray * _Nonnull listArr, BOOL isBoo) {
                        STRONG_SELF
                      
                        self.chose_mutAr = listArr;
                        if (self.chose_mutAr.count<=0) {
                            if (self.isChannelBoo_play>0) {
                                
                                [self sendSocketThreeDataMethodstop];
                            }
                            self.play_modelType = 0;
                        }
                        if (self.chose_mutAr.count <= self.play_modelType) {
                            self.play_modelType = 0;
                        }
                        [self tenModelUploadStatusMethod];
                    };
                }
//            }
            
        }
            break;
        case 2601:
        {
            if (self.isContinuBoo) {
                return;
            }
            self.isContinuBoo = YES;

//            if (self.isChannelBoo) {
//                
//                if (self.jiShiTypeB<7) {
//                    self.jiShiTypeB = self.jiShiTypeB+1;
//                    
//                    NSString *str_str = [NSString stringWithFormat:@"fourth_timing%d_Img", self.jiShiTypeB];
//                    [btn setBackgroundImage:[UIImage imageNamed:str_str] forState:UIControlStateNormal];
//                }else {
//                    self.jiShiTypeB = 1;
//                    [btn setBackgroundImage:[UIImage imageNamed:@"fourth_timing1_Img"] forState:UIControlStateNormal];
//                }
//                self.jiShiSecond = [self getJiShiTime:self.jiShiTypeB];
//            }else {
                if (self.jiShiType<7) {
                    self.jiShiType = self.jiShiType+1;
                    
                    NSString *str_str = [NSString stringWithFormat:@"fourth_timing%d_Img", self.jiShiType];
                    [btn setBackgroundImage:[UIImage imageNamed:str_str] forState:UIControlStateNormal];
                }else {
                    self.jiShiType = 1;
                    [btn setBackgroundImage:[UIImage imageNamed:@"fourth_timing1_Img"] forState:UIControlStateNormal];
                }
                self.jiShiSecond = [self getJiShiTime:self.jiShiType];
//            }
            
//            if (self.isChannelBoo_play) {
//                [self sendSocketThreeDataMethod];
//            }else {
                self.isContinuBoo = NO;
//            }
        }
            break;
        case 2701:
        {
            if (self.isContinuBoo) {
                return;
            }
            self.isContinuBoo = YES;
            
            UIButton *playBBtn = [self.scrollVVV viewWithTag:2701];
//            if (self.isChannelBoo) {
//                self.jiShiBooB = !self.jiShiBooB;
//                playBBtn.selected = self.jiShiBooB;
//            }else {
                self.jiShiBoo = !self.jiShiBoo;
                playBBtn.selected = self.jiShiBoo;
//            }
           
//            if (self.isChannelBoo_play) {
//                [self sendSocketThreeDataMethod];
//            }else {
                self.isContinuBoo = NO;
//            }
        }
            break;
        case 2602:
        {
            
            btn.selected = !btn.selected;
//            if (self.isChannelBoo) {
//                self.isSuijiBooB = btn.selected;
//            }else {
                self.isSuijiBoo = btn.selected;
//            }
            
//            if (self.isChannelBoo_play) {
//                [self sendSocketThreeDataMethod];
//            }
        }
            break;
            
        default:
            break;
    }

}

//MARK: 强度 加 减
- (void)btnAllBtnMethodTag:(UIButton *)btn
{
    if (self.isContinuBoo) {
        return;
    }
    self.isContinuBoo = YES;
    
    BOOL isEEEqq = [self.roleOneModel.mac compare:[LYUserDefault userDefault].macName options:NSCaseInsensitiveSearch | NSNumericSearch] == NSOrderedSame;
    if(!isEEEqq) {
        if(self.isConnDevic) {
            isEEEqq = YES;
        }
    }
        
//    if (self.isChannelBoo) {
//        
//        int ff_aa = [minStr(self.strong_Lab.text) intValue];
//        if (btn.tag == 1002) {
//            if (ff_aa >= 10) {
//                self.strong_Lab.text = minIntStr(ff_aa-10);
//                self.strongTypeB = ff_aa-10;
//                
//            }
//        }else {
//            if (ff_aa < 100) {
//                self.strong_Lab.text = minIntStr(ff_aa+10);
//                self.strongTypeB = ff_aa+10;
//                
//            }
//        }
//    }else {
        
        int ff_aa = [minStr(self.strong_Lab.text) intValue];
        if (btn.tag == 1002) {
            if (ff_aa >= 1) {
                self.strong_Lab.text = minIntStr(ff_aa-1);
                self.strongType = ff_aa-1;
                
            }
        }else {
            if (ff_aa < 100) {
                self.strong_Lab.text = minIntStr(ff_aa+1);
                self.strongType = ff_aa+1;
                
            }
        }
//    }
    
    if (self.isChannelBoo_play>0) {
        [self sendSocketThreeDataMethod];
    }else {
        self.isContinuBoo = NO;
    }
}

//MARK: 模式选择
- (void)tenBtnMethodUIUIUIUTag:(UIButton *)btn
{
    if (self.isContinuBoo) {
        return;
    }
    self.isContinuBoo = YES;
    btn.selected = !btn.selected;
    
//    if (self.isChannelBoo) {
//        if (btn.selected) {
//            
//            UIImageView *nam_LLab = [self.scrollVVV viewWithTag:btn.tag+100];
//            nam_LLab.hidden = NO;
//            
//            if (![self.chose_mutArB containsObject:minIntStr((int)btn.tag-2300)]) {
//                
//                [self.chose_mutArB addObject:minIntStr((int)btn.tag-2300)];
//            }
//        }else {
//            UIImageView *nam_LLab = [self.scrollVVV viewWithTag:btn.tag+100];
//            nam_LLab.hidden = YES;
//            
//            if ([self.chose_mutArB containsObject:minIntStr((int)btn.tag-2300)]) {
//                
//                [self.chose_mutArB removeObject:minIntStr((int)btn.tag-2300)];
//            }
//        }
//    }else {
        if (btn.selected) {
            
            UIImageView *nam_LLab = [self.scrollVVV viewWithTag:btn.tag+100];
            nam_LLab.hidden = NO;
            
            if (![self.chose_mutAr containsObject:minIntStr((int)btn.tag-2300)]) {
                
                [self.chose_mutAr addObject:minIntStr((int)btn.tag-2300)];
            }
        }else {
            UIImageView *nam_LLab = [self.scrollVVV viewWithTag:btn.tag+100];
            nam_LLab.hidden = YES;
            
            if ([self.chose_mutAr containsObject:minIntStr((int)btn.tag-2300)]) {
                
                [self.chose_mutAr removeObject:minIntStr((int)btn.tag-2300)];
            }
        }
//    }
    
    if (self.isChannelBoo_play>0) {
        [self sendSocketThreeDataMethod];
    }else {
        self.isContinuBoo = NO;
    }

}

//MARK: 获取计时 时长
- (int)getJiShiTime:(int)typeMM
{
    switch (typeMM) {
        case 1:
        {
            return 5;
        }
            break;
        case 2:
        {
            return 10;
        }
            break;
        case 3:
        {
            return 20;
        }
            break;
        case 4:
        {
            return 30;
        }
            break;
        case 5:
        {
            return 60;
        }
            break;
        case 6:
        {
            return 100;
        }
            break;
        case 7:
        {
            return 300;
        }
            break;
            
        default:
        {
            return 5;
        }
            break;
    }
}

@end
