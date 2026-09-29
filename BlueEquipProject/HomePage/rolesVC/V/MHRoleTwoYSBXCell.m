//
//  MHRoleTwoYSBXCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/11/26.
//

#import "MHRoleTwoYSBXCell.h"
#import "MHManualOperationSubOneView.h"

@interface MHRoleTwoYSBXCell ()

@property (nonatomic, strong) UIImageView *lefImgV;
@property (nonatomic, strong) UIImageView *lefImgV2;
@property (nonatomic, strong) UILabel *tit_Lab;
@property (nonatomic, strong) UILabel *tit_Lab2;
@property (nonatomic, strong) UILabel *sm_Lab1;
@property (nonatomic, strong) UILabel *sm_Lab2;

@property (nonatomic, strong) UIButton *dele_Btn;
@property (nonatomic, strong) MHManualOperationSubOneView_lin *MHManualOperationSubOneV;
@end

@implementation MHRoleTwoYSBXCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHRoleTwoYSBXCell";
    MHRoleTwoYSBXCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHRoleTwoYSBXCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHRoleTwoYSBXCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        CGFloat ww_xxx = _window_width-40-28;
        
        self.tit_Lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.tit_Lab];
        [self.tit_Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top);
            make.height.offset(36);
            make.width.mas_lessThanOrEqualTo(ww_xxx-20);
        }];
        
        self.tit_Lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:15 textAlignment:NSTextAlignmentCenter];
        self.tit_Lab2.layer.cornerRadius = 8;
        self.tit_Lab2.layer.borderColor = UIColor.whiteColor.CGColor;
        self.tit_Lab2.layer.borderWidth = 1;
        [self.contentView addSubview:self.tit_Lab2];
        [self.tit_Lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tit_Lab.mas_right).offset(2);
            make.centerY.equalTo(self.tit_Lab.mas_centerY);
            make.height.offset(16);
            make.width.mas_greaterThanOrEqualTo(16);
        }];
        
        UIView *one_VVV = [HistoryRecordModel createViewUIUI];
        one_VVV.layer.cornerRadius = 14;
        [self.contentView addSubview:one_VVV];
        [one_VVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(36);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.offset(142);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        }];
        
        self.MHManualOperationSubOneV = [[MHManualOperationSubOneView_lin alloc] initWithFrame:CGRectMake(14, 36, _window_width-40-28, 64)];
        [one_VVV addSubview:self.MHManualOperationSubOneV];
        
        self.dele_Btn = [HistoryRecordModel createImgBtn];
        [self.dele_Btn setImage:[UIImage imageNamed:@"delete_img1"] forState:UIControlStateNormal];
        [self.dele_Btn addTarget:self action:@selector(deleteMethodUIUIUI) forControlEvents:UIControlEventTouchUpInside];
        [one_VVV addSubview:self.dele_Btn];
        [self.dele_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(one_VVV);
            make.width.height.offset(36);
        }];
        
        self.lefImgV = [HistoryRecordModel createImgImgView];
        self.lefImgV.image = [UIImage imageNamed:@"center_img15_15"];
        [one_VVV addSubview:self.lefImgV];
        [self.lefImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(one_VVV.mas_left).offset(14);
            make.bottom.equalTo(one_VVV.mas_bottom).offset(-10);
            make.height.offset(22);
            make.width.mas_greaterThanOrEqualTo(60);
        }];
        self.sm_Lab1 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
        [self.lefImgV addSubview:self.sm_Lab1];
        [self.sm_Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV.mas_left).offset(8);
            make.top.bottom.equalTo(self.lefImgV);
            make.right.equalTo(self.lefImgV.mas_right).offset(-8);
        }];
        
        self.lefImgV2 = [HistoryRecordModel createImgImgView];
        self.lefImgV2.image = [UIImage imageNamed:@"center_img15_15"];
        [one_VVV addSubview:self.lefImgV2];
        [self.lefImgV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV.mas_right).offset(6);
            make.bottom.equalTo(one_VVV.mas_bottom).offset(-10);
            make.height.offset(22);
            make.width.mas_greaterThanOrEqualTo(60);
        }];
        self.sm_Lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
        [self.lefImgV2 addSubview:self.sm_Lab2];
        [self.sm_Lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV2.mas_left).offset(24);
            make.top.bottom.equalTo(self.lefImgV2);
            make.right.equalTo(self.lefImgV2.mas_right).offset(-8);
        }];
        
        UIImageView *lock_Img = [HistoryRecordModel createImgImgView];
        lock_Img.image = [UIImage imageNamed:@"time_imgslock"];
        [self.lefImgV2 addSubview:lock_Img];
        [lock_Img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV2.mas_left).offset(8);
            make.centerY.equalTo(self.lefImgV2.mas_centerY);
            make.width.height.offset(12);
        }];
    }
    return self;
}

- (void)addModelToDataModel
{
    MHBoXingModel *model = [MHBoXingModel mj_objectWithKeyValues:self.dicMM];
    self.tit_Lab.text = model.title;
    self.tit_Lab2.text = [NSString stringWithFormat:@"%ld", (long)(self.indPPP.row+1)];
    self.sm_Lab1.text = eLocalizedString(@"two_nams25");
    self.sm_Lab2.text = model.time;
    
    NSArray *bx_arr = [minStr(model.content) componentsSeparatedByString:@","];
    [self.MHManualOperationSubOneV addArrToMethodArr:bx_arr sel:0];
    
    self.dele_Btn.hidden = YES;
    self.lefImgV2.hidden = YES;
    
}

- (void)addModelToDataModelUser
{
    MHBoXingModel *model = [MHBoXingModel mj_objectWithKeyValues:self.dicMM];
    self.tit_Lab.text = model.title;
    self.tit_Lab2.text = [NSString stringWithFormat:@"%ld", (long)(self.indPPP.row+1)];
    self.sm_Lab1.text = eLocalizedString(@"two_nams25");
    self.sm_Lab2.text = model.time;
    
    NSArray *bx_arr = [minStr(model.content) componentsSeparatedByString:@","];
    [self.MHManualOperationSubOneV addArrToMethodArr:bx_arr sel:0];
    
    self.dele_Btn.hidden = NO;
    self.lefImgV2.hidden = NO;
}

- (void)deleteMethodUIUIUI
{
    if ([self.delegate_ respondsToSelector:@selector(roleTwoYSBXCelldelegateDeleteRow:)]) {
        [self.delegate_ roleTwoYSBXCelldelegateDeleteRow:self.indPPP];
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




#import "showColoUIUIUIView.h"

@interface MHRoleTwoYSBXCell_three ()

@property (nonatomic, strong) UIImageView *lefImgV;
@property (nonatomic, strong) UIImageView *lefImgV2;
@property (nonatomic, strong) UILabel *tit_Lab;
@property (nonatomic, strong) UILabel *tit_Lab2;
@property (nonatomic, strong) UILabel *sm_Lab1;
@property (nonatomic, strong) UILabel *sm_Lab2;
@property (nonatomic, strong) UIButton *dele_Btn;
@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) showColoUIUIUIView *showColoUIUIUIV;
@property (nonatomic, strong) showColoUIUIUIView *showColoUIUIUIV2;

@property (nonatomic, strong) MHManualOperationSubOneView_lin *MHManualOperationSubOneV;

@end

@implementation MHRoleTwoYSBXCell_three

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHRoleTwoYSBXCell_three";
    MHRoleTwoYSBXCell_three *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHRoleTwoYSBXCell_three alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHRoleTwoYSBXCell_three"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColor.clearColor;
        self.contentView.backgroundColor = UIColor.clearColor;
        
        CGFloat ww_xxx = _window_width-40-28;
        
        self.tit_Lab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.tit_Lab];
        [self.tit_Lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top);
            make.height.offset(36);
            make.width.mas_lessThanOrEqualTo(ww_xxx-20);
        }];
        
        self.tit_Lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:15 textAlignment:NSTextAlignmentCenter];
        self.tit_Lab2.layer.cornerRadius = 8;
        self.tit_Lab2.layer.borderColor = UIColor.whiteColor.CGColor;
        self.tit_Lab2.layer.borderWidth = 1;
        [self.contentView addSubview:self.tit_Lab2];
        [self.tit_Lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tit_Lab.mas_right).offset(2);
            make.centerY.equalTo(self.tit_Lab.mas_centerY);
            make.height.offset(16);
            make.width.mas_greaterThanOrEqualTo(16);
        }];
        
        UIView *one_VVV = [HistoryRecordModel createViewUIUI];
        one_VVV.layer.cornerRadius = 14;
        [self.contentView addSubview:one_VVV];
        [one_VVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.top.equalTo(self.contentView.mas_top).offset(36);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.height.offset(142);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        }];
        
        
//        self.showColoUIUIUIV = [[showColoUIUIUIView alloc] initWithFrame:CGRectMake(14, 36, _window_width-40-28, 64)];
//        self.showColoUIUIUIV.lineColor = RGB(13, 223, 255);
//        self.showColoUIUIUIV.placeColor = RGB(240, 240, 240);
//        self.showColoUIUIUIV.isShowCirc = YES;
//        self.showColoUIUIUIV.HH_H = 64;
//        self.showColoUIUIUIV.clipsToBounds = YES;
//        self.showColoUIUIUIV.backgroundColor = UIColor.clearColor;
//        [one_VVV addSubview:self.showColoUIUIUIV];
//        
//        self.showColoUIUIUIV2 = [[showColoUIUIUIView alloc] initWithFrame:CGRectMake(14, 36, _window_width-40-28, 64)];
//        self.showColoUIUIUIV2.lineColor = normalColors;
//        self.showColoUIUIUIV2.placeColor = RGB(240, 240, 240);
//        self.showColoUIUIUIV2.isShowCirc = YES;
//        self.showColoUIUIUIV2.HH_H = 64;
//        self.showColoUIUIUIV2.clipsToBounds = YES;
//        self.showColoUIUIUIV2.backgroundColor = UIColor.clearColor;
//        [one_VVV addSubview:self.showColoUIUIUIV2];
        
        self.MHManualOperationSubOneV = [[MHManualOperationSubOneView_lin alloc] initWithFrame:CGRectMake(14, 36, _window_width-40-28, 64)];
        [one_VVV addSubview:self.MHManualOperationSubOneV];
        
                
        self.dele_Btn = [HistoryRecordModel createImgBtn];
        [self.dele_Btn setImage:[UIImage imageNamed:@"delete_img1"] forState:UIControlStateNormal];
        [self.dele_Btn addTarget:self action:@selector(deleteMethodUIUIUI) forControlEvents:UIControlEventTouchUpInside];
        [one_VVV addSubview:self.dele_Btn];
        [self.dele_Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(one_VVV);
            make.width.height.offset(36);
        }];
        
        self.lefImgV = [HistoryRecordModel createImgImgView];
        self.lefImgV.image = [UIImage imageNamed:@"center_img15_15"];
        [one_VVV addSubview:self.lefImgV];
        [self.lefImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(one_VVV.mas_left).offset(14);
            make.bottom.equalTo(one_VVV.mas_bottom).offset(-10);
            make.height.offset(22);
            make.width.mas_greaterThanOrEqualTo(60);
        }];
        self.sm_Lab1 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
        [self.lefImgV addSubview:self.sm_Lab1];
        [self.sm_Lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV.mas_left).offset(8);
            make.top.bottom.equalTo(self.lefImgV);
            make.right.equalTo(self.lefImgV.mas_right).offset(-8);
        }];
        
        self.lefImgV2 = [HistoryRecordModel createImgImgView];
        self.lefImgV2.image = [UIImage imageNamed:@"center_img15_15"];
        [one_VVV addSubview:self.lefImgV2];
        [self.lefImgV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV.mas_right).offset(6);
            make.bottom.equalTo(one_VVV.mas_bottom).offset(-10);
            make.height.offset(22);
            make.width.mas_greaterThanOrEqualTo(60);
        }];
        self.sm_Lab2 = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:12 textAlignment:NSTextAlignmentCenter];
        [self.lefImgV2 addSubview:self.sm_Lab2];
        [self.sm_Lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV2.mas_left).offset(24);
            make.top.bottom.equalTo(self.lefImgV2);
            make.right.equalTo(self.lefImgV2.mas_right).offset(-8);
        }];
        
        UIImageView *lock_Img = [HistoryRecordModel createImgImgView];
        lock_Img.image = [UIImage imageNamed:@"time_imgslock"];
        [self.lefImgV2 addSubview:lock_Img];
        [lock_Img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lefImgV2.mas_left).offset(8);
            make.centerY.equalTo(self.lefImgV2.mas_centerY);
            make.width.height.offset(12);
        }];
        
        self.playBtn = [HistoryRecordModel createImgBtn];
        [self.playBtn setImage:[UIImage imageNamed:@"play_allImgs2"] forState:UIControlStateNormal];
        [self.playBtn setImage:[UIImage imageNamed:@"play_allImgs1"] forState:UIControlStateSelected];
        self.playBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [self.playBtn addTarget:self action:@selector(playBtnmethod) forControlEvents:UIControlEventTouchUpInside];
        [one_VVV addSubview:self.playBtn];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(one_VVV.mas_right).offset(-4);
            make.centerY.equalTo(self.lefImgV.mas_centerY);
            make.width.height.offset(42);
        }];
    }
    return self;
}

- (void)addModelToDataModelUser
{
    self.tit_Lab.text = self.model.title;
    self.tit_Lab2.text = [NSString stringWithFormat:@"%ld", (long)(self.indPPP.row+1)];
    self.sm_Lab1.text = eLocalizedString(@"two_nams25");
    self.sm_Lab2.text = self.model.time;
    
    self.playBtn.selected = self.model.isPlayBoo;
    
    [self.showColoUIUIUIV clearArrMethod];
    [self.showColoUIUIUIV2 clearArrMethod];
    
    NSArray *bx_arr = [minStr(self.model.content) componentsSeparatedByString:@"-"];
    if (bx_arr.count>5) {
        
        NSMutableArray *lis_arM = [NSMutableArray array];
        NSMutableArray *lis_arM2 = [NSMutableArray array];
        for (NSString *str_sub in bx_arr) {
            
            NSData *jsonData = [str_sub dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            if(jsonData) {
                NSDictionary *dicSub = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
                if (!error) {
                    
                    [lis_arM addObject:minStr(dicSub[@"voltage"])];
                    [lis_arM2 addObject:minStr(dicSub[@"shakeIntensity"])];
                }
            }
            
        }
        
        if ([minStr(lis_arM[0]) floatValue] > [minStr(lis_arM2[0]) floatValue]) {
            [self.MHManualOperationSubOneV addArrToMethodArr:lis_arM sel:0];
        }else {
            [self.MHManualOperationSubOneV addArrToMethodArr:lis_arM2 sel:0];
        }
        
        
//        self.showColoUIUIUIV.numPag = 1;
//        self.showColoUIUIUIV2.numPag = 1;
//        [self.showColoUIUIUIV addDataToArr:lis_arM];
//        [self.showColoUIUIUIV2 addDataToArr:lis_arM2];
        
    }else {
        NSData *jsonData = [minStr(self.model.content) dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSMutableArray *lis_arM = [NSMutableArray array];
        NSMutableArray *lis_arM2 = [NSMutableArray array];
        if(jsonData) {
            NSArray *dicSub = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            if (!error) {
                
                for (int i=0; i<dicSub.count; i++) {
                    
                    [lis_arM addObject:minStr(dicSub[i][@"voltage"])];
                    [lis_arM2 addObject:minStr(dicSub[i][@"shakeIntensity"])];
                }
            }
        }
        
        if (lis_arM.count>0) {
            if ([minStr(lis_arM[0]) floatValue] > [minStr(lis_arM2[0]) floatValue]) {
                [self.MHManualOperationSubOneV addArrToMethodArr:lis_arM sel:0];
            }else {
                [self.MHManualOperationSubOneV addArrToMethodArr:lis_arM2 sel:0];
            }
        }
        
//        self.showColoUIUIUIV.numPag = 1;
//        self.showColoUIUIUIV2.numPag = 1;
//        [self.showColoUIUIUIV addDataToArr:lis_arM];
//        [self.showColoUIUIUIV2 addDataToArr:lis_arM2];
    }
    
    self.dele_Btn.hidden = NO;
    self.lefImgV2.hidden = NO;
}

- (void)playBtnmethod
{
    self.playBtn.selected = !self.playBtn.selected;
    if ([self.delegate_ respondsToSelector:@selector(roleTwoYSBXCelldelegateDeletePlayBooRow:)]) {
        [self.delegate_ roleTwoYSBXCelldelegateDeletePlayBooRow:self.indPPP];
    }
}

- (void)deleteMethodUIUIUI
{
    if ([self.delegate_ respondsToSelector:@selector(roleTwoYSBXCelldelegateDeleteRow:)]) {
        [self.delegate_ roleTwoYSBXCelldelegateDeleteRow:self.indPPP];
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
