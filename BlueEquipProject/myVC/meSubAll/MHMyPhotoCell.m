//
//  MHMyPhotoCell.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/10.
//

#import "MHMyPhotoCell.h"

@interface MHMyPhotoCell ()

@property (nonatomic, strong) UIView *conVVV;
@property (nonatomic, strong) UILabel *timeLLLL;
@property (nonatomic, strong) NSArray *imgsSAr;
@end
@implementation MHMyPhotoCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"MHMyPhotoCell";
    MHMyPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[MHMyPhotoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MHMyPhotoCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.contentView.backgroundColor = UIColor.clearColor;
        
        self.conVVV = [HistoryRecordModel createViewUIUI];
        self.conVVV.backgroundColor = UIColor.clearColor;
        [self.contentView addSubview:self.conVVV];
        [self.conVVV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(60);
            make.top.equalTo(self.contentView.mas_top).offset(14);
            make.right.bottom.equalTo(self.contentView);
            make.height.offset(94);
        }];
        
        self.timeLLLL = [HistoryRecordModel createLabLabTextColor:UIColor.whiteColor fontFloat:16 textAlignment:NSTextAlignmentCenter];
        [self.contentView addSubview:self.timeLLLL];
        [self.timeLLLL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(6);
            make.top.equalTo(self.contentView.mas_top).offset(14);
            make.width.offset(52);
            make.height.mas_greaterThanOrEqualTo(16);
        }];
        
        
        
    }
    return self;
    
}

- (void)addDataToModel:(NSDictionary *)dicMMMM
{
    self.timeLLLL.text = minStr(dicMMMM[@"time"]);
    NSArray *arLis = dicMMMM[@"photos"];
    if([arLis isKindOfClass:[NSArray class]]) {
        self.imgsSAr = arLis;
        int w_y = (_window_width-72)/102;
        
        int d_x = arLis.count%w_y;
        int d_y = (int)arLis.count/w_y;
        if(d_x>0) {
            d_y = d_y+1;
        }
        
        if(d_y > 0) {
            [self.conVVV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(94*d_y + (d_y-1)*8);
            }];
            
            for (int i=0; i<arLis.count; i++) {
                
                NSDictionary *dcUU = arLis[i];
                int dhh_x = i%w_y;
                int dhh_y = i/w_y;
                
                UIImageView *contimg = [[UIImageView alloc] init];
                contimg.clipsToBounds = YES;
                contimg.contentMode = UIViewContentModeScaleAspectFill;
                contimg.backgroundColor = GrayText102;
                contimg.layer.cornerRadius = 8;
                [self.conVVV addSubview:contimg];
                [contimg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.conVVV.mas_left).offset(dhh_x * 102);
                    make.top.equalTo(self.conVVV.mas_top).offset(dhh_y * 102);
                    make.width.height.offset(94);
                }];
                [contimg sd_setImageWithURL:[NSURL URLWithString:minStr(dcUU[@"url"])]];
                
                UIButton *videBtnMMM = [[UIButton alloc] initWithFrame:CGRectMake(dhh_x * 102, dhh_y * 102, 94, 94)];
                videBtnMMM.tag = 4900+i;
                [videBtnMMM addTarget:self action:@selector(videBtnMethodMMOne:) forControlEvents:UIControlEventTouchUpInside];
                [self.conVVV addSubview:videBtnMMM];
            }
        }
    }
}

- (void)videBtnMethodMMOne:(UIButton *)btn
{
    if([self.delegate_ respondsToSelector:@selector(myPhotoCellDelegateMethodNum:arr:)]) {
        [self.delegate_ myPhotoCellDelegateMethodNum:btn.tag-4900 arr:self.imgsSAr];
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
