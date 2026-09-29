//
//  MHGearSetView.m
//  BlueEquipProject
//
//  Created by Edwin on 2024/1/18.
//

#import "MHGearSetView.h"

@interface MHGearSetView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *myPickerView;
@property (nonatomic, strong) NSMutableArray *arrMuts;
@end
@implementation MHGearSetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = UIColor.clearColor;
        
        self.arrMuts = [NSMutableArray array];
        
        
        UIImageView *img_v = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height/3.0, self.width, self.height/3.0)];
        img_v.clipsToBounds = YES;
        img_v.backgroundColor = normalColors;
        [self addSubview:img_v];
        
        self.myPickerView = [[UIPickerView alloc]init];
        self.myPickerView.frame = self.bounds;
        self.myPickerView.dataSource = self;
        self.myPickerView.delegate = self;
        self.myPickerView.showsSelectionIndicator = YES;
        self.myPickerView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.myPickerView];
    }
    return self;
}

- (void)setImgArr:(NSMutableArray *)imgArr
{
    [self.arrMuts removeAllObjects];
    for (int i=0; i<imgArr.count; i++) {
        NSString *name = imgArr[i];
        if (i==0) {
            NSArray *contArr = @[name, @"1"];
            [self.arrMuts addObject:contArr];
        }else {
            NSArray *contArr = @[name, @"0"];
            [self.arrMuts addObject:contArr];
        }
    }
    [self.myPickerView reloadAllComponents];
    [self.myPickerView selectRow:0 inComponent:0 animated:YES];
}

#pragma mark-<UIPickerViewDataSource>
//设定分区数，即该选择器有多少个列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
//设定每个分区内的元素个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    return self.arrMuts.count;
}
#pragma mark-<UIPickerViewDelegate>

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.height/3.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    UIView *oenv = (UIView *)view;
//    UIImageView *img_v;
    UILabel *onelab;
    if (!oenv) {
        oenv = [[UIView alloc] init];
        [oenv setBackgroundColor:[UIColor clearColor]];
        
//        img_v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/3.0)];
//        img_v.clipsToBounds = YES;
//        [oenv addSubview:img_v];
        
        onelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/3.0)];
        onelab.textAlignment = NSTextAlignmentCenter;
        onelab.backgroundColor = UIColor.clearColor;
        [oenv addSubview:onelab];
    }
    
    NSArray *contAA = self.arrMuts[row];
    NSString *onest = contAA[0];
    NSString *twost = contAA[1];
    onelab.text = onest;
    
    if ([twost integerValue] > 0) {
//        img_v.backgroundColor = normalColors;
        onelab.textColor = UIColor.whiteColor;
        onelab.font = SYS_Font(self.maxFont);
    }else {
//        img_v.backgroundColor = UIColor.clearColor;
        onelab.textColor = RGBA(166, 62, 212, 1.0);
        onelab.font = SYS_Font(self.minFont);
    }
    
    return oenv;
}

//选中选择器元素（未拨动的部分为未选择状态）
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    for (int i=0; i<self.arrMuts.count; i++) {
        NSArray *contBB = self.arrMuts[i];
        if (row == i) {
            NSArray *contArr = @[contBB[0], @"1"];
            [self.arrMuts replaceObjectAtIndex:i withObject:contArr];
        }else {
            NSArray *contArr = @[contBB[0], @"0"];
            [self.arrMuts replaceObjectAtIndex:i withObject:contArr];
        }
    }
    
    NSArray *contAA = self.arrMuts[row];
    NSString *onest = contAA[0];
    if (self.block_) {
        self.block_(onest);
    }
    
    [self.myPickerView reloadComponent:component];
}

//无用
//- (void)initScrollViewBase
//{
//    self.oneLab = [HistoryRecordModel createLabLabTextColor:RGBA(166, 62, 212, 0.3) fontFloat:20 textAlignment:NSTextAlignmentCenter];
//    self.oneLab.frame = CGRectMake(0, 0, self.width, self.heihh_h);
//    [self addSubview:self.oneLab];
//    
//    self.twoLab = [HistoryRecordModel createLabLabTextColor:RGBA(166, 62, 212, 0.3) fontFloat:20 textAlignment:NSTextAlignmentCenter];
//    self.twoLab.frame = CGRectMake(0, self.heihh_h*2, self.width, self.heihh_h);
//    [self addSubview:self.twoLab];
//    
//    self.scrollVV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.heihh_h, self.width, self.heihh_h)];
//    self.scrollVV.scrollEnabled = YES;
//    self.scrollVV.pagingEnabled = YES;
//    self.scrollVV.bounces = NO;
//    self.scrollVV.alwaysBounceVertical = YES;
//    self.scrollVV.alwaysBounceHorizontal = NO;
//    self.scrollVV.showsVerticalScrollIndicator = NO;
//    self.scrollVV.showsHorizontalScrollIndicator = NO;
//    self.scrollVV.delegate = self;
//    [self addSubview:self.scrollVV];
//}
//
//- (void)setImgArr:(NSMutableArray *)imgArr
//{
//    [self removeAllSubviews];
//    
//    [self initScrollViewBase];
//    
//    self.oneLab.font = SYS_Font(self.minFont);
//    self.twoLab.font = SYS_Font(self.minFont);
//    
//    _imgArr = [NSMutableArray array];
//    [_imgArr addObject:imgArr[imgArr.count-1]];
//    [_imgArr addObjectsFromArray:imgArr];
//    [_imgArr addObject:imgArr[0]];
//    
//    self.oneLab.text = _imgArr[0];
//    self.twoLab.text = _imgArr[_imgArr.count-1];
//    
//    [self loadImageView];
//}
//
//- (void)loadImageView
//{
//    self.scrollVV.contentSize = CGSizeMake(self.width, self.heihh_h*_imgArr.count);
//    
//    for (int i=0; i<_imgArr.count; i++) {
//        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(0, i*self.heihh_h, self.width, self.heihh_h);
//        [btn setTitle:_imgArr[i] forState:UIControlStateNormal];
//        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//        btn.titleLabel.font = SYS_Font(self.maxFont);
//        [self.scrollVV addSubview:btn];
//        btn.backgroundColor = RGB(167, 64, 212);
//    }
//    self.scrollVV.contentOffset = CGPointMake(0, self.heihh_h);
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat contentoffsetX = self.scrollVV.contentOffset.y;
//    CGFloat max = self.heihh_h*(self.imgArr.count-1);
//    if(contentoffsetX <= 0) {
//        CGFloat willOffsetX = self.heihh_h*(self.imgArr.count-2);
//        [self.scrollVV setContentOffset:CGPointMake(0, willOffsetX) animated:NO];
//    }else if (contentoffsetX >= max) {
//        [self.scrollVV setContentOffset:CGPointMake(0, self.heihh_h) animated:NO];
//    }
//    
//    CGFloat yy_y = self.scrollVV.contentOffset.y;
//    int nnn = yy_y/self.heihh_h;
//    int nnn2 = (int)yy_y % self.heihh_h;
//    if(nnn2==0) {
//        if((nnn > 0) && (nnn < self.imgArr.count-1)) {
//            self.oneLab.text = self.imgArr[nnn-1];
//            self.twoLab.text = self.imgArr[nnn+1];
//            if(self.block_) {
//                self.block_(self.imgArr[nnn]);
//            }
//        }
//    }
//}

- (void)dealloc
{
    self.delegate = nil;
}

@end
