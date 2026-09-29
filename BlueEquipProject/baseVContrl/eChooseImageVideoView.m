//
//  eChooseImageVideoView.m
//  yunbaolive
//
//  Created by Edwin on 2020/10/14.
//  Copyright © 2020 cat. All rights reserved.
//

#import "eChooseImageVideoView.h"
#import "ePhotoSubViewCell.h"
#import "UIView+Frame.h"
#import "LFResultVideo.h"
#import "WSImageModel.h"

static NSString *chooseImageVideoCellIdentifier = @"chooseImageVideoCellIdentifier";

@interface eChooseImageVideoView()<UICollectionViewDelegate,UICollectionViewDataSource, ePhotoSubViewCellDelegate>
{
    NSMutableArray *_photosArray;
    NSMutableArray *_videoArray;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) eChooseImageVideoConfig *config;
@property (nonatomic, assign) BOOL isVideoBoo;
@end

@implementation eChooseImageVideoView

- (instancetype)initWithFrame:(CGRect)frame config:(eChooseImageVideoConfig *)config{
    if(self = [super initWithFrame:frame]) {
        _config = (config != nil)?config:([eChooseImageVideoConfig new]);
        [self setupView];
        [self initializeData];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = _config.itemSize;
    layout.sectionInset = _config.sectionInset;
    layout.minimumLineSpacing = _config.minimumLineSpacing;
    layout.minimumInteritemSpacing = _config.minimumInteritemSpacing;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.clipsToBounds = YES;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_collectionView];
    [_collectionView reloadData];
    
    [_collectionView registerClass:[ePhotoSubViewCell class] forCellWithReuseIdentifier:@"ePhotoSubViewCell"];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:chooseImageVideoCellIdentifier];
}

- (void)initializeData {
    _photosArray = [NSMutableArray array];
}

- (void)refreshCollectionView {
    NSInteger n;
    CGFloat width = _collectionView.frame.size.width - _config.sectionInset.left - _config.sectionInset.right;
    n = (width + _config.minimumInteritemSpacing)/(_config.itemSize.width + _config.minimumInteritemSpacing);
    CGFloat height = ((NSInteger)(_photosArray.count)/n +1) * (_config.itemSize.height + _config.minimumLineSpacing);
    height -= _config.minimumLineSpacing;
    height += _config.sectionInset.top;
    height += _config.sectionInset.bottom;
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    [_collectionView reloadData];
    if(self.viewHeightChanged) {
        self.viewHeightChanged(height);
    }
}

- (void)refreshPhotoOrVideoArray:(NSArray *)array isVideo:(BOOL)boo
{
    self.isVideoBoo = boo;
    [_photosArray removeAllObjects];
    [_photosArray addObjectsFromArray:array];
    [self refreshCollectionView];
}

#pragma make - collectionViewDelegate -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.isVideoBoo) {
        if(_photosArray.count < _config.photosMaxCount) {
            if (_photosArray.count > 0) {
                return _photosArray.count;
            }else {
                return _photosArray.count + 1;
            }
        }else {
            return _photosArray.count;
        }
    }else {
        if(_photosArray.count < _config.photosMaxCount) {
            return _photosArray.count + 1;
        }else {
            return _photosArray.count;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row < _photosArray.count) {
      
        ePhotoSubViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ePhotoSubViewCell" forIndexPath:indexPath];
        cell.model = _photosArray[indexPath.row];
        cell.delegate = self;
        cell.numP = indexPath.row;
        return cell;
    }else {
        if(_photosArray.count < _config.photosMaxCount) {
            if (self.isVideoBoo) {
                if (_photosArray.count > 0) {
                    return nil;
                }else {
                    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:chooseImageVideoCellIdentifier forIndexPath:indexPath];
                    [cell removeAllSubviews];
                    UIImageView *imgViewL = [[UIImageView alloc] initWithFrame:cell.bounds];
                    imgViewL.contentMode = UIViewContentModeScaleAspectFill;
                    imgViewL.clipsToBounds = YES;
                    [cell addSubview:imgViewL];
                    imgViewL.image = [UIImage imageNamed:@"circle_pic_add"];
                    return cell;
                }
            }else {
                UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:chooseImageVideoCellIdentifier forIndexPath:indexPath];
                [cell removeAllSubviews];
                UIImageView *imgViewL = [[UIImageView alloc] initWithFrame:cell.bounds];
                imgViewL.contentMode = UIViewContentModeScaleAspectFill;
                imgViewL.clipsToBounds = YES;
                [cell addSubview:imgViewL];
                imgViewL.image = [UIImage imageNamed:@"circle_pic_add"];//eImgB
                return cell;
            }
        }else {
            return nil;
        }
    }
}

- (void)cellDidDeleteClcik:(NSInteger)inpNum
{
    
    [_photosArray removeObjectAtIndex:inpNum];
    [self refreshCollectionView];
    if ([_delegate_ respondsToSelector:@selector(eChooseImageVideoDelete:)]) {
        [_delegate_ eChooseImageVideoDelete:inpNum];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row < _photosArray.count) {
        
        if (self.isVideoBoo) {
            LFResultVideo *image = _photosArray[indexPath.row];
            if ([_delegate_ respondsToSelector:@selector(eChooseImageVideoUrl:)]) {
                [_delegate_ eChooseImageVideoUrl:image.url];
            }
        }else {
            NSMutableArray *tmpArray = [NSMutableArray new];
            for (LFResultVideo *image in _photosArray) {
                WSImageModel *model = [WSImageModel new];
                model.image = image.smallImage;
                [tmpArray addObject:model];
            }
            if ([_delegate_ respondsToSelector:@selector(eChooseImagessArr:inpNum:)]) {
                [_delegate_ eChooseImagessArr:tmpArray inpNum:indexPath.row];
            }
        }
    }
    else {
        if ([_delegate_ respondsToSelector:@selector(pickPhotosChoose:)]) {
            [_delegate_ pickPhotosChoose:self.typeNN];
        }
    }
}

- (NSArray *)getPhotos
{
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (LFResultVideo *image in _photosArray) {
        [tmpArray addObject:image.smallImage];
    }
    
    return tmpArray;
}

@end

@implementation eChooseImageVideoConfig

- (instancetype)init {
    if(self = [super init]) {
        _itemSize = CGSizeMake((_window_width-20-9)/4.0, (_window_width-20-9)/4.0);
        _sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _minimumLineSpacing = 5.0f;
        _minimumInteritemSpacing = 3.0f;
        _photosMaxCount = 8;
    }
    return self;
}

@end
