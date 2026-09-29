//
//  MHRoleThrSDMSView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/12/14.
//

#import "MHRoleThrSDMSView.h"

@implementation MHRoleThrSDMSView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIButton *dele_Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [dele_Btn addTarget:self action:@selector(deleBtnMethoudMM) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:dele_Btn];
     
        UIView *oneVVVV = [[UIView alloc] initWithFrame:CGRectMake(_window_width-80-288, _window_height-TARBARHEIGHT+49-38-175, 288, 175)];
        oneVVVV.backgroundColor = UIColor.clearColor;
        oneVVVV.clipsToBounds = YES;
        [self addSubview:oneVVVV];
        
        UIImageView *one_imgV = [HistoryRecordModel createImgImgView];
        one_imgV.frame = CGRectMake(0, 0, oneVVVV.width, oneVVVV.height);
        one_imgV.image = [UIImage imageNamed:@"three_imgs9"];
        [oneVVVV addSubview:one_imgV];
        
        UIView *subVV = [[UIView alloc] initWithFrame:CGRectMake(14, 7, oneVVVV.width-28, 152)];
        subVV.backgroundColor = UIColor.clearColor;
        subVV.clipsToBounds = YES;
        [oneVVVV addSubview:subVV];
        
        for (int i=0; i<10; i++) {
            UIButton *ten_BBtn = [HistoryRecordModel createImgBtn];
            if (i>4) {
                ten_BBtn.frame = CGRectMake((i-5)*52, 76, 52, 76);
            }else {
                ten_BBtn.frame = CGRectMake(i*52, 0, 52, 76);
            }
            ten_BBtn.tag = 200+i;
            [ten_BBtn addTarget:self action:@selector(tenBtnMethodUIUIUIUTag:) forControlEvents:UIControlEventTouchUpInside];
            [subVV addSubview:ten_BBtn];
            
            NSString *img_ss = [NSString stringWithFormat:@"threeModel_imgs%d", i+1];
            UIImageView *teImgVV = [HistoryRecordModel createImgImgView];
            teImgVV.frame = CGRectMake(6, 0, 40, 40);
            teImgVV.image = [UIImage imageNamed:img_ss];
            teImgVV.tag = 300+i;
            [ten_BBtn addSubview:teImgVV];
            
            NSString *nam_sttt = [NSString stringWithFormat:@"thrModel_nams%d", i+1];
            if ([[FloatingWindowModel shareInstance].namStMMM isEqualToString:kCharactName15]) {
                nam_sttt = [NSString stringWithFormat:@"thrModel_nams%d_15", i+1];
                
                img_ss = [NSString stringWithFormat:@"threeModel_imgs%d_15", i+1];
                teImgVV.image = [UIImage imageNamed:img_ss];
            }
            UILabel *nam_LLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:10 textAlignment:NSTextAlignmentCenter];
            nam_LLab.frame = CGRectMake(3, 40, ten_BBtn.width-6, 36);
            nam_LLab.tag = 400+i;
            nam_LLab.numberOfLines = 2;
            nam_LLab.text = eLocalizedString(nam_sttt);
            [ten_BBtn addSubview:nam_LLab];
        }
    }
    return self;
}

- (void)addUploadUIUIMethod
{
    for (int i=0; i<10; i++) {
        
        UIButton *ten_BBtn = [self viewWithTag:200+i];
        
        UILabel *nam_LLab = [self viewWithTag:400+i];
        
        if (i+1==self.sel_row) {
            ten_BBtn.selected = YES;
            nam_LLab.textColor = normalColors;
        }else {
            ten_BBtn.selected = NO;
            nam_LLab.textColor = UIColor.whiteColor;
        }
    }
}

- (void)tenBtnMethodUIUIUIUTag:(UIButton *)btn
{
    BOOL tt_boo = NO;
    for (int i=0; i<10; i++) {
        
        UIButton *ten_BBtn = [self viewWithTag:200+i];
        
        UILabel *nam_LLab = [self viewWithTag:400+i];
        
        if (ten_BBtn == btn) {
            ten_BBtn.selected = YES; //!ten_BBtn.selected;
            if (ten_BBtn.selected == YES) {
                tt_boo = YES;
                nam_LLab.textColor = normalColors;
            }else {
                nam_LLab.textColor = UIColor.whiteColor;
            }
        }else {
            ten_BBtn.selected = NO;
            nam_LLab.textColor = UIColor.whiteColor;
        }
    }
    
    if (self.block_) {
        self.block_(btn.tag-200, tt_boo);
    }
}

- (void)deleBtnMethoudMM
{
    [self removeFromSuperview];
}

@end



@interface MHFourthChannelJDBXView ()<UITableViewDelegate, UITableViewDataSource, MHFourthChannelJDBXCelDelaget>

@property (nonatomic, strong) UITableView *appTableView;
@property (nonatomic, strong) UILabel *ttitLab;
@end

@implementation MHFourthChannelJDBXView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIButton *dele_Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _window_width, _window_height)];
        [dele_Btn addTarget:self action:@selector(deleBtnMethoudMM) forControlEvents:UIControlEventTouchUpInside];
        dele_Btn.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self addSubview:dele_Btn];
     
        UIView *oneVVVV = [[UIView alloc] initWithFrame:CGRectMake((_window_width-300)/2, (_window_height-428)/2, 300, 428)];
        oneVVVV.backgroundColor = UIColor.clearColor;
        oneVVVV.clipsToBounds = YES;
        [self addSubview:oneVVVV];
        
        UIImageView *one_imgV = [HistoryRecordModel createImgImgView];
        one_imgV.frame = CGRectMake(0, 0, oneVVVV.width, oneVVVV.height);
        one_imgV.image = [UIImage imageNamed:@"fourth_channelb_img"];
        [oneVVVV addSubview:one_imgV];
        
        _ttitLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:15 textAlignment:NSTextAlignmentCenter];
        _ttitLab.frame = CGRectMake(10, 0, oneVVVV.width-20, 50);
        [oneVVVV addSubview:_ttitLab];
        
        _appTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, oneVVVV.width, oneVVVV.height-60-84) style:UITableViewStylePlain];
        _appTableView.delegate = self;
        _appTableView.dataSource = self;
        _appTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _appTableView.rowHeight = UITableViewAutomaticDimension;
        _appTableView.estimatedRowHeight = 10;
        _appTableView.backgroundColor = UIColor.clearColor;
        _appTableView.dragInteractionEnabled = YES;
        self.appTableView.sectionHeaderTopPadding = 0;
        [self.appTableView registerClass:[MHFourthChannelJDBXCell class] forCellReuseIdentifier:@"MHFourthChannelJDBXCell"];
        [oneVVVV addSubview:_appTableView];
        
        UIButton *clearBtn = [HistoryRecordModel createImgBtn];
        clearBtn.frame = CGRectMake((oneVVVV.width-150)/2, oneVVVV.height-60, 150, 36);
        [clearBtn setBackgroundImage:[UIImage imageNamed:@"fourth_channel_Img"] forState:UIControlStateNormal];
        [clearBtn setTitle:eLocalizedString(@"role_setting44") forState:UIControlStateNormal];
        [clearBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        clearBtn.titleLabel.font = SYS_Font(14);
        [clearBtn addTarget:self action:@selector(clearListMethod) forControlEvents:UIControlEventTouchUpInside];
        [oneVVVV addSubview:clearBtn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kNotifUploadQiuiPlayListNoteMethod:) name:kNotifUploadQiuiPlayListNote object:nil];
    }
    return self;
}

- (void)kNotifUploadQiuiPlayListNoteMethod:(NSNotification *)notif
{
    NSString *not_str = minStr(notif.object);
    self.playNumb = [not_str intValue];
    
    [self.appTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MHFourthChannelJDBXCell *cell = [MHFourthChannelJDBXCell cellWithTabelView:tableView];
    cell.indPax = indexPath;
    cell.isPlayb = indexPath.row==self.playNumb ? YES:NO;
    [cell addDataToDic:minStr(self.listArr[indexPath.row])];
    cell.delegate_ = self;
    cell.backgroundColor = UIColor.clearColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)addDataUploadUIUIMethod:(BOOL)isChannelA
{
    self.ttitLab.text = isChannelA ? eLocalizedString(@"fourth_channel_A2"):eLocalizedString(@"fourth_channel_B2");
    
    [self.appTableView reloadData];
}

-(void)FourthChannelJDBX:(NSInteger)typeN indexPath:(NSIndexPath *)indexPath
{
    if (typeN == 1) {
        
        [self.listArr removeObjectAtIndex:indexPath.row];
        
        [self.appTableView reloadData];
        if (self.block_) {
            self.block_(self.listArr, YES);
        }
    }else {
        if (indexPath.row > 0) {
            
            NSString *oneS = minStr(self.listArr[indexPath.row-1]);
            NSString *twoS = minStr(self.listArr[indexPath.row]);
            [self.listArr replaceObjectAtIndex:indexPath.row-1 withObject:twoS];
            [self.listArr replaceObjectAtIndex:indexPath.row withObject:oneS];
            [self.appTableView reloadData];
            
            if (self.block_) {
                self.block_(self.listArr, YES);
            }
        }
    }
}

- (void)clearListMethod
{
    [self.listArr removeAllObjects];
    [self.appTableView reloadData];
    
    if (self.block_) {
        self.block_(self.listArr, YES);
    }
}

- (void)deleBtnMethoudMM
{
    [self removeFromSuperview];
}

@end




@interface MHFourthChannelJDBXCell ()

@property (nonatomic, strong) UILabel *namLab;
@property (nonatomic, strong) UIButton *nexBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation MHFourthChannelJDBXCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHFourthChannelJDBXCell";
    MHFourthChannelJDBXCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHFourthChannelJDBXCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHFourthChannelJDBXCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.namLab = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:14 textAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.namLab];
        [self.namLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(28);
            make.top.bottom.equalTo(self.contentView);
            make.height.offset(38);
            make.right.equalTo(self.contentView.mas_right).offset(-86);
        }];
        
        self.deleteBtn = [HistoryRecordModel createImgBtn];
        [self.deleteBtn setImage:[UIImage imageNamed:@"fourth_chanListDelete_img"] forState:UIControlStateNormal];
        [self.deleteBtn setImage:[UIImage imageNamed:@"fourth_chanListDeleteSel_img"] forState:UIControlStateSelected];
        [self.deleteBtn addTarget:self action:@selector(deleteOneMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.height.offset(28);
        }];
        
        self.nexBtn = [HistoryRecordModel createImgBtn];
        [self.nexBtn setImage:[UIImage imageNamed:@"fourth_chanListNex_img"] forState:UIControlStateNormal];
        [self.nexBtn setImage:[UIImage imageNamed:@"fourth_chanListNexSel_img"] forState:UIControlStateSelected];
        [self.nexBtn addTarget:self action:@selector(nextOneMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.nexBtn];
        [self.nexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.deleteBtn.mas_left).offset(-10);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.height.offset(28);
        }];
     }
    return self;
}

- (void)addDataToDic:(NSString *)model
{
    self.nexBtn.selected = self.isPlayb;
    self.deleteBtn.selected = self.isPlayb;
    
    NSString *nam_sttt = [NSString stringWithFormat:@"fourthModel2_nams%d", [minStr(model) intValue]+1];
    self.namLab.text = eLocalizedString(nam_sttt);
}

- (void)nextOneMethod
{
    if ([self.delegate_ respondsToSelector:@selector(FourthChannelJDBX:indexPath:)]) {
        [self.delegate_ FourthChannelJDBX:2 indexPath:self.indPax];
    }
}

- (void)deleteOneMethod
{
    if ([self.delegate_ respondsToSelector:@selector(FourthChannelJDBX:indexPath:)]) {
        [self.delegate_ FourthChannelJDBX:1 indexPath:self.indPax];
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

