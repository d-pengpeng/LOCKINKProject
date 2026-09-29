//
//  ELMoreView.m
//  ELKeyboard
//
//  Created by Parkin on 2017/6/29.
//  Copyright © 2017年 Parkin. All rights reserved.
//

#import "ELMoreView.h"
#import "ELMoreCell.h"

@interface ELMoreView ()

@property (nonatomic, copy) NSArray *imgArray;

@end

@implementation ELMoreView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.img_vv = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 90, 90)];
        self.img_vv.layer.cornerRadius = 8;
        self.img_vv.clipsToBounds = YES;
        self.img_vv.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.img_vv];
        
//        [self initializa];
    }
    
    return self;
}

//- (void)initializa
//{
//    _imgArray = @[@"sharemore_pic", @"sharemore_video", @"sharemore_location", @"sp", @"yy"];
//
//    ELCVFlowLayout *flowLayout = [[ELCVFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(self.width / 4.0, self.width / 4.0);
//
//    _moreCV = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
//    _moreCV.backgroundColor = RGB(237, 237, 246);
//    _moreCV.delegate = self;
//    _moreCV.dataSource = self;
//    [self addSubview:_moreCV];
//
//    [_moreCV registerClass:[ELMoreCell class] forCellWithReuseIdentifier:@"ELMoreCell"];
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return _imgArray.count;
//}
//
//// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    ELMoreCell *moreCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ELMoreCell" forIndexPath:indexPath];
//    moreCell.imgView.image = [UIImage imageNamed:_imgArray[indexPath.row]];
//    return moreCell;
//}



@end
