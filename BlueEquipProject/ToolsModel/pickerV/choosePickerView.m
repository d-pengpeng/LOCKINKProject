//
//  choosePickerView.m
//  MachineGlory
//
//  东莞梦幻网络科技有限公司 注 on 2021/6/26.
//  Copyright © 2021 time. All rights reserved.
//

#import "choosePickerView.h"
#import "UIView+Frame.h"

@interface choosePickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *myPickerView;
@property (nonatomic, strong) NSMutableArray *arrMuts;
@end

@implementation choosePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        
        self.arrMuts = [NSMutableArray array];
        
        self.myPickerView = [[UIPickerView alloc]init];
        self.myPickerView.frame = self.bounds;
        self.myPickerView.dataSource = self;
        self.myPickerView.delegate = self;
//        self.myPickerView.showsSelectionIndicator = YES;
        self.myPickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.myPickerView];
    }
    return self;
}

- (void)addChooseDataToArr:(NSArray *)arr
{
    [self.arrMuts removeAllObjects];
    for (int i=0; i<arr.count; i++) {
        NSString *name = arr[i];
        if (i==0) {
            NSArray *contArr = @[name, @"1"];
            [self.arrMuts addObject:contArr];
        }else {
            NSArray *contArr = @[name, @"0"];
            [self.arrMuts addObject:contArr];
        }
    }
    
    [self.myPickerView reloadAllComponents];
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
    UIImageView *img_v;
    UILabel *onelab;
    if (!oenv) {
        oenv = [[UIView alloc] init];
        [oenv setBackgroundColor:[UIColor clearColor]];
        
        img_v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/3.0)];
        img_v.clipsToBounds = YES;
        [oenv addSubview:img_v];
        
        onelab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/3.0)];
        onelab.textAlignment = NSTextAlignmentCenter;
        onelab.font = CGFontU_Growth(22);
        onelab.backgroundColor = UIColor.clearColor;
        [oenv addSubview:onelab];
    }
    
    NSArray *contAA = self.arrMuts[row];
    NSString *onest = contAA[0];
    NSString *twost = contAA[1];
    
//    UIView *oenv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/3.0)];
//    oenv.backgroundColor = UIColor.clearColor;
//
//    UIImageView *img_v = [[UIImageView alloc] initWithFrame:oenv.bounds];
//    img_v.clipsToBounds = YES;
//    [oenv addSubview:img_v];
//
//    UILabel *onelab = [[UILabel alloc] initWithFrame:oenv.bounds];
//    onelab.text = onest;
//    onelab.textAlignment = NSTextAlignmentCenter;
//    onelab.font = SYS_Font(24);
//    onelab.backgroundColor = UIColor.clearColor;
//    [oenv addSubview:onelab];
    
    onelab.text = onest;
    
    if ([twost integerValue] > 0) {
        img_v.image = [UIImage imageNamed:@"trainingVideoIcon_1"];
        onelab.textColor = RGB(254, 254, 254);
    }else {
        img_v.image = nil;
        onelab.textColor = GrayTextColor;
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

@end
