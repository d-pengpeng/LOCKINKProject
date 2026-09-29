//
//  homeLivingTwoCell.m
//  AuctionLiveProject
//
//  Created by Edwin on 2023/5/13.
//

#import "homeLivingTwoCell.h"
#import "FSPageContentView.h"
#import "MHMySubController.h"

@interface homeLivingTwoCell ()<FSPageContentViewDelegate>

@property (nonatomic, strong) FSPageContentView *pageContentV;
@property (nonatomic, strong) UIView *conVVV;
@property (nonatomic, strong) NSMutableArray *vcMutAr;
@property (nonatomic, assign) BOOL isBooL;
@end
@implementation homeLivingTwoCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *cellIdentifier = @"homeLivingTwoCell";
    homeLivingTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[homeLivingTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeLivingTwoCell"];
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
            make.left.right.top.bottom.equalTo(self.contentView);
            make.height.offset(_window_height-TIMESTATUSHEIGHT-44-44);
        }];
        
        self.vcMutAr = [NSMutableArray array];
        
    }
    return self;
    
}

- (void)addDataToModel:(NSArray *)datArr  datList:(NSArray *)listArr typeL:(NSInteger)typeL booScrol:(BOOL)scrolB vieControl:(nonnull UIViewController *)selfVV
{
    if(self.isBooL){
        self.isBooL = NO;
        [self.pageContentV removeFromSuperview];
        self.pageContentV = nil;
        [self.vcMutAr removeAllObjects];
    }
    if(self.pageContentV == nil) {
        for (int i=0; i<datArr.count; i++) {
            MHMySubController *VC = [[MHMySubController alloc] init];
            VC.othrerId = self.othrId;
            VC.cageId = i;
            [self.vcMutAr addObject:VC];
        }

        self.pageContentV = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 0, _window_width, _window_height-TIMESTATUSHEIGHT-44-44) childVCs:self.vcMutAr parentVC:self.selVC delegate:self];
        self.pageContentV.contentViewCanScroll = YES;
        [self.conVVV addSubview:self.pageContentV];
    }
    
    if(self.vcMutAr.count > typeL) {

        MHMySubController *VC = self.vcMutAr[typeL];
        [VC booToBoo:scrolB arrMut:listArr];
    }
    
    self.pageContentV.contentViewCurrentIndex = typeL;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    if(self.block_) {
        self.block_(endIndex);
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
