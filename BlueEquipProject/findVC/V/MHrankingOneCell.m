//
//  MHrankingOneCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/12.
//

#import "MHrankingOneCell.h"
#import "MHrankingUserModel.h"
#import "MHOthrMyController.h"

@interface MHrankingOneCell ()

@property (nonatomic, strong) NSArray *arrL;
@end

@implementation MHrankingOneCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHrankingOneCell";
    MHrankingOneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHrankingOneCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHrankingOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        
        UIView *oneVVV = [[UIView alloc] init];
        oneVVV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:oneVVV];
        [oneVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView);
            make.height.offset(470);
        }];
        
        UIImageView *oneImaVV = [HistoryRecordModel createImgImgView];
        oneImaVV.frame = CGRectMake(0, 0, _window_width, 470);
        oneImaVV.image = [UIImage imageNamed:@"rankingBackImg2"];
        [oneVVV addSubview:oneImaVV];
        
        CGFloat w_ww = (_window_width-88*3-32)/2;
        for (int i=0; i<3; i++) {
            
            UIView *thrVV = [[UIView alloc] initWithFrame:CGRectMake(w_ww+104*i, 146, 88, 470-262)];
            thrVV.backgroundColor = UIColor.clearColor;
            [oneVVV addSubview:thrVV];
            
            UIImageView *headIM = [HistoryRecordModel createImgImgView];
            headIM.image = normal_placeHeadImg;
            headIM.tag = 7300+i;
            [thrVV addSubview:headIM];
            
            UIImageView *placV = [[UIImageView alloc] init];
            placV.image = [UIImage imageNamed:@"rankingBackImg4"];
            [headIM addSubview:placV];
            
            UILabel *nickMML = [HistoryRecordModel createLabLabTextColor:UIColor.blackColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
            nickMML.text = eLocalizedString(@"me_allNames3");
            nickMML.tag = 7400+i;
            [thrVV addSubview:nickMML];
            
            UIView *blackV = [[UIView alloc] init];
            blackV.backgroundColor = UIColor.blackColor;
            blackV.clipsToBounds = YES;
            blackV.layer.cornerRadius = 10;
            [thrVV addSubview:blackV];
            
            UILabel *timLLl = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
            timLLl.tag = 7500+i;
            [blackV addSubview:timLLl];
            
            UIImageView *imgLoc = [HistoryRecordModel createImgImgView];
            imgLoc.image = [UIImage imageNamed:@"lockImgs1"];
            imgLoc.tag = 7700+i;
            [blackV addSubview:imgLoc];
            
            if(i==0) {
                
                blackV.frame = CGRectMake(0, thrVV.height-61+26, 88, 20);
                [timLLl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(blackV);
                    make.centerX.equalTo(blackV.mas_centerX).offset(10);
                }];
                
                [imgLoc mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(timLLl.mas_left).offset(-3);
                    make.centerY.equalTo(blackV.mas_centerY);
                    make.width.height.offset(14);
                }];
                
                nickMML.frame = CGRectMake(0, thrVV.height-61-28+26, 88, 20);
                headIM.frame = CGRectMake(14, thrVV.height-61-28-60+26, 60, 60);
                placV.frame = CGRectMake(0, 0, 60, 60);
                
                UIButton *clicmM = [[UIButton alloc] initWithFrame:CGRectMake(7, thrVV.height-61-28-60+26, 60, 60)];
                clicmM.tag = 7600+i;
                [clicmM addTarget:self action:@selector(clickHeadTagMethod:) forControlEvents:UIControlEventTouchUpInside];
                [thrVV addSubview:clicmM];
            }else if (i==1) {
                
                blackV.frame = CGRectMake(0, thrVV.height-61, 88, 20);
                [timLLl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(blackV);
                    make.centerX.equalTo(blackV.mas_centerX).offset(10);
                }];
                
                [imgLoc mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(timLLl.mas_left).offset(-3);
                    make.centerY.equalTo(blackV.mas_centerY);
                    make.width.height.offset(14);
                }];
                
                nickMML.frame = CGRectMake(0, thrVV.height-61-28, 88, 20);
                headIM.frame = CGRectMake(7, thrVV.height-61-28-80, 74, 74);
                placV.frame = CGRectMake(0, 0, 74, 74);
                
                UIImageView *pRowV = [[UIImageView alloc] initWithFrame:CGRectMake(7, thrVV.height-61-28-80-41, 74, 50)];
                pRowV.image = [UIImage imageNamed:@"rankingBackImg3"];
                [thrVV addSubview:pRowV];
                
                UIButton *clicmM = [[UIButton alloc] initWithFrame:CGRectMake(7, thrVV.height-61-28-80, 74, 74)];
                clicmM.tag = 7600+i;
                [clicmM addTarget:self action:@selector(clickHeadTagMethod:) forControlEvents:UIControlEventTouchUpInside];
                [thrVV addSubview:clicmM];
                
            }else {
                blackV.frame = CGRectMake(0, thrVV.height-61+41, 88, 20);
                [timLLl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(blackV);
                    make.centerX.equalTo(blackV.mas_centerX).offset(10);
                }];
                
                [imgLoc mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(timLLl.mas_left).offset(-3);
                    make.centerY.equalTo(blackV.mas_centerY);
                    make.width.height.offset(14);
                }];
                
                nickMML.frame = CGRectMake(0, thrVV.height-61-28+41, 88, 20);
                headIM.frame = CGRectMake(14, thrVV.height-61-28-60+41, 60, 60);
                placV.frame = CGRectMake(0, 0, 60, 60);
                
                UIButton *clicmM = [[UIButton alloc] initWithFrame:CGRectMake(7, thrVV.height-61-28-60+41, 60, 60)];
                clicmM.tag = 7600+i;
                [clicmM addTarget:self action:@selector(clickHeadTagMethod:) forControlEvents:UIControlEventTouchUpInside];
                [thrVV addSubview:clicmM];
            }
        }
    }
    return self;
}

- (void)addDataToArr:(NSArray *)arList
{
    if(arList.count > 0) {
        self.arrL = arList;
        if(arList.count >= 3) {
            
            for (int i=0; i<3; i++) {
                
                UIImageView *oneImgV1 = [self.contentView viewWithTag:7300+i];
                UILabel *oneLabV1 = [self.contentView viewWithTag:7400+i];
                UILabel *oneLabTim1 = [self.contentView viewWithTag:7500+i];
                UIImageView *oneImgLoc1 = [self.contentView viewWithTag:7700+i];
                
                if(i==0) {
                    MHrankingUserModel *model = arList[1];
                    
                    [oneImgV1 sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
                    oneLabV1.text = model.nickName;
                    oneLabTim1.text = model.duration;
                }else if (i==1) {
                    MHrankingUserModel *model = arList[0];
                    
                    [oneImgV1 sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
                    oneLabV1.text = model.nickName;
                    oneLabTim1.text = model.duration;
                }else {
                    MHrankingUserModel *model = arList[2];
                    
                    [oneImgV1 sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
                    oneLabV1.text = model.nickName;
                    oneLabTim1.text = model.duration;
                }
            }
        }else {
            if(arList.count == 1) {
                
                UIImageView *oneImgV1 = [self.contentView viewWithTag:7300+1];
                UILabel *oneLabV1 = [self.contentView viewWithTag:7400+1];
                UILabel *oneLabTim1 = [self.contentView viewWithTag:7500+1];
                UIImageView *oneImgLoc1 = [self.contentView viewWithTag:7700+1];
                
       
                MHrankingUserModel *model = arList[0];

                [oneImgV1 sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
                oneLabV1.text = model.nickName;
                oneLabTim1.text = model.duration;
                
            }else {
                for (int i=0; i<2; i++) {
                    
                    UIImageView *oneImgV1 = [self.contentView viewWithTag:7300+i];
                    UILabel *oneLabV1 = [self.contentView viewWithTag:7400+i];
                    UILabel *oneLabTim1 = [self.contentView viewWithTag:7500+i];
                    UIImageView *oneImgLoc1 = [self.contentView viewWithTag:7700+i];
                    
                    if(i==0) {
                        MHrankingUserModel *model = arList[1];
                        
                        [oneImgV1 sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
                        oneLabV1.text = model.nickName;
                        oneLabTim1.text = model.duration;
                    }else {
                        MHrankingUserModel *model = arList[0];
                        
                        [oneImgV1 sd_setImageWithURL:[NSURL URLWithString:model.profile] placeholderImage:normal_placeHeadImg];
                        oneLabV1.text = model.nickName;
                        oneLabTim1.text = model.duration;
                    }
                }
            }
        }
    }
}

- (void)clickHeadTagMethod:(UIButton *)btn
{
    if(btn.tag == 7600) {
        if(self.arrL.count > 1) {
            
            MHrankingUserModel *model = self.arrL[1];
            MHOthrMyController *vc = [[MHOthrMyController alloc] init];
            vc.otherId = model.uid;
            UIViewController *selfVV = [[FloatingWindowModel shareInstance] getCurrentViewController];
            [selfVV.navigationController pushViewController:vc animated:YES];
        }
       
    }
    if(btn.tag == 7601) {
        if(self.arrL.count > 0) {
            
            MHrankingUserModel *model = self.arrL[0];
            MHOthrMyController *vc = [[MHOthrMyController alloc] init];
            vc.otherId = model.uid;
            UIViewController *selfVV = [[FloatingWindowModel shareInstance] getCurrentViewController];
            [selfVV.navigationController pushViewController:vc animated:YES];
        }
    }
    if(btn.tag == 7602) {
        if(self.arrL.count > 2) {
            
            MHrankingUserModel *model = self.arrL[2];
            MHOthrMyController *vc = [[MHOthrMyController alloc] init];
            vc.otherId = model.uid;
            UIViewController *selfVV = [[FloatingWindowModel shareInstance] getCurrentViewController];
            [selfVV.navigationController pushViewController:vc animated:YES];
        }
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
