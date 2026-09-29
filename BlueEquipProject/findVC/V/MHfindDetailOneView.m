//
//  MHfindDetailOneView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/15.
//

#import "MHfindDetailOneView.h"
#import "TUIDefine.h"
#import <AFNetworking/AFNetworking.h>
#import "MHOthrMyController.h"

@interface MHfindDetailOneView ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) UIView *one_VV;
@property (nonatomic, strong) UIView *two_VV;
@property (nonatomic, strong) UIView *thr_VV;
@property (nonatomic, strong) UIView *fou_VV;
@property (nonatomic, strong) UIView *fiv_VV;
@property (nonatomic, strong) UIView *fou_VVsub;

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIImageView *vipImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *focusBtn;
@property (nonatomic,strong) UIButton *deetetBtn;
@property (nonatomic,strong) UILabel *showTypLab;
@property (nonatomic,strong) UILabel *showBtn;

@property (nonatomic,strong) NSIndexPath *indexp;
@property (nonatomic,strong) UITextView *contentLabel;
@property (nonatomic, assign) BOOL isBBBme;
@property (nonatomic, strong) MHfindSubPatternsModel *oneModel;
@property (nonatomic, strong) UIButton *loginBBtn;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, copy) NSString *wavPath;

@property (nonatomic, strong) UIImage *voiceImage;
@property (nonatomic, strong) NSArray *voiceAnimationImages;
@property (nonatomic, strong) UIImageView *voice;
@property (nonatomic, strong) UILabel *duration;
@property (nonatomic, copy) NSString *pathOne;
@property (nonatomic, assign) BOOL isPPlayb;
@property (nonatomic, assign) BOOL isRRRR;
@end

@implementation MHfindDetailOneView

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHfindDetailOneView";
    MHfindDetailOneView *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHfindDetailOneView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHfindDetailOneView"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.one_VV = [[UIView alloc] init];
        self.one_VV.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:self.one_VV];
        [self.one_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
        }];
        
        self.two_VV = [[UIView alloc] init];
        self.two_VV.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:self.two_VV];
        [self.two_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.one_VV.mas_bottom);
            make.left.right.equalTo(self.contentView);
        }];
        
        self.thr_VV = [[UIView alloc] init];
        self.thr_VV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.thr_VV];
        [self.thr_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.two_VV.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.height.offset(0);
//            make.bottom.equalTo(self.contentView);
        }];
        
        self.fiv_VV = [[UIView alloc] init];
        self.fiv_VV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.fiv_VV];
        [self.fiv_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.thr_VV.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.height.offset(0);
        }];
        self.fiv_VV.hidden = YES;
        
        self.fou_VV = [[UIView alloc] init];
        self.fou_VV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.fou_VV];
        [self.fou_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fiv_VV.mas_bottom);
            make.left.right.equalTo(self.contentView);
//            make.height.offset(440);
            make.height.offset(0);
            make.bottom.equalTo(self.contentView);
        }];
        
        self.fou_VVsub = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 28)];
        self.fou_VVsub.backgroundColor = UIColor.clearColor;
        [self.fou_VV addSubview:self.fou_VVsub];
        
        UILabel *fou_lab0 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        fou_lab0.frame = CGRectMake(12, 38, _window_width/2, 34);
        fou_lab0.text = eLocalizedString(@"role_name12");
        [self.fou_VV addSubview:fou_lab0];
        
        NSArray *fou_Arr = @[@"login_all36", @"find_detail1", @"login_all35", @"login_all31", @"login_all34", @"find_detail2", @"find_detail3"];
        for (int i=0; i<fou_Arr.count; i++) {
            
            UILabel *al_lab = [HistoryRecordModel createLabLabTextColor:RGB(94, 94, 94) fontFloat:14 textAlignment:NSTextAlignmentLeft];
            al_lab.frame = CGRectMake(18, 38+34+i*32, _window_width/2, 32);
            al_lab.text = eLocalizedString(fou_Arr[i]);
            al_lab.tag = 7800+i;
            [self.fou_VV addSubview:al_lab];
            
            UILabel *al_lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:14 textAlignment:NSTextAlignmentRight];
            al_lab2.frame = CGRectMake(_window_width/2, 38+34+i*32, _window_width/2-18, 32);
            al_lab2.text = eLocalizedString(fou_Arr[i]);
            al_lab2.tag = 7700+i;
            [self.fou_VV addSubview:al_lab2];
            
            if(i > 4) {
                al_lab2.textColor = normalColors;
            }
        }
        
        _loginBBtn = [HistoryRecordModel createImgBtn];
        _loginBBtn.frame = CGRectMake((_window_width-210)/2, 38+34+32*7+40, 210, 46);
        [_loginBBtn setBackgroundImage:[UIImage imageNamed:@"center_img12"] forState:UIControlStateNormal];
        [_loginBBtn setBackgroundImage:[UIImage imageNamed:@"center_img12sel"] forState:UIControlStateSelected];
        [_loginBBtn setTitle:eLocalizedString(@"find_detail4") forState:UIControlStateNormal];
        [_loginBBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _loginBBtn.titleLabel.font = SYS_Font(18);
        [_loginBBtn addTarget:self action:@selector(loginBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.fou_VV addSubview:_loginBBtn];
        
        UIView *linVV_Fou = [HistoryRecordModel createLineViewUIUI];
        linVV_Fou.frame = CGRectMake(0, CGRectGetMaxY(self.loginBBtn.frame)+20, _window_width, 10);
        linVV_Fou.backgroundColor = RGB(243, 224, 251);
        [self.fou_VV addSubview:linVV_Fou];
        
        UILabel *pinglaLab = [HistoryRecordModel createLabLabTextColor:GrayTextColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        pinglaLab.frame = CGRectMake(12, CGRectGetMaxY(linVV_Fou.frame)+10, _window_width, 26);
        pinglaLab.text = eLocalizedString(@"find_detail5");
        [self.fou_VV addSubview:pinglaLab];
        self.fou_VV.hidden = YES;
        self.fiv_VV.hidden = YES;
        
        self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 42, 42)];
        self.headImg.layer.cornerRadius = 21;
        self.headImg.layer.masksToBounds = true;
        [self.one_VV addSubview:self.headImg];
        [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.one_VV).offset(12);
            make.width.height.offset(42);
        }];
        self.headImg.image = normal_placeHeadImg;
        
        UIButton *clickHeadBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 12, 42, 42)];
        [clickHeadBtn addTarget:self action:@selector(clcikHeadMehtod) forControlEvents:UIControlEventTouchUpInside];
        [self.one_VV addSubview:clickHeadBtn];
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = SYS_Font(14);
        self.nameLabel.text = @"";
        self.nameLabel.textColor = UIColor.blackColor;
        [self.one_VV addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).offset(12);
            make.top.equalTo(self.one_VV).offset(16);
            make.height.offset(21);
            make.width.mas_lessThanOrEqualTo(90);
        }];
        
        self.vipImg = [[UIImageView alloc]init];
        self.vipImg.image = [UIImage imageNamed:@"top_imgTop"];
        self.vipImg.clipsToBounds = YES;
        [self.one_VV addSubview:self.vipImg];
        [self.vipImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.mas_centerY);
            make.left.equalTo(self.nameLabel.mas_right).offset(10);
            make.width.height.offset(14);
        }];
        self.vipImg.hidden = YES;
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = SYS_Font(12);
        self.timeLabel.text = @"00-00 00:00";
        self.timeLabel.textColor = UIColor.blackColor;
        [self.one_VV addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImg.mas_right).offset(12);
            make.top.equalTo(self.nameLabel.mas_bottom);
            make.height.offset(21);
        }];
        
        self.focusBtn = [[UIButton alloc] init];
        [self.focusBtn setTitle:eLocalizedString(@"attent_normal") forState:UIControlStateNormal];
        [self.focusBtn setTitle:eLocalizedString(@"attent_sel") forState:UIControlStateSelected];
        [self.focusBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.focusBtn setTitleColor:normalPurpleColors forState:UIControlStateSelected];
        self.focusBtn.titleLabel.font = SYS_Font(12);
        self.focusBtn.layer.cornerRadius = 12;
        self.focusBtn.backgroundColor = normalPurpleColors;
        self.focusBtn.layer.borderColor = normalPurpleColors.CGColor;
        self.focusBtn.layer.borderWidth = 1;
        [self.focusBtn addTarget:self action:@selector(focusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.one_VV addSubview:self.focusBtn];
        [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headImg.mas_centerY);
            make.right.equalTo(self.one_VV.mas_right).offset(-12);
            make.width.offset(54);
            make.height.offset(24);
        }];
        
        self.deetetBtn = [HistoryRecordModel createImgBtn];
        [self.deetetBtn setImage:[UIImage imageNamed:@"delete_img"] forState:UIControlStateNormal];
        [self.deetetBtn addTarget:self action:@selector(deleeeeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.one_VV addSubview:self.deetetBtn];
        [self.deetetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headImg.mas_centerY);
            make.right.equalTo(self.one_VV.mas_right).offset(-12);
            make.width.height.offset(30);
        }];
        self.deetetBtn.hidden = YES;
        
        self.showTypLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:14 textAlignment:NSTextAlignmentRight];
        self.showTypLab.text = eLocalizedString(@"me_allNames10");
        [self.one_VV addSubview:self.showTypLab];
        [self.showTypLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headImg.mas_centerY);
            make.right.equalTo(self.one_VV.mas_right).offset(-12);
            make.height.offset(30);
        }];
        self.showTypLab.hidden = YES;

//        self.contentLabel = [[UILabel alloc]init];
//        self.contentLabel.font = SYS_Font(14);
//        self.contentLabel.text = @"";
//        self.contentLabel.numberOfLines = 0;
//        self.contentLabel.textColor = UIColor.blackColor;
//        [self.one_VV addSubview:self.contentLabel];
//        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.timeLabel.mas_left);
//            make.top.equalTo(self.headImg.mas_bottom).offset(9);
//            make.right.equalTo(self.one_VV.mas_right).offset(-12);
//            make.bottom.equalTo(self.one_VV.mas_bottom).offset(-9);
//        }];
        
        self.contentLabel = [[UITextView alloc]init];
        self.contentLabel.font = SYS_Font(14);
        self.contentLabel.text = @"";
        self.contentLabel.backgroundColor = UIColor.clearColor;
        self.contentLabel.textColor = UIColor.blackColor;
        self.contentLabel.scrollEnabled = NO;
        self.contentLabel.editable = NO;
        [self.one_VV addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_left);
            make.top.equalTo(self.headImg.mas_bottom).offset(9);
            make.right.equalTo(self.one_VV.mas_right).offset(-12);
            make.bottom.equalTo(self.one_VV.mas_bottom).offset(-9);
        }];
        
     }
    return self;
}

- (void)deleeeeBtnClick
{
    
}

- (void)loginBtnMethod
{
    if(self.isRRRR){
        return;
    }
    self.isRRRR = YES;
    [SVProgressHUD show];
    
    NSDictionary *dmmmCC = @{@"recordId":minStr(self.oneModel.recordId), @"type":@"SEEKING"};
    if([self.oneModel.type isEqualToString:@"VOTE"]) {
        dmmmCC = @{@"recordId":minStr(self.oneModel.recordId), @"type":@"VOTE"};
    }
    [requestToolClass postNetworkWithUrl:request_square_processApplicationOrVote andParameter:dmmmCC success:^(int code, id  _Nonnull info, NSString * _Nonnull msg) {
        
        self.loginBBtn.selected = YES;
        self.loginBBtn.userInteractionEnabled = NO;
        self.isRRRR = NO;
    } fail:^(NSString * _Nonnull msg) {
        self.isRRRR = NO;
    }];
}

//MARK: 查看申请列表
- (void)clickBtnMethodPeopleList
{
    if ([self.delegate_ respondsToSelector:@selector(focusOrGoodOrComment:indexPath:)]) {
        [self.delegate_ focusOrGoodOrComment:2 indexPath:self.indexp];
    }
}

- (void)clcikHeadMehtod
{
    UIViewController *selfVC = [[FloatingWindowModel shareInstance] getCurrentViewController];
    MHOthrMyController *vc = [[MHOthrMyController alloc] init];
    vc.otherId = minStr(self.oneModel.uid);
    [selfVC.navigationController pushViewController:vc animated:YES];
    vc.block_ = ^{
        if([self.delegate_ respondsToSelector:@selector(findDetailUploadMethod)]) {
            [self.delegate_ findDetailUploadMethod];
        }
    };
}

- (void)addDataToDic:(MHfindSubPatternsModel *)model row:(NSIndexPath *)rowL dicDetail:(nonnull NSDictionary *)detailDci
{
    self.indexp = rowL;
    self.oneModel = model;
    
    if([model.uid isEqualToString:[LYUserDefault userDefault].t_id]) {
        self.focusBtn.hidden = YES;
    }else {
        self.focusBtn.selected = model.isFollowed;
        if(model.isFollowed) {
            self.focusBtn.backgroundColor = UIColor.whiteColor;
        }else {
            self.focusBtn.backgroundColor = normalPurpleColors;
        }
    }
    
    if([model.type isEqualToString:@"ACTIVITY"]) {
        
        [self.fiv_VV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(52);
        }];
        [self.fou_VV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
        self.fou_VV.hidden = YES;
        self.fiv_VV.hidden = NO;
 
        [self.fiv_VV removeAllSubviews];
        UIView *tpppV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 52)];
        tpppV.backgroundColor = UIColor.whiteColor;
        [self.fiv_VV addSubview:tpppV];
        
        UIView *linvV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _window_width, 10)];
        linvV.backgroundColor = RGB(243, 224, 251);
        [tpppV addSubview:linvV];
        
        UILabel *pingLab = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        pingLab.frame = CGRectMake(12, 10, _window_width-24, 42);
        pingLab.text = eLocalizedString(@"find_detail5");
        [tpppV addSubview:pingLab];
      
    }else {
        [self.fiv_VV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
        [self.fou_VV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(440);
        }];
        self.fou_VV.hidden = NO;
        self.fiv_VV.hidden = YES;
        
        if([self.oneModel.type isEqualToString:@"VOTE"]) {
            [_loginBBtn setTitle:eLocalizedString(@"find_detail4_4") forState:UIControlStateNormal];
        }
        [self.fou_VVsub removeAllSubviews];
        
         UIImageView *bHeadImgV = [[UIImageView alloc] initWithFrame:CGRectMake(64, 0, _window_width-76, 28)];
         bHeadImgV.image = [UIImage imageNamed:@"plaza_imgs12"];
         [self.fou_VVsub addSubview:bHeadImgV];
         
         UIImageView *sexyImV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 28, 28)];
         sexyImV.clipsToBounds = YES;
         sexyImV.image = [UIImage imageNamed:@"plaza_imgs6"];
         [bHeadImgV addSubview:sexyImV];
         
         UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
         nexImgv.frame = CGRectMake(bHeadImgV.width-22, 7, 14, 14);
         nexImgv.image = [UIImage imageNamed:@"home_next2"];
         [bHeadImgV addSubview:nexImgv];
        
        if([self.oneModel.type isEqualToString:@"VOTE"]) {
            if([detailDci[@"voteInfo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dciMM = detailDci[@"voteInfo"];
                model.participantCount = [minStr(dciMM[@"voterCount"]) intValue];
                
                NSArray *ar_arr = dciMM[@"participantList"];
                NSMutableArray *head_ar = [NSMutableArray array];
                for (int i=0; i<ar_arr.count; i++) {
                    if([ar_arr[i] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *dicm = ar_arr[i];
                        [head_ar addObject:minStr(dicm[@"profile"])];
                    }else {
                        [head_ar addObject:minStr(ar_arr[i])];
                    }
                }
             
                model.participantProfileList = head_ar;
                
                if([dciMM[@"conditions"] isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *modelCont = dciMM[@"conditions"];
                    NSArray *lis_arr = @[minStr(modelCont[@"location"]), minStr(modelCont[@"genderRange"]), minStr(modelCont[@"rolePreferenceRange"]), minStr(modelCont[@"ageRange"]), minStr(modelCont[@"genderPreferenceRange"]), minStr(dciMM[@"perLockoutPeriod"]), minStr(dciMM[@"deadline"])];
                    for (int i=0; i<lis_arr.count; i++) {
                        UILabel *al_lab2 = [self.fou_VV viewWithTag:7700+i];
                        al_lab2.text = lis_arr[i];
                    }
                    
                    UILabel *al_lab = [self.fou_VV viewWithTag:7805];
                    if ([[FloatingWindowModel shareInstance].devicNameArr containsObject:minStr(dciMM[@"deviceModel"])]) {
                        al_lab.text = eLocalizedString(@"role_name33_33");
                    }else {
                        al_lab.text = eLocalizedString(@"role_name33");
                    }
                }
                if([minStr(dciMM[@"voted"]) isEqualToString:@"true"]) {
                    _loginBBtn.selected = YES;
                    _loginBBtn.userInteractionEnabled = NO;
                }
            }
        }else {
            if([detailDci[@"seekingInfo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dciMM = detailDci[@"seekingInfo"];
                model.participantCount = [minStr(dciMM[@"applicantCount"]) intValue];
                
                NSArray *ar_arr = dciMM[@"participantList"];
                NSMutableArray *head_ar = [NSMutableArray array];
                for (int i=0; i<ar_arr.count; i++) {
                    if([ar_arr[i] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *dicm = ar_arr[i];
                        [head_ar addObject:minStr(dicm[@"profile"])];
                    }else {
                        [head_ar addObject:minStr(ar_arr[i])];
                    }
                }
               
                model.participantProfileList = head_ar;
                
                if([dciMM[@"conditions"] isKindOfClass:[NSDictionary class]]) {
                    
                    NSDictionary *modelCont = dciMM[@"conditions"];
                    NSArray *lis_arr = @[minStr(modelCont[@"location"]), minStr(modelCont[@"genderRange"]), minStr(modelCont[@"rolePreferenceRange"]), minStr(modelCont[@"ageRange"]), minStr(modelCont[@"genderPreferenceRange"]), minStr(dciMM[@"transferDays"]), minStr(dciMM[@"deadline"])];
                    for (int i=0; i<lis_arr.count; i++) {
                        UILabel *al_lab2 = [self.fou_VV viewWithTag:7700+i];
                        al_lab2.text = lis_arr[i];
                    }
                }
//                if([minStr(dciMM[@"applied"]) isEqualToString:@"true"]) { //弃用
//                    _loginBBtn.selected = YES;
//                    _loginBBtn.userInteractionEnabled = NO;
//                }
                [_loginBBtn setTitle:eLocalizedString(@"find_detail4") forState:UIControlStateNormal];
                switch ([minStr(dciMM[@"applyStatus"]) intValue]) {
                    case 2:
                    {
                        _loginBBtn.selected = YES;
                        _loginBBtn.userInteractionEnabled = NO;
                    }
                        break;
                    case 3:
                    {
                        _loginBBtn.selected = YES;
                        _loginBBtn.userInteractionEnabled = NO;
                        [_loginBBtn setTitle:eLocalizedString(@"find_detail4_44") forState:UIControlStateNormal];
                        
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
        }
        
         UILabel *shenqingLab = [HistoryRecordModel createLabLabTextColor:normalColors fontFloat:12 textAlignment:NSTextAlignmentRight];
         shenqingLab.text = [NSString stringWithFormat:@"%@%d%@", eLocalizedString(@"me_allNames15"), model.participantCount, eLocalizedString(@"me_allNames16")];
         [bHeadImgV addSubview:shenqingLab];
         [shenqingLab mas_makeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(nexImgv.mas_left).offset(-4);
             make.top.bottom.equalTo(bHeadImgV);
         }];
         
         CGFloat ww_w = model.participantProfileList.count*12+12;
         
         UIView *placV = [[UIView alloc] init];
         placV.clipsToBounds = YES;
         [bHeadImgV addSubview:placV];
         [placV mas_makeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(shenqingLab.mas_left).offset(-6);
             make.top.equalTo(bHeadImgV.mas_top).offset(2);
             make.height.offset(24);
             make.width.offset(ww_w);
         }];
         
         for (int i=0; i<model.participantProfileList.count; i++) {
             UIImageView *imgMM = [HistoryRecordModel createImgImgView];
             imgMM.frame = CGRectMake(i*12, 0, 24, 24);
             imgMM.layer.cornerRadius = 12;
             [placV addSubview:imgMM];
             
             [imgMM sd_setImageWithURL:[NSURL URLWithString:minStr(model.participantProfileList[i])] placeholderImage:normal_placeHeadImg];
         }
        
        UIButton *clickBBB = [[UIButton alloc] initWithFrame:CGRectMake(64, 0, _window_width-76, 28)];
        [clickBBB addTarget:self action:@selector(clickBtnMethodPeopleList) forControlEvents:UIControlEventTouchUpInside];
        [self.fou_VVsub addSubview:clickBBB];
        
//        if([self.oneModel.type isEqualToString:@"VOTE"]) {
//            if([detailDci[@"voteInfo"] isKindOfClass:[NSDictionary class]]) {
//                NSDictionary *dciMM = detailDci[@"voteInfo"];
//                
//                if([dciMM[@"conditions"] isKindOfClass:[NSDictionary class]]) {
//                    
//                    NSDictionary *modelCont = dciMM[@"conditions"];
//                    NSArray *lis_arr = @[minStr(modelCont[@"location"]), minStr(modelCont[@"genderRange"]), minStr(modelCont[@"rolePreferenceRange"]), minStr(modelCont[@"ageRange"]), minStr(modelCont[@"genderPreferenceRange"]), minStr(dciMM[@"perLockoutPeriod"]), minStr(dciMM[@"deadline"])];
//                    for (int i=0; i<lis_arr.count; i++) {
//                        UILabel *al_lab2 = [self.fou_VV viewWithTag:7700+i];
//                        al_lab2.text = lis_arr[i];
//                    }
//                    
//                    UILabel *al_lab = [self.fou_VV viewWithTag:7805];
//                    al_lab.text = eLocalizedString(@"role_name33");
//                }
//                if([minStr(dciMM[@"voted"]) isEqualToString:@"true"]) {
//                    _loginBBtn.selected = YES;
//                    _loginBBtn.userInteractionEnabled = NO;
//                }
//            }
//        }else {
//            if([detailDci[@"seekingInfo"] isKindOfClass:[NSDictionary class]]) {
//                NSDictionary *dciMM = detailDci[@"seekingInfo"];
//                
//                if([dciMM[@"conditions"] isKindOfClass:[NSDictionary class]]) {
//                    
//                    NSDictionary *modelCont = dciMM[@"conditions"];
//                    NSArray *lis_arr = @[minStr(modelCont[@"location"]), minStr(modelCont[@"genderRange"]), minStr(modelCont[@"rolePreferenceRange"]), minStr(modelCont[@"ageRange"]), minStr(modelCont[@"genderPreferenceRange"]), minStr(dciMM[@"transferDays"]), minStr(dciMM[@"deadline"])];
//                    for (int i=0; i<lis_arr.count; i++) {
//                        UILabel *al_lab2 = [self.fou_VV viewWithTag:7700+i];
//                        al_lab2.text = lis_arr[i];
//                    }
//                }
//                if([minStr(dciMM[@"applied"]) isEqualToString:@"true"]) {
//                    _loginBBtn.selected = YES;
//                    _loginBBtn.userInteractionEnabled = NO;
//                }
//            }
//        }
        
        if([model.uid isEqualToString:[LYUserDefault userDefault].t_id]) {
            _loginBBtn.selected = YES;
            _loginBBtn.userInteractionEnabled = NO;
        }
    }
    
    if([model.uid isEqualToString:[LYUserDefault userDefault].t_id]) {
        self.focusBtn.hidden = YES;
        self.isBBBme = YES;
    }else {
        self.isBBBme = NO;
        self.focusBtn.hidden = NO;
    }
    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
    
    self.nameLabel.text = model.nickName;
    self.timeLabel.text = model.postTime;
    self.contentLabel.text = model.text;
    
    self.vipImg.hidden = !model.isTop;
    
    self.focusBtn.selected = model.isFollowed;
    if(model.isFollowed) {
        self.focusBtn.backgroundColor = UIColor.clearColor;
    }else {
        self.focusBtn.backgroundColor = normalPurpleColors;
    }
    
    [self.two_VV removeAllSubviews];
    
    NSArray *arLis = model.mediaUrlList;
    CGFloat maxHH = 150;
    CGFloat maxHWid = _window_width-64-12;
    if([model.mediaType isEqualToString:@"VIDEO"]) {
        
        NSString *imgsLL = model.videoCover;
        NSString *videUrl = @"";
        if(arLis.count > 0) {
            videUrl = arLis[0];
            
            UIImageView *contimg = [[UIImageView alloc] init];
            contimg.clipsToBounds = YES;
            contimg.contentMode = UIViewContentModeScaleAspectFill;
            contimg.backgroundColor = GrayText102;
            contimg.layer.cornerRadius = 8;
            [self.two_VV addSubview:contimg];
            [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.two_VV.mas_left).offset(64);
                make.top.equalTo(self.two_VV.mas_top).offset(4);
                make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
                make.width.height.offset(100);
            }];
            
            UIImageView *kLimg = [[UIImageView alloc] init];
            kLimg.clipsToBounds = YES;
            kLimg.contentMode = UIViewContentModeScaleAspectFill;
            kLimg.image = [UIImage imageNamed:@"topic_postTopic_video2"];
            [contimg addSubview:kLimg];
            [kLimg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(contimg);
                make.width.height.offset(30);
            }];
            
            UIButton *videBtnMMM = [[UIButton alloc] initWithFrame:CGRectMake(64, 4, 100, 100)];
            [videBtnMMM addTarget:self action:@selector(videBtnMethodMMOne) forControlEvents:UIControlEventTouchUpInside];
            [self.two_VV addSubview:videBtnMMM];
            
            [contimg sd_setImageWithURL:[NSURL URLWithString:imgsLL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image != nil) {
                    
                    CGFloat wx_y = image.size.height;
                    CGFloat wx_X = image.size.width;
                    if(wx_y > maxHH) {
                        wx_y = maxHH;
                        wx_X = (image.size.width * maxHH)/image.size.height;
                    }else {
                        if(wx_X > maxHWid) {
                            wx_X = maxHWid;
                            wx_y = (image.size.height * maxHWid)/image.size.width;
                        }
                    }
                    [contimg mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.offset(wx_y);
                        make.width.offset(wx_X);
                    }];
                    
                    [kLimg mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.center.equalTo(contimg);
                    }];
                    
                    videBtnMMM.frame = CGRectMake(64, 4, wx_X, wx_y);
                }
            }];
        }else {
            
            UIImageView *contimg = [[UIImageView alloc] init];
            contimg.clipsToBounds = YES;
            contimg.contentMode = UIViewContentModeScaleAspectFill;
            contimg.backgroundColor = GrayText102;
            contimg.layer.cornerRadius = 8;
            [self.two_VV addSubview:contimg];
            [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.two_VV.mas_left).offset(64);
                make.top.equalTo(self.two_VV.mas_top).offset(4);
                make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
                make.width.height.offset(100);
            }];
            

            UIImageView *kLimg = [[UIImageView alloc] init];
            kLimg.clipsToBounds = YES;
            kLimg.contentMode = UIViewContentModeScaleAspectFill;
            kLimg.image = [UIImage imageNamed:@"topic_postTopic_video2"];
            [contimg addSubview:kLimg];
            [kLimg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(contimg);
                make.width.height.offset(30);
            }];

            
            UIButton *videBtnMMM = [[UIButton alloc] initWithFrame:CGRectMake(64, 4, 100, 100)];
            [videBtnMMM addTarget:self action:@selector(videBtnMethodMMOne) forControlEvents:UIControlEventTouchUpInside];
            [self.two_VV addSubview:videBtnMMM];
        }
        
    }else if([model.mediaType isEqualToString:@"AUDIO"]) {
        
        UIButton *imgBtn = [HistoryRecordModel createImgBtn];
        imgBtn.backgroundColor = normalPurpleColors;
        imgBtn.layer.cornerRadius = 16;
        [imgBtn addTarget:self action:@selector(voiceMMMMMM:) forControlEvents:UIControlEventTouchUpInside];
        [self.two_VV addSubview:imgBtn];
        [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.two_VV.mas_left).offset(64);
            make.top.equalTo(self.two_VV.mas_top).offset(4);
            make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
            make.height.offset(32);
            make.width.offset(174);
        }];
        
        UIImageView *logPlayImgv = [HistoryRecordModel createImgImgView];
        logPlayImgv.frame = CGRectMake(10, 5, 22, 22);
        logPlayImgv.image = [UIImage imageNamed:@"playVoice_img"];
        logPlayImgv.tag = 8300;
        [imgBtn addSubview:logPlayImgv];
        
        UIImageView *logPlayImgv2 = [HistoryRecordModel createImgImgView];
        logPlayImgv2.frame = CGRectMake(44, 6, 66, 20);
        logPlayImgv2.image = [UIImage imageNamed:@"playVoice_img2"];
        [imgBtn addSubview:logPlayImgv2];
        
        UILabel *duration = [[UILabel alloc] initWithFrame:CGRectMake(110, 3, 52, 26)];
        duration.textAlignment = NSTextAlignmentRight;
        duration.font = [UIFont systemFontOfSize:10];
        duration.textColor = [UIColor blackColor];
        [imgBtn addSubview:duration];
        duration.text = [NSString stringWithFormat:@"%@", [HistoryRecordModel secondToHourMinutesSecond:model.audioDuration]];
        
        //旧样式
//        UIButton *imgBtn = [[UIButton alloc] init];
//        imgBtn.backgroundColor = normalColors;
//        [self.two_VV addSubview:imgBtn];
//        [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.two_VV.mas_left).offset(64);
//            make.top.equalTo(self.two_VV.mas_top).offset(4);
//            make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
//            make.height.offset(36);
//            make.width.offset(100);
//        }];
//
//        UIImageView *voice = [[UIImageView alloc] initWithFrame:CGRectMake(100-40, 3, 30, 30)];
//        voice.animationDuration = 1;
//        [imgBtn addSubview:voice];
//
//        UILabel *duration = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 100-45, 30)];
//        duration.textAlignment = NSTextAlignmentRight;
//        duration.font = [UIFont systemFontOfSize:10];
//        duration.textColor = [UIColor blackColor];
//        [imgBtn addSubview:duration];
//        duration.text = [NSString stringWithFormat:@"%@", [HistoryRecordModel secondToHourMinutesSecond:model.audioDuration]];
//
//        voice.image = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_normal")];
//
        
//        if(model.mediaUrlList.count > 0) {
//            NSString *url_str = model.mediaUrlList[0];
//            NSURL *URL = [NSURL URLWithString:url_str];
//            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//            //AFN3.0+基于封住URLSession的句柄
//            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//            //请求
//            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//            //下载Task操作
//            NSURLSessionDownloadTask *_downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//                //进度
//            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//
//                NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//                NSString *path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", model.uid, model.activityId]];
//                return [NSURL fileURLWithPath:path];
//
//            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//                // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
//                if(filePath != nil) {
//                    NSString *armFilePath = [filePath path];// 将NSURL转成NSString
//                    self.pathOne = armFilePath;
//                    [self.two_VV removeAllSubviews];
//                    NSURL *url = [NSURL fileURLWithPath:self.pathOne];
//                    AVAudioPlayer *oPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//
//                    CGFloat w_max = 80+oPlayer.duration;
//                    if(w_max>240) {
//                        w_max = 240;
//                    }
//                    UIButton *imgBtn = [HistoryRecordModel createImgBtn];
//                    imgBtn.frame = CGRectMake(0, 26, w_max, 40);
//                    imgBtn.backgroundColor = normalColors;
//                    imgBtn.layer.cornerRadius = 5;
//                    [imgBtn addTarget:self action:@selector(voiceMMMMMM) forControlEvents:UIControlEventTouchUpInside];
//                    [self.two_VV addSubview:imgBtn];
//                    [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.left.equalTo(self.two_VV.mas_left).offset(64);
//                        make.top.equalTo(self.two_VV.mas_top).offset(4);
//                        make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
//                        make.height.offset(36);
//                        make.width.offset(w_max);
//                    }];
//
//                    [self.voice removeFromSuperview];
//                    self.voice = nil;
//                    [self.duration removeFromSuperview];
//                    self.duration = nil;
//
//                    self.voice = [[UIImageView alloc] initWithFrame:CGRectMake(imgBtn.width-40, 5, 30, 30)];
//                    self.voice.animationDuration = 1;
//                    [imgBtn addSubview:self.voice];
//
//                    self.duration = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, imgBtn.width-45, 30)];
//                    self.duration.textAlignment = NSTextAlignmentRight;
//                    self.duration.font = [UIFont systemFontOfSize:10];
//                    self.duration.textColor = [UIColor whiteColor];
//                    [imgBtn addSubview:self.duration];
//
//                    self.duration.text = [NSString stringWithFormat:@"%@", [HistoryRecordModel secondToHourMinutesSecond:(int)oPlayer.duration]];
//
//                    self.voice.image = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_normal")];
//                    self.voice.animationImages = [NSArray arrayWithObjects:
//                                              [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_playing_1")],
//                                              [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_playing_2")],
//                                              [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_playing_3")], nil];
//                }
//
//            }];
//            [_downloadTask resume];
//        }
        
    }else {
        
        switch (model.mediaUrlList.count) {
            case 1:
            {
                NSString *imgsLL = model.mediaUrlList[0];
                
                UIImageView *contimg = [[UIImageView alloc] init];
                contimg.clipsToBounds = YES;
                contimg.contentMode = UIViewContentModeScaleAspectFill;
                contimg.backgroundColor = GrayText102;
                contimg.layer.cornerRadius = 8;
                [self.two_VV addSubview:contimg];
                [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.two_VV.mas_left).offset(64);
                    make.top.equalTo(self.two_VV.mas_top).offset(4);
                    make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
                    make.width.height.offset(100);
                }];
                
                UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64, 4, 100, 100)];
                selbtn.tag = 39000;
                [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                [self.two_VV addSubview:selbtn];
                
                [contimg sd_setImageWithURL:[NSURL URLWithString:imgsLL] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if(image != nil) {
                        
                        CGFloat wx_y = image.size.height;
                        CGFloat wx_X = image.size.width;
                        if(wx_y > maxHH) {
                            wx_y = maxHH;
                            wx_X = (image.size.width * maxHH)/image.size.height;
                        }else {
                            if(wx_X > maxHWid) {
                                wx_X = maxHWid;
                                wx_y = (image.size.height * maxHWid)/image.size.width;
                            }
                        }
                        [contimg mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.offset(wx_y);
                            make.width.offset(wx_X);
                        }];
                        selbtn.frame = CGRectMake(64, 4, wx_X, wx_y);
                    }
                }];
            }
                break;
            case 2:
            {
                CGFloat w_xxx = (_window_width-74-12)/2;
                for (int i=0; i<model.mediaUrlList.count; i++) {
                    
                    NSString *url_str = model.mediaUrlList[i];
                    
                    UIImageView *contimg = [[UIImageView alloc] init];
                    contimg.clipsToBounds = YES;
                    contimg.contentMode = UIViewContentModeScaleAspectFill;
                    contimg.backgroundColor = GrayText102;
                    contimg.layer.cornerRadius = 8;
                    [self.two_VV addSubview:contimg];
                    [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.two_VV.mas_left).offset(64+i*(w_xxx+10));
                        make.top.equalTo(self.two_VV.mas_top).offset(4);
                        make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
                        make.height.offset(134);
                        make.width.offset(w_xxx);
                    }];
                    
                    [contimg sd_setImageWithURL:[NSURL URLWithString:url_str]];
                    
                    UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64+i*(w_xxx+10), 4, w_xxx, 134)];
                    selbtn.tag = 39000+i;
                    [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                    [self.two_VV addSubview:selbtn];
                }
            }
                break;
            case 3:
            {
                CGFloat w_xxx = (_window_width-64-30-12)/3;
                for (int i=0; i<model.mediaUrlList.count; i++) {
                    
                    NSString *url_str = model.mediaUrlList[i];
                    
                    UIImageView *contimg = [[UIImageView alloc] init];
                    contimg.clipsToBounds = YES;
                    contimg.contentMode = UIViewContentModeScaleAspectFill;
                    contimg.backgroundColor = GrayText102;
                    contimg.layer.cornerRadius = 8;
                    [self.two_VV addSubview:contimg];
                    [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.two_VV.mas_left).offset(64+i*(w_xxx+10));
                        make.top.equalTo(self.two_VV.mas_top).offset(4);
                        make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
                        make.height.offset(80);
                        make.width.offset(w_xxx);
                    }];
                    
                    [contimg sd_setImageWithURL:[NSURL URLWithString:url_str]];
                    
                    UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64+i*(w_xxx+10), 4, w_xxx, 80)];
                    selbtn.tag = 39000+i;
                    [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                    [self.two_VV addSubview:selbtn];
                }
            }
                break;
            case 4:
            {

                for (int i=0; i<model.mediaUrlList.count; i++) {
                    
                    NSString *url_str = model.mediaUrlList[i];
                    
                    UIImageView *contimg = [[UIImageView alloc] init];
                    contimg.clipsToBounds = YES;
                    contimg.contentMode = UIViewContentModeScaleAspectFill;
                    contimg.backgroundColor = GrayText102;
                    contimg.layer.cornerRadius = 8;
                    [self.two_VV addSubview:contimg];
                    if(i>1) {
                        [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.two_VV.mas_left).offset(64+(i-2)*88);
                            make.top.equalTo(self.two_VV.mas_top).offset(4+88);
                            make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
                            make.width.height.offset(80);
                        }];
                        
                        UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64+i*88, 4+88, 80, 80)];
                        selbtn.tag = 39000+i;
                        [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                        [self.two_VV addSubview:selbtn];
                    }else {
                        [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.two_VV.mas_left).offset(64+i*88);
                            make.top.equalTo(self.two_VV.mas_top).offset(8);
                            make.width.height.offset(80);
                        }];
                        UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64+i*88, 4, 80, 80)];
                        selbtn.tag = 39000+i;
                        [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                        [self.two_VV addSubview:selbtn];
                    }
                    [contimg sd_setImageWithURL:[NSURL URLWithString:url_str]];
                    
                }
            }
                break;
            case 5:
            {
                CGFloat w_xxx = (_window_width-64-8-12)/2;
                for (int i=0; i<model.mediaUrlList.count; i++) {
                    
                    NSString *url_str = model.mediaUrlList[i];
                    
                    UIImageView *contimg = [[UIImageView alloc] init];
                    contimg.clipsToBounds = YES;
                    contimg.contentMode = UIViewContentModeScaleAspectFill;
                    contimg.backgroundColor = GrayText102;
                    contimg.layer.cornerRadius = 8;
                    [self.two_VV addSubview:contimg];
                    if(i==0) {
                        
                        [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.two_VV.mas_left).offset(64);
                            make.top.equalTo(self.two_VV.mas_top).offset(4);
                            make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
                            make.width.height.offset(w_xxx);
                        }];
                        
                        UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64, 4, w_xxx, w_xxx)];
                        selbtn.tag = 39000+i;
                        [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                        [self.two_VV addSubview:selbtn];
                    }else {
                        CGFloat w_xTwo = (w_xxx-8)/2;
                        if(i>2) {
                            [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.left.equalTo(self.two_VV.mas_left).offset(64+w_xxx+8+(i-3)*(w_xTwo+8));
                                make.top.equalTo(self.two_VV.mas_top).offset(4+w_xTwo+8);
                                make.width.height.offset(w_xTwo);
                            }];
                            
                            UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64+w_xxx+8+(i-3)*(w_xTwo+8), 4+w_xTwo+8, w_xTwo, w_xTwo)];
                            selbtn.tag = 39000+i;
                            [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                            [self.two_VV addSubview:selbtn];
                        }else {
                            [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                                make.left.equalTo(self.two_VV.mas_left).offset(64+w_xxx+8+(i-1)*(w_xTwo+8));
                                make.top.equalTo(self.two_VV.mas_top).offset(4);
                                make.width.height.offset(w_xTwo);
                            }];
                            
                            UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64+w_xxx+8+(i-1)*(w_xTwo+8), 4, w_xTwo, w_xTwo)];
                            selbtn.tag = 39000+i;
                            [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                            [self.two_VV addSubview:selbtn];
                        }
                    }
                    [contimg sd_setImageWithURL:[NSURL URLWithString:url_str]];
                }
            }
                break;
            case 6:
            {
                CGFloat w_xxx = (_window_width-64-16-12)/3;
                for (int i=0; i<model.mediaUrlList.count; i++) {
                    
                    NSString *url_str = model.mediaUrlList[i];
                    
                    UIImageView *contimg = [[UIImageView alloc] init];
                    contimg.clipsToBounds = YES;
                    contimg.contentMode = UIViewContentModeScaleAspectFill;
                    contimg.backgroundColor = GrayText102;
                    contimg.layer.cornerRadius = 8;
                    [self.two_VV addSubview:contimg];
                    
                    if(i>2) {
                        [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.two_VV.mas_left).offset(64+(i-3)*(w_xxx+8));
                            make.top.equalTo(self.two_VV.mas_top).offset(4+w_xxx+8);
                            make.bottom.equalTo(self.two_VV.mas_bottom).offset(-4);
                            make.width.height.offset(w_xxx);
                        }];
                        
                        UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64+(i-3)*(w_xxx+8), 4+w_xxx+8, w_xxx, w_xxx)];
                        selbtn.tag = 39000+i;
                        [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                        [self.two_VV addSubview:selbtn];
                    }else {
                        [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.equalTo(self.two_VV.mas_left).offset(64+i*(w_xxx+8));
                            make.top.equalTo(self.two_VV.mas_top).offset(4);
                            make.width.height.offset(w_xxx);
                        }];
                        
                        UIButton *selbtn = [[UIButton alloc] initWithFrame:CGRectMake(64+i*(w_xxx+8), 4, w_xxx, w_xxx)];
                        selbtn.tag = 39000+i;
                        [selbtn addTarget:self action:@selector(imgsBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                        [self.two_VV addSubview:selbtn];
                    }
                    [contimg sd_setImageWithURL:[NSURL URLWithString:url_str]];
                }
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)videBtnMethodMMOne
{
    NSArray *fileArr = self.oneModel.mediaUrlList;
    if (fileArr.count > 0) {
        NSString *video_st = fileArr[0];
        if ([self.delegate_ respondsToSelector:@selector(fileClick:row:indexPath:)]) {
            [self.delegate_ fileClick:@[video_st] row:39000 indexPath:self.indexp];
        }
    }
}

- (void)imgsBtnMethodMMOne:(UIButton *)btn
{
    if ([self.delegate_ respondsToSelector:@selector(fileClick:row:indexPath:)]) {
        [self.delegate_ fileClick:self.oneModel.mediaUrlList row:btn.tag-39000 indexPath:self.indexp];
    }
}

//MARK: 关注 或 删除
- (void)focusBtnClick:(UIButton *)btn
{
    if ([self.delegate_ respondsToSelector:@selector(focusOrGoodOrComment:indexPath:)]) {
        [self.delegate_ focusOrGoodOrComment:1 indexPath:self.indexp];
    }
}

//MARK: 播放语音
- (void)voiceMMMMMM:(UIButton *)btnVoic
{
    if(self.oneModel.mediaUrlList.count > 0) {
        
        if(self.isPPlayb) {
            return;
        }
        self.isPPlayb = YES;
        
        btnVoic.selected = !btnVoic.selected;
        
        UIImageView *logPlayImgv = [btnVoic viewWithTag:8300];
        if(!btnVoic.selected) {
            logPlayImgv.image = [UIImage imageNamed:@"playVoice_img"];
            [self stopVoiceMessage];
        }else {
            
            logPlayImgv.image = [UIImage imageNamed:@"playVoice_imgsel"];
            
            NSString *url_str = self.oneModel.mediaUrlList[0];
            NSURL *URL = [NSURL URLWithString:url_str];
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            //AFN3.0+基于封住URLSession的句柄
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
            //请求
            NSURLRequest *request = [NSURLRequest requestWithURL:URL];
            //下载Task操作
            NSURLSessionDownloadTask *_downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                //进度
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                
                NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                
                if(self.oneModel.activityId) {
                    NSString *path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", self.oneModel.uid, self.oneModel.activityId]];
                    return [NSURL fileURLWithPath:path];
                }else {
                    NSString *path = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@-%@", self.oneModel.uid, self.oneModel.recordId]];
                    return [NSURL fileURLWithPath:path];
                }
                
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
                if(filePath != nil) {
                    NSString *armFilePath = [filePath path];// 将NSURL转成NSString
                    self.pathOne = armFilePath;
                    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
                    NSURL *url = [NSURL fileURLWithPath:self.pathOne];
                    
                    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                    self.audioPlayer.delegate = self;
                    bool result = [self.audioPlayer play];
                    if (!result) {
                        self.wavPath = [[self.pathOne stringByDeletingPathExtension] stringByAppendingString:@".wav"];
                        NSURL *url = [NSURL fileURLWithPath:self.wavPath];
                        [self.audioPlayer stop];
                        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                        self.audioPlayer.delegate = self;
                        [self.audioPlayer play];
                    }
                }else {
                    self.isPPlayb = NO;
                }
            }];
            [_downloadTask resume];
        }
        
    }
    
    
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//    NSURL *url = [NSURL fileURLWithPath:self.pathOne];
//
//    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//    self.audioPlayer.delegate = self;
//    bool result = [self.audioPlayer play];
//    if (!result) {
//        self.wavPath = [[self.pathOne stringByDeletingPathExtension] stringByAppendingString:@".wav"];
//        NSURL *url = [NSURL fileURLWithPath:self.wavPath];
//        [self.audioPlayer stop];
//        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
//        self.audioPlayer.delegate = self;
//        [self.audioPlayer play];
//    }
//    [self.voice startAnimating];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
{
    self.isPPlayb = NO;
//    [self.voice stopAnimating];
    [[NSFileManager defaultManager] removeItemAtPath:self.wavPath error:nil];
    [self stopVoiceMessage];
}

- (void)stopVoiceMessage
{
    self.isPPlayb = NO;
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
        self.audioPlayer = nil;
    }
}

@end
