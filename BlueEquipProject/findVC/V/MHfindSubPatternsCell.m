//
//  MHfindSubPatternsCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2023/11/3.
//

#import "MHfindSubPatternsCell.h"
#import "TUIDefine.h"
#import <AFNetworking/AFNetworking.h>

@interface MHfindSubPatternsCell ()<AVAudioPlayerDelegate>

@property (nonatomic, strong) UIView *one_VV;
@property (nonatomic, strong) UIView *two_VV;
@property (nonatomic, strong) UIView *thr_VV;
@property (nonatomic, strong) UIView *fou_VV;

@property (nonatomic,strong) UIImageView *headImg;
@property (nonatomic,strong) UIImageView *vipImg;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *focusBtn;
@property (nonatomic,strong) UIButton *deetetBtn;
@property (nonatomic,strong) UILabel *showTypLab;
@property (nonatomic,strong) UILabel *showBtn;

@property (nonatomic,strong) UIButton *oneBtn;
@property (nonatomic,strong) UIButton *twoBtn;
@property (nonatomic,strong) UIButton *thrBtn;
@property (nonatomic,strong) UILabel *oneBtnLab;
@property (nonatomic,strong) UILabel *twoBtnLab;
@property (nonatomic,strong) UILabel *thrBtnLab;
@property (nonatomic,strong) UIImageView *thrBImg;

@property (nonatomic,strong) NSIndexPath *indexp;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic, assign) BOOL isBBBme;
@property (nonatomic, strong) MHfindSubPatternsModel *oneModel;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, copy) NSString *wavPath;

@property (nonatomic, strong) UIImage *voiceImage;
@property (nonatomic, strong) NSArray *voiceAnimationImages;
@property (nonatomic, strong) UIImageView *voice;
@property (nonatomic, strong) UILabel *duration;
@property (nonatomic, copy) NSString *pathOne;
@property (nonatomic, assign) BOOL isPPlayb;
@end

@implementation MHfindSubPatternsCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHfindSubPatternsCell";
    MHfindSubPatternsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHfindSubPatternsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHfindSubPatternsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.one_VV = [[UIView alloc] init];
        self.one_VV.backgroundColor = RGB(1, 0, 2);
        [self.contentView addSubview:self.one_VV];
        [self.one_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
        }];
        
        self.two_VV = [[UIView alloc] init];
        self.two_VV.backgroundColor = RGB(1, 0, 2);
        [self.contentView addSubview:self.two_VV];
        [self.two_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.one_VV.mas_bottom);
            make.left.right.equalTo(self.contentView);
        }];
        
        self.fou_VV = [[UIView alloc] init];
        self.fou_VV.backgroundColor = RGB(1, 0, 2);
        [self.contentView addSubview:self.fou_VV];
        [self.fou_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.two_VV.mas_bottom);
            make.left.right.equalTo(self.contentView);
        }];
        
        self.thr_VV = [[UIView alloc] init];
        self.thr_VV.backgroundColor = RGB(1, 0, 2);
        [self.contentView addSubview:self.thr_VV];
        [self.thr_VV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fou_VV.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.height.offset(30);
            make.bottom.equalTo(self.contentView);
        }];
        
        self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 42, 42)];
        self.headImg.layer.cornerRadius = 21;
        self.headImg.layer.masksToBounds = true;
        [self.one_VV addSubview:self.headImg];
        [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.one_VV).offset(12);
            make.width.height.offset(42);
        }];
        self.headImg.image = normal_placeHeadImg;
        
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = SYS_Font(14);
        self.nameLabel.text = @"";
        self.nameLabel.textColor = UIColor.whiteColor;
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
        self.timeLabel.textColor = UIColor.whiteColor;
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
            make.width.mas_greaterThanOrEqualTo(54);
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

        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.font = SYS_Font(14);
        self.contentLabel.text = @"";
        self.contentLabel.numberOfLines = 0;
        [self.one_VV addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_left);
            make.top.equalTo(self.headImg.mas_bottom).offset(9);
            make.right.equalTo(self.one_VV.mas_right).offset(-12);
            make.bottom.equalTo(self.one_VV.mas_bottom).offset(-9);
        }];
        
        self.oneBtn = [[UIButton alloc] init];
        [self.thr_VV addSubview:self.oneBtn];
        [self.oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.thr_VV.mas_left).offset(64);
            make.bottom.top.equalTo(self.thr_VV);
            make.width.mas_greaterThanOrEqualTo(43);
        }];
        
        UIImageView *imeMM = [HistoryRecordModel createImgImgView];
        imeMM.image = [UIImage imageNamed:@"plaza_imgs9"];
        [self.oneBtn addSubview:imeMM];
        [imeMM mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.oneBtn.mas_left);
            make.centerY.equalTo(self.oneBtn.mas_centerY);
            make.width.height.offset(12);
        }];
        
        self.oneBtnLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        self.oneBtnLab.text = @"0";
        [self.oneBtn addSubview:self.oneBtnLab];
        [self.oneBtnLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imeMM.mas_right).offset(2);
            make.centerY.equalTo(self.oneBtn.mas_centerY);
            make.right.equalTo(self.oneBtn.mas_right);
        }];
        
        self.twoBtn = [[UIButton alloc] init];
        [self.twoBtn addTarget:self action:@selector(botmBtnTypeMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.thr_VV addSubview:self.twoBtn];
        [self.twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.thr_VV.mas_centerY);
            make.centerX.equalTo(self.thr_VV.mas_centerX).offset(32);
            make.bottom.top.equalTo(self.thr_VV);
            make.width.mas_greaterThanOrEqualTo(43);
        }];
        
        UIImageView *imeMM2 = [HistoryRecordModel createImgImgView];
        imeMM2.image = [UIImage imageNamed:@"plaza_imgs10"];
        [self.twoBtn addSubview:imeMM2];
        [imeMM2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.twoBtn.mas_left);
            make.centerY.equalTo(self.twoBtn.mas_centerY);
            make.width.height.offset(12);
        }];
        
        self.twoBtnLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        self.twoBtnLab.text = @"0";
        [self.twoBtn addSubview:self.twoBtnLab];
        [self.twoBtnLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imeMM2.mas_right).offset(2);
            make.centerY.equalTo(self.twoBtn.mas_centerY);
            make.right.equalTo(self.twoBtn.mas_right);
        }];
        
        self.thrBtn = [[UIButton alloc] init];
        [self.thrBtn addTarget:self action:@selector(botmBtnTypeMethod:) forControlEvents:UIControlEventTouchUpInside];
        [self.thr_VV addSubview:self.thrBtn];
        [self.thrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.thr_VV.mas_right).offset(-12);
            make.bottom.top.equalTo(self.thr_VV);
            make.width.mas_greaterThanOrEqualTo(43);
        }];
        
        self.thrBImg = [HistoryRecordModel createImgImgView];
        self.thrBImg.image = [UIImage imageNamed:@"plaza_imgs11"];
        [self.thrBtn addSubview:self.thrBImg];
        [self.thrBImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.thrBtn.mas_left);
            make.centerY.equalTo(self.thrBtn.mas_centerY);
            make.width.height.offset(12);
        }];
        
        self.thrBtnLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentLeft];
        self.thrBtnLab.text = @"0";
        [self.thrBtn addSubview:self.thrBtnLab];
        [self.thrBtnLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.thrBImg.mas_right).offset(2);
            make.centerY.equalTo(self.thrBtn.mas_centerY);
            make.right.equalTo(self.thrBtn.mas_right);
        }];
     }
    return self;
}

- (void)deleeeeBtnClick
{
    if ([self.delegate_ respondsToSelector:@selector(focusOrGoodOrComment:indexPath:)]) {
        [self.delegate_ focusOrGoodOrComment:4 indexPath:self.indexp];
    }
}

//我的动态
- (void)addDataToMeDic:(MHfindSubPatternsModel *)model row:(NSIndexPath *)rowL typMethod:(NSInteger)typM
{
    self.indexp = rowL;
    self.oneModel = model;
    self.isBBBme = YES;
    self.isPPlayb = NO;
    if(typM == 1) {
        
        self.focusBtn.hidden = NO;
        if([model.type isEqualToString:@"SEEKING"]) {
            [self.focusBtn setTitle:eLocalizedString(@"me_allNames13") forState:UIControlStateNormal];
        }else {
            [self.focusBtn setTitle:eLocalizedString(@"me_allNames14") forState:UIControlStateNormal];
        }
        self.focusBtn.userInteractionEnabled = NO;
        
        [self.thr_VV removeAllSubviews];
        
        UIImageView *bHeadImgV = [[UIImageView alloc] initWithFrame:CGRectMake(64, 2, _window_width-76, 28)];
        bHeadImgV.image = [UIImage imageNamed:@"plaza_imgs12"];
        [self.thr_VV addSubview:bHeadImgV];
        
        UIImageView *sexyImV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0, 28, 28)];
        sexyImV.clipsToBounds = YES;
        sexyImV.image = [UIImage imageNamed:@"plaza_imgs6"];
        [bHeadImgV addSubview:sexyImV];
        
        UIImageView *nexImgv = [HistoryRecordModel createImgImgView];
        nexImgv.frame = CGRectMake(bHeadImgV.width-22, 7, 14, 14);
        nexImgv.image = [UIImage imageNamed:@"home_next2"];
        [bHeadImgV addSubview:nexImgv];
        
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
        
    }else {
        self.focusBtn.hidden = YES;
        if([model.auditStatus isEqualToString:@"APPROVED"]) {
            if([model.uid isEqualToString:[LYUserDefault userDefault].t_id]) {
                self.deetetBtn.hidden = NO;
            }else {
                self.deetetBtn.hidden = YES;
            }
            
            self.showTypLab.hidden = YES;
        }else {
            self.deetetBtn.hidden = YES;
            self.showTypLab.hidden = NO;
            if([model.auditStatus isEqualToString:@"PENDING"]) {
                self.showTypLab.text = eLocalizedString(@"me_allNames10");
            }else {
                self.showTypLab.text = eLocalizedString(@"me_allNames11");
            }
        }
    }
    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
    
    self.nameLabel.text = model.nickName;
    self.timeLabel.text = model.postTime;
    self.contentLabel.text = model.text;
    
    self.vipImg.hidden = !model.isTop;
    
    self.oneBtnLab.text = minIntStr(model.viewCount);
    self.twoBtnLab.text = minIntStr(model.commentCount);
    self.thrBtnLab.text = minIntStr(model.likeCount);
    
    
    
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
                    
//                    CGFloat wx_y = image.size.height;
//                    CGFloat wx_X = image.size.width;
//                    if(wx_y > maxHH) {
//                        wx_y = maxHH;
//                        wx_X = (image.size.width * maxHH)/image.size.height;
//                    }else {
//                        if(wx_X > maxHWid) {
//                            wx_X = maxHWid;
//                            wx_y = (image.size.height * maxHWid)/image.size.width;
//                        }
//                    }
//                    [contimg mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.height.offset(wx_y);
//                        make.width.offset(wx_X);
//                    }];
//
//                    [kLimg mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.center.equalTo(contimg);
//                    }];
//
//                    videBtnMMM.frame = CGRectMake(64, 4, wx_X, wx_y);
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
        imgBtn.tag = 8400;
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
        duration.textColor = [UIColor whiteColor];
        [imgBtn addSubview:duration];
        duration.text = [NSString stringWithFormat:@"%@", [HistoryRecordModel secondToHourMinutesSecond:model.audioDuration]];
        
//        UIButton *imgBtn = [[UIButton alloc] init];
//        imgBtn.backgroundColor = normalColors;
//        imgBtn.layer.cornerRadius = 5;
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
//        duration.textColor = [UIColor whiteColor];
//        [imgBtn addSubview:duration];
//        duration.text = [NSString stringWithFormat:@"%@", [HistoryRecordModel secondToHourMinutesSecond:model.audioDuration]];
//
//        voice.image = [[TUIImageCache sharedInstance] getResourceFromCache:TUIChatImagePath(@"message_voice_receiver_normal")];
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
//
//                NSLog(@"--下载音乐长度--%lld", response.expectedContentLength);
//                NSString *armFilePath = [filePath path];// 将NSURL转成NSString
//
//                if(armFilePath) {
//                    self.pathOne = armFilePath;
//                    [self.two_VV removeAllSubviews];
//
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

- (void)addDataToDic:(MHfindSubPatternsModel *)model row:(NSIndexPath *)rowL
{
    self.indexp = rowL;
    self.oneModel = model;
    self.isPPlayb = NO;
    
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
    
    self.oneBtnLab.text = minIntStr(model.viewCount);
    self.twoBtnLab.text = minIntStr(model.commentCount);
    self.thrBtnLab.text = minIntStr(model.likeCount);
    
    if(model.isLikes) {
        self.thrBtnLab.textColor = normalPurpleColors;
        self.thrBImg.image = [UIImage imageNamed:@"plaza_imgs11_sel"];
    }else {
        self.thrBtnLab.textColor = UIColor.whiteColor;
        self.thrBImg.image = [UIImage imageNamed:@"plaza_imgs11"];
    }
    
    [self.two_VV removeAllSubviews];
    
    NSArray *arLis = model.mediaUrlList;
    CGFloat maxHH = 150;
    
    CGFloat maxHWid = _window_width-64-12;
    
    if([model.mediaType isEqualToString:@"VIDEO"]) {
        
        NSString *imgsLL = model.videoCover;
        NSString *videUrl = @"";
        if(arLis.count>0) {

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
                    
//                    CGFloat wx_y = image.size.height;
//                    CGFloat wx_X = image.size.width;
//                    if(wx_y > maxHH) {
//                        wx_y = maxHH;
//                        wx_X = (image.size.width * maxHH)/image.size.height;
//                    }else {
//                        if(wx_X > maxHWid) {
//                            wx_X = maxHWid;
//                            wx_y = (image.size.height * maxHWid)/image.size.width;
//                        }
//                    }
//                    [contimg mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.height.offset(wx_y);
//                        make.width.offset(wx_X);
//                    }];
//
//                    [kLimg mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.center.equalTo(contimg);
//                    }];
//
//                    videBtnMMM.frame = CGRectMake(64, 4, wx_X, wx_y);
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
        imgBtn.tag = 8400;
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
        duration.textColor = [UIColor whiteColor];
        [imgBtn addSubview:duration];
        duration.text = [NSString stringWithFormat:@"%@", [HistoryRecordModel secondToHourMinutesSecond:model.audioDuration]];
        
//        UIButton *imgBtn = [[UIButton alloc] init];
//        imgBtn.backgroundColor = UIColor.whiteColor;
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

//MARK: 留言、点赞
- (void)botmBtnTypeMethod:(UIButton *)btn
{
    if (btn == self.twoBtn) {
        if ([self.delegate_ respondsToSelector:@selector(focusOrGoodOrComment:indexPath:)]) {
            [self.delegate_ focusOrGoodOrComment:3 indexPath:self.indexp];
        }
    }else {
        if(!self.isBBBme) { //点赞
            if ([self.delegate_ respondsToSelector:@selector(focusOrGoodOrComment:indexPath:)]) {
                [self.delegate_ focusOrGoodOrComment:2 indexPath:self.indexp];
            }
        }
    }
}

//MARK: 播放语音
- (void)voiceMMMMMM:(UIButton *)btnVoic
{
    if(self.oneModel.mediaUrlList.count > 0) {
        
//        if(self.isPPlayb) {
//            return;
//        }
//        self.isPPlayb = YES;
        
        btnVoic.selected = !btnVoic.selected;

        UIImageView *logPlayImgv = [btnVoic viewWithTag:8300];
        if(!btnVoic.selected) {
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
                        
                        logPlayImgv.image = [UIImage imageNamed:@"playVoice_imgsel"];
                    }else {
                        logPlayImgv.image = [UIImage imageNamed:@"playVoice_imgsel"];
                    }
                }else {
                    
                    [self stopVoiceMessage];
                }
            }];
            [_downloadTask resume];
        }
    }else {
        [self stopVoiceMessage];
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
    [[NSFileManager defaultManager] removeItemAtPath:self.wavPath error:nil];
    [self stopVoiceMessage];
}

- (void)stopVoiceMessage
{
    UIImageView *logPlayImgv = [self.two_VV viewWithTag:8300];
    logPlayImgv.image = [UIImage imageNamed:@"playVoice_img"];
    UIButton *imgBtn = [self.two_VV viewWithTag:8400];
    imgBtn.selected = NO;
    
    self.isPPlayb = NO;
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
        self.audioPlayer = nil;
    }
}

//MARK: 获取视频封面
//- (void)getThumbnailImage:(NSURL *)videoURL {
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
//        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
//
//        AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//
//        generator.appliesPreferredTrackTransform = YES;
//
//        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
//
//        NSError *error = nil;
//
//        CMTime actualTime;
//
//        CGImageRef imageRef = [generator copyCGImageAtTime:time actualTime:&actualTime error:&error];
//
//        UIImage *thumb = [[UIImage alloc] initWithCGImage:imageRef];
//
//        CGImageRelease(imageRef);
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.videoView addUIUIImage:thumb];
//        });
//    });
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
