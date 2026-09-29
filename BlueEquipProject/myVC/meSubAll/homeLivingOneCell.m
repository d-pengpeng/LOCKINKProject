//
//  homeLivingOneCell.m
//  AuctionLiveProject
//
//  Created by Edwin on 2023/5/13.
//

#import "homeLivingOneCell.h"
#import "MHUserModel.h"
#import "MHVisitorController.h"
#import "MHfocusMMController.h"

@interface homeLivingOneCell ()

@property (nonatomic, strong) UIImageView *bgImgVV;
@property (nonatomic, strong) UIImageView *oneIMgV1;
@property (nonatomic, strong) UILabel *oneLab;
@property (nonatomic, strong) UILabel *oneLab2;
@property (nonatomic, strong) UIImageView *headImgVV;
@property (nonatomic, strong) UILabel *nickLab;
@property (nonatomic, strong) UILabel *IDLab;
@property (nonatomic, strong) UILabel *IPLab;
@property (nonatomic, strong) UILabel *texxxLab;
@property (nonatomic, strong) UIView *twoVV;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *focuuuBtn;
@property (nonatomic, strong) UIButton *msgIMBtn;
@property (nonatomic, strong) UIButton *growthCBtn;
@property (nonatomic, strong) UIButton *bgOneImgBtn;
@property (nonatomic, strong) UIButton *bgOneImgBtn2;
@property (nonatomic, assign) BOOL isOthrBB;
@property (nonatomic, strong) NSDictionary *dicOthr;
@property (nonatomic, strong) UIImageView *editImgVV;
@property (nonatomic, strong) MHUserModel *otherModel;

@end
@implementation homeLivingOneCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"homeLivingOneCell";
    homeLivingOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[homeLivingOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeLivingOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        UIView *al_VV = [[UIView alloc] init];
        al_VV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:al_VV];
        [al_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
            make.height.offset(310+TIMESTATUSHEIGHT);
        }];
        
        self.bgImgVV = [HistoryRecordModel createImgImgView];
        self.bgImgVV.frame = CGRectMake(0, 0, _window_width, 310+TIMESTATUSHEIGHT);
        self.bgImgVV.image = [UIImage imageNamed:@"userSpacePlacImg"];
        [al_VV addSubview:self.bgImgVV];
        
        UIButton *headClickBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, _window_width, 310-120)];
        [headClickBtn2 addTarget:self action:@selector(headTTTwoClickBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:headClickBtn2];
        
        _bgOneImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, TIMESTATUSHEIGHT+6, 85, 32)];
        [_bgOneImgBtn setBackgroundImage:[UIImage imageNamed:@"me_setingImg5"] forState:UIControlStateNormal];
        [al_VV addSubview:_bgOneImgBtn];
        
        _oneIMgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 16, 16)];
        [_bgOneImgBtn addSubview:_oneIMgV1];
        
        self.oneLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        self.oneLab.frame = CGRectMake(_oneIMgV1.x+20, 0, 52, 32);
        [_bgOneImgBtn addSubview:self.oneLab];
        
        _bgOneImgBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(_window_width-160, TIMESTATUSHEIGHT+6, 86, 32)];
        [_bgOneImgBtn2 setBackgroundImage:[UIImage imageNamed:@"me_setingImg5"] forState:UIControlStateNormal];
        [_bgOneImgBtn2 addTarget:self action:@selector(clickFKBtn) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:_bgOneImgBtn2];
        
        UIImageView *oneIMgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 16, 16)];
        oneIMgV2.image = [UIImage imageNamed:@"me_setingImg3"];
        [_bgOneImgBtn2 addSubview:oneIMgV2];
        
        self.oneLab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        self.oneLab2.frame = CGRectMake(oneIMgV2.x+20, 0, 52, 32);
        self.oneLab2.text = eLocalizedString(@"me_allNames9");
        [_bgOneImgBtn2 addSubview:self.oneLab2];
        
        self.growthCBtn = [HistoryRecordModel createImgBtn];
        self.growthCBtn.frame = CGRectMake(_window_width-90, TIMESTATUSHEIGHT, 26, 14);
        self.growthCBtn.backgroundColor = UIColor.redColor;
        [self.growthCBtn setTitle:@"+0" forState:UIControlStateNormal];
        [self.growthCBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.growthCBtn.titleLabel.font = SYS_Font(9);
        [al_VV addSubview:self.growthCBtn];
        self.growthCBtn.hidden = YES;
        
        
        self.headImgVV = [HistoryRecordModel createImgImgView];
        self.headImgVV.frame = CGRectMake(12, CGRectGetMaxY(_bgOneImgBtn2.frame)+7, 88, 88);
        self.headImgVV.layer.cornerRadius = 44;
        [al_VV addSubview:self.headImgVV];
//        self.headImgVV.image = [UIImage clipImgWithName:normal_placeHeadImg radius:10];
        
        UIImageView *imgPlacV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
        imgPlacV.image = [UIImage imageNamed:@"rankingBackImg4"];
        [self.headImgVV addSubview:imgPlacV];
        
        UIButton *headClickBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(_bgOneImgBtn2.frame)+7, 88, 88)];
        [headClickBtn addTarget:self action:@selector(headClickBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:headClickBtn];
        
        self.nickLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:20 textAlignment:NSTextAlignmentLeft];
        self.nickLab.frame = CGRectMake(CGRectGetMaxX(self.headImgVV.frame)+10, self.headImgVV.y, _window_width-(CGRectGetMaxX(self.headImgVV.frame)+10+12), 36);
        self.nickLab.text = eLocalizedString(@"me_allNames3");
        [al_VV addSubview:self.nickLab];
        
        self.IDLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.IDLab.frame = CGRectMake(CGRectGetMaxX(self.headImgVV.frame)+10, self.nickLab.y+36, _window_width-(CGRectGetMaxX(self.headImgVV.frame)+10+12), 22);
        self.IDLab.text = @"ID:";
        [al_VV addSubview:self.IDLab];
        
        self.IPLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.IPLab.frame = CGRectMake(CGRectGetMaxX(self.headImgVV.frame)+10, self.IDLab.y+22, _window_width-(CGRectGetMaxX(self.headImgVV.frame)+10+12), 22);
        self.IPLab.text = @"IP:";
        [al_VV addSubview:self.IPLab];
        
        self.texxxLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        self.texxxLab.frame = CGRectMake(12, CGRectGetMaxY(self.headImgVV.frame)+9, _window_width-24, 54);
        self.texxxLab.text = eLocalizedString(@"me_allNames4");
        self.texxxLab.numberOfLines = 2;
        [al_VV addSubview:self.texxxLab];
        
        self.editImgVV = [HistoryRecordModel createImgImgView];
        self.editImgVV.frame = CGRectMake(_window_width-24, CGRectGetMaxY(self.headImgVV.frame)+39, 12, 12);
        self.editImgVV.image = [UIImage imageNamed:@"edit_userImg"];
        [al_VV addSubview:self.editImgVV];
        
        
        UIButton *textClickBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, CGRectGetMaxY(self.headImgVV.frame)+9, _window_width, 54)];
        [textClickBtn addTarget:self action:@selector(textClickBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:textClickBtn];
        
        self.twoVV = [HistoryRecordModel createViewUIUI];
        self.twoVV.frame = CGRectMake(0, CGRectGetMaxY(self.texxxLab.frame)+5, _window_width, 40);
        self.twoVV.backgroundColor = UIColor.clearColor;
        [al_VV addSubview:self.twoVV];
        
        CGFloat thr_yy = CGRectGetMaxY(self.twoVV.frame)+10;
        CGFloat thr_yy2 = (_window_width-166)/3;
        self.editBtn = [HistoryRecordModel createImgBtn];
        self.editBtn.frame = CGRectMake(_window_width-154, thr_yy, 142, 32);
        self.editBtn.backgroundColor = normalColors;
        self.editBtn.layer.cornerRadius = 16;
        [self.editBtn setTitle:eLocalizedString(@"me_allNames5") forState:UIControlStateNormal];
        [self.editBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.editBtn.titleLabel.font = SYS_Font(14);
        [self.editBtn addTarget:self action:@selector(editBtnMethodUIUI) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:self.editBtn];
        
        
        self.focuuuBtn = [HistoryRecordModel createImgBtn];
        self.focuuuBtn.frame = CGRectMake(_window_width-154, thr_yy, 86, 32);
        self.focuuuBtn.backgroundColor = normalColors;
        self.focuuuBtn.layer.cornerRadius = 16;
        [self.focuuuBtn setTitle:eLocalizedString(@"plaza_all1") forState:UIControlStateNormal];
        [self.focuuuBtn setTitle:eLocalizedString(@"plaza_all1_1") forState:UIControlStateSelected];
        [self.focuuuBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.focuuuBtn.titleLabel.font = SYS_Font(14);
        [self.focuuuBtn addTarget:self action:@selector(FocusBtnMethodUIUI) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:self.focuuuBtn];
        
        self.msgIMBtn = [HistoryRecordModel createImgBtn];
        self.msgIMBtn.frame = CGRectMake(_window_width-44, thr_yy+4, 24, 24);
        [self.msgIMBtn setBackgroundImage:[UIImage imageNamed:@"msg_ImImg"] forState:UIControlStateNormal];
        [self.msgIMBtn addTarget:self action:@selector(chatBtnMethodUIUI) forControlEvents:UIControlEventTouchUpInside];
        [al_VV addSubview:self.msgIMBtn];
        self.focuuuBtn.hidden = YES;
        self.msgIMBtn.hidden = YES;
        
        NSArray *namsAAA = @[@"plaza_all1", @"me_allNames7", @"me_allNames8"];
        for (int i=0; i<namsAAA.count; i++) {
            
            UIView *subVMM = [[UIView alloc] initWithFrame:CGRectMake(12+i*thr_yy2, thr_yy-2, thr_yy2, 36)];
            subVMM.backgroundColor = UIColor.clearColor;
            [al_VV addSubview:subVMM];
            
            UILabel *subThrLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
            subThrLab.frame = CGRectMake(0, 0, thr_yy2, 18);
            subThrLab.tag = 8200+i;
            subThrLab.text = @"0";
            [subVMM addSubview:subThrLab];
            [subThrLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(subVMM);
                make.height.offset(18);
                make.width.mas_greaterThanOrEqualTo(36);
            }];
            
            UILabel *subThrla2 = [HistoryRecordModel createLabLabTextColor:RGB(169, 169, 169) fontFloat:13 textAlignment:NSTextAlignmentLeft];
            subThrla2.frame = CGRectMake(5, 18, thr_yy2-5, 18);
            subThrla2.text = eLocalizedString(namsAAA[i]);
            [subVMM addSubview:subThrla2];
            
            UIButton *thrMMMBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, thr_yy2, 36)];
            thrMMMBtn.tag = 3400+i;
            [thrMMMBtn addTarget:self action:@selector(thrMMBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
            [subVMM addSubview:thrMMMBtn];
        }
    }
    return self;
    
}

- (void)thrMMBtnMethod:(UIButton *)btn
{
    if(self.isOthrBB) {
        return;
    }
    if(btn.tag == 3400) {
        
        UIViewController *selfVV = [[FloatingWindowModel shareInstance] getCurrentViewController];
        MHfocusMMController *vc = [[MHfocusMMController alloc] init];
        [selfVV.navigationController pushViewController:vc animated:YES];
    }
    if(btn.tag == 3401) {
        UIViewController *selfVV = [[FloatingWindowModel shareInstance] getCurrentViewController];
        MHfocusMMController *vc = [[MHfocusMMController alloc] init];
        vc.isFensi = YES;
        [selfVV.navigationController pushViewController:vc animated:YES];
    }
}

//MARK: 我的空间
- (void)addDataToMeUser:(NSDictionary *)userDD
{
    MHUserModel *model = [MHUserModel mj_objectWithKeyValues:userDD];
    self.oneLab.text = model.rolePreference;
    if(model.rolePreference.length>0) {
        _oneIMgV1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@SexImg", model.rolePreference]];
    }
    
    if([model.guestGrowthCountConverted intValue] > 0) {
        
        self.growthCBtn.hidden = NO;
        if([model.guestGrowthCountConverted intValue] > 99) {
            [self.growthCBtn setTitle:@"+99" forState:UIControlStateNormal];
        }else {
            [self.growthCBtn setTitle:[NSString stringWithFormat:@"+%@", model.guestGrowthCountConverted] forState:UIControlStateNormal];
        }
    }else {
        self.growthCBtn.hidden = YES;
    }
    self.oneLab2.text = [NSString stringWithFormat:@"%@%d", eLocalizedString(@"me_allNames9"), model.guestCount];
    
    [self.headImgVV sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
    
    [self.bgImgVV sd_setImageWithURL:[NSURL URLWithString:model.bg] placeholderImage:[UIImage imageNamed:@"userSpacePlacImg"]];
    
    self.nickLab.text = model.nickName;
    self.IDLab.text = [NSString stringWithFormat:@"ID: %@", model.id];
    self.IPLab.text = [NSString stringWithFormat:@"IP: %@", model.placeOfOrigin];
    
    if(model.quote.length > 0) {
        self.texxxLab.text = model.quote;
    }
    
    UILabel *subThrL = [self.contentView viewWithTag:8200];
    UILabel *subThrL2 = [self.contentView viewWithTag:8201];
    UILabel *subThrL3 = [self.contentView viewWithTag:8202];
    subThrL.text = model.followingCountConverted;
    subThrL2.text = model.followersCountConverted;
    subThrL3.text = model.likesCountConverted;
    
    [self.twoVV removeAllSubviews];
    
    NSString *sex_im = @"";
    
    NSMutableArray *arrLpp = [NSMutableArray array];
    if(!model.agePrivate) {
        
        if(!model.genderPrivate) {
            sex_im = [NSString stringWithFormat:@"%@SexImg", model.gender];
            [arrLpp addObject:minIntStr(model.age)];
        }else {
            [arrLpp addObject:minIntStr(model.age)];
        }
    }else {
        if(!model.genderPrivate) {
            sex_im = [NSString stringWithFormat:@"%@SexImg", model.gender];
            [arrLpp addObject:@""];
        }
    }
    
    if(!model.heightPrivate) {
        [arrLpp addObject:[NSString stringWithFormat:@"%dCM", model.height]];
    }
    
    if(!model.weightPrivate) {
        [arrLpp addObject:[NSString stringWithFormat:@"%dKG", model.weight]];
    }
    
    if(!model.locationPrivate && (model.location.length>0)) {
        [arrLpp addObject:model.location];
    }
    
    if(!model.genderPreferencePrivate && (model.genderPreference.length>0)) {
        [arrLpp addObject:model.genderPreference];
    }
    
    UIScrollView *twoSSS = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.twoVV.width, 40)];
    twoSSS.backgroundColor = UIColor.clearColor;
    twoSSS.showsVerticalScrollIndicator = NO;
    twoSSS.showsHorizontalScrollIndicator = NO;
    [self.twoVV addSubview:twoSSS];
    twoSSS.contentSize = CGSizeMake(14+arrLpp.count*75, 30);
    
    for (int i=0; i<arrLpp.count; i++) {
        CGFloat w_ww = 75;//[HistoryRecordModel jiSuanWith:arrLpp[i] font:13]+26;
        UIImageView *arLopImgV = [[UIImageView alloc] initWithFrame:CGRectMake(12+i*w_ww, 10, w_ww-10, 20)];
        arLopImgV.image = [UIImage imageNamed:@"me_setingImg5"];
        arLopImgV.clipsToBounds = YES;
        [twoSSS addSubview:arLopImgV];
        
        UILabel *subXXLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
        subXXLab.text = minStr(arrLpp[i]);
        [arLopImgV addSubview:subXXLab];
        
        if(sex_im.length>0) {
            if(i==0) {
                NSString *mm = minStr(arrLpp[i]);
                UIImageView *sexIIIMM = [HistoryRecordModel createImgImgView];
                sexIIIMM.image = [UIImage imageNamed:sex_im];
                [arLopImgV addSubview:sexIIIMM];
                if(mm.length>0) {
                    sexIIIMM.frame = CGRectMake(8, 4, 12, 12);
                    subXXLab.frame = CGRectMake(22, 0, w_ww-37, 20);
                }else {
                    sexIIIMM.frame = CGRectMake(arLopImgV.width/2-6, 4, 12, 12);
                }
                
            }else {
                subXXLab.frame = CGRectMake(5, 0, w_ww-20, 20);
            }
        }else {
            subXXLab.frame = CGRectMake(5, 0, w_ww-20, 20);
        }
    }
}

//MARK: 其他人空间
- (void)addDataToOthrUser:(NSDictionary *)userDD
{
    self.isOthrBB = YES;
    self.editImgVV.hidden = YES;
    _bgOneImgBtn.frame = CGRectMake(_window_width-97, self.IDLab.y-5, 85, 32);
    _bgOneImgBtn2.hidden = YES;
    self.editBtn.hidden = YES;
    
    self.focuuuBtn.hidden = NO;
    self.msgIMBtn.hidden = NO;
    
    self.dicOthr = userDD;
    MHUserModel *model = [MHUserModel mj_objectWithKeyValues:userDD];
    self.otherModel = model;
    self.oneLab.text = model.rolePreference;
    if(model.rolePreference.length>0) {
        _oneIMgV1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@SexImg", model.rolePreference]];
    }
    
    [self.headImgVV sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
    [self.bgImgVV sd_setImageWithURL:[NSURL URLWithString:model.bg] placeholderImage:[UIImage imageNamed:@"userSpacePlacImg"]];
    
    self.nickLab.text = model.nickName;
    self.IDLab.text = [NSString stringWithFormat:@"ID: %@", model.id];
    self.IPLab.text = [NSString stringWithFormat:@"IP: %@", model.placeOfOrigin];
    
    if(model.quote.length > 0) {
        self.texxxLab.text = model.quote;
    }
    
    if(model.isFollowed) {
        self.focuuuBtn.backgroundColor = UIColor.clearColor;
        self.focuuuBtn.layer.borderColor = UIColor.whiteColor.CGColor;
        self.focuuuBtn.layer.borderWidth = 1;
        self.focuuuBtn.selected = YES;
    }else {
        self.focuuuBtn.backgroundColor = normalColors;
        self.focuuuBtn.layer.borderColor = normalColors.CGColor;
        self.focuuuBtn.layer.borderWidth = 1;
        self.focuuuBtn.selected = NO;
    }
    
    
    UILabel *subThrL = [self.contentView viewWithTag:8200];
    UILabel *subThrL2 = [self.contentView viewWithTag:8201];
    UILabel *subThrL3 = [self.contentView viewWithTag:8202];
    subThrL.text = model.followingCountConverted;
    subThrL2.text = model.followersCountConverted;
    subThrL3.text = model.likesCountConverted;
    
    [self.twoVV removeAllSubviews];
    
    NSString *sex_im = @"";
    
    NSMutableArray *arrLpp = [NSMutableArray array];
    if(!model.agePrivate) {
        
        if(!model.genderPrivate) {
            sex_im = [NSString stringWithFormat:@"%@SexImg", model.gender];
            [arrLpp addObject:minIntStr(model.age)];
        }else {
            [arrLpp addObject:minIntStr(model.age)];
        }
    }else {
        if(!model.genderPrivate) {
            sex_im = [NSString stringWithFormat:@"%@SexImg", model.gender];
            [arrLpp addObject:@""];
        }
    }
    
    if(!model.heightPrivate) {
        [arrLpp addObject:[NSString stringWithFormat:@"%dCM", model.height]];
    }
    
    if(!model.weightPrivate) {
        [arrLpp addObject:[NSString stringWithFormat:@"%dKG", model.weight]];
    }
    
    if(!model.locationPrivate && (model.location.length>0)) {
        [arrLpp addObject:model.location];
    }
    
    if(!model.genderPreferencePrivate && (model.genderPreference.length>0)) {
        [arrLpp addObject:model.genderPreference];
    }
    
    UIScrollView *twoSSS = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.twoVV.width, 30)];
    twoSSS.backgroundColor = UIColor.clearColor;
    twoSSS.showsVerticalScrollIndicator = NO;
    twoSSS.showsHorizontalScrollIndicator = NO;
    [self.twoVV addSubview:twoSSS];
    twoSSS.contentSize = CGSizeMake(14+arrLpp.count*75, 30);
    
    for (int i=0; i<arrLpp.count; i++) {
        CGFloat w_ww = 75;//[HistoryRecordModel jiSuanWith:arrLpp[i] font:13]+26;
        UIImageView *arLopImgV = [[UIImageView alloc] initWithFrame:CGRectMake(12+i*w_ww, 10, w_ww-10, 20)];
        arLopImgV.image = [UIImage imageNamed:@"me_setingImg5"];
        arLopImgV.clipsToBounds = YES;
        [twoSSS addSubview:arLopImgV];
        
        UILabel *subXXLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
        subXXLab.text = minStr(arrLpp[i]);
        [arLopImgV addSubview:subXXLab];
        
        if(sex_im.length>0) {
            if(i==0) {
                NSString *mm = minStr(arrLpp[i]);
                UIImageView *sexIIIMM = [HistoryRecordModel createImgImgView];
                sexIIIMM.image = [UIImage imageNamed:sex_im];
                [arLopImgV addSubview:sexIIIMM];
                if(mm.length>0) {
                    sexIIIMM.frame = CGRectMake(8, 4, 12, 12);
                    subXXLab.frame = CGRectMake(22, 0, w_ww-37, 20);
                }else {
                    sexIIIMM.frame = CGRectMake(arLopImgV.width/2-6, 4, 12, 12);
                }
                
            }else {
                subXXLab.frame = CGRectMake(5, 0, w_ww-20, 20);
            }
        }else {
            subXXLab.frame = CGRectMake(5, 0, w_ww-20, 20);
        }
    }
}

//MARK: 关注
- (void)FocusBtnMethodUIUI
{
    [SVProgressHUD show];
    NSString *urlMM = [NSString stringWithFormat:@"%@?followingId=%@", request_user_followOrUnfollow, self.otherModel.id];
    [requestToolClass getNetworkWithUrl:urlMM andParameter:@{} success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.otherModel.isFollowed = !self.otherModel.isFollowed;
        if(self.otherModel.isFollowed) {
            self.focuuuBtn.backgroundColor = UIColor.clearColor;
            self.focuuuBtn.layer.borderColor = UIColor.whiteColor.CGColor;
            self.focuuuBtn.layer.borderWidth = 1;
            self.focuuuBtn.selected = YES;
        }else {
            self.focuuuBtn.backgroundColor = normalColors;
            self.focuuuBtn.layer.borderColor = normalColors.CGColor;
            self.focuuuBtn.layer.borderWidth = 1;
            self.focuuuBtn.selected = NO;
        }
        
        if([self.delegate_ respondsToSelector:@selector(homeLivUploadMethod)]) {
            [self.delegate_ homeLivUploadMethod];
        }
    } fail:^(NSString * _Nonnull msg) {
        
    }];
}

//MARK: 私聊
- (void)chatBtnMethodUIUI
{
    MHUserModel *model = [MHUserModel mj_objectWithKeyValues:self.dicOthr];
    [[FloatingWindowModel shareInstance] switchChatDetailControlNick:model.nickName hostId:model.id];
}

- (void)editBtnMethodUIUI
{
    if([self.delegate_ respondsToSelector:@selector(clickHomeLivingOneCellMethod:)]) {
        [self.delegate_ clickHomeLivingOneCellMethod:1];
    }
}

- (void)clickFKBtn
{
    UIViewController *selfVV = [[FloatingWindowModel shareInstance] getCurrentViewController];
    MHVisitorController *vc = [[MHVisitorController alloc] init];
    [selfVV.navigationController pushViewController:vc animated:YES];
}

- (void)headClickBtnMethod
{
    if([self.delegate_ respondsToSelector:@selector(clickHomeLivingOneCellMethod:)]) {
        [self.delegate_ clickHomeLivingOneCellMethod:2];
    }
}

- (void)headTTTwoClickBtnMethod
{
    if([self.delegate_ respondsToSelector:@selector(clickHomeLivingOneCellMethod:)]) {
        [self.delegate_ clickHomeLivingOneCellMethod:3];
    }
}

- (void)textClickBtnMethod
{
    if([self.delegate_ respondsToSelector:@selector(clickHomeLivingOneCellMethod:)]) {
        [self.delegate_ clickHomeLivingOneCellMethod:4];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
