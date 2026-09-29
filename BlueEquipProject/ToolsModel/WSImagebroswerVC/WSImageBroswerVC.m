//
//  WSImageBroswerVC.m
//  doucui
//
//  Created by 吴振松 on 16/10/12.
//  Copyright © 2016年 lootai. All rights reserved.
//

#import "WSImageBroswerVC.h"
#import "WSImageBroserCell.h"
@interface WSImageBroswerVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation WSImageBroswerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.redNavView = YES;
    self.hideBackBnt = YES;
    [self createNavLeftTitle:eLocalizedString(@"backP_back")];
//    [self createNavRightTitle:@"删除"];
    
    [self initializeView];
    [self initializeData];
}

- (void)backAction:(UIButton *)sender
{
    if(self.imgsCompletion) {
        NSMutableArray *array = [NSMutableArray new];
        for (WSImageModel *model in self.imageArray) {
            [array addObject:model.image];
        }
        self.imgsCompletion(array);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightTitleAction:(UIButton *)sender
{
    if(self.showIndex >= 0 && self.showIndex < self.imageArray.count) {
        [self.imageArray removeObjectAtIndex:self.showIndex];
        [self.collectionView reloadData];
    }
    [self refreshTitle];
    if(self.imageArray.count == 0) {
        [self onClickBack];
    }
}

- (void)onClickBack {
    if(self.imgsCompletion) {
        NSMutableArray *array = [NSMutableArray new];
        for (WSImageModel *model in self.imageArray) {
            [array addObject:model.image];
        }
        self.imgsCompletion(array);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initializeView {
    self.view.backgroundColor = [UIColor blackColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    layout.minimumLineSpacing = 0.0f;
    layout.minimumInteritemSpacing = 0.0f;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT, _window_width, _window_height-NAVHEIGHT) collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[WSImageBroserCell class] forCellWithReuseIdentifier:NSStringFromClass([WSImageBroserCell class])];
    
    [self.view addSubview:self.navView];
}

- (void)initializeData {
    [self.collectionView reloadData];
    if(_showIndex > 0 && _showIndex < _imageArray.count) {
        dispatch_async(dispatch_get_main_queue(), ^{
           [self.collectionView setContentOffset:CGPointMake(_showIndex*self.collectionView.frame.size.width, 0) animated:NO];
        });
    }
    else {
        [self refreshTitle];
    }
}

- (void)refreshTitle {
    NSInteger index = self.collectionView.contentOffset.x/self.collectionView.frame.size.width;
    _showIndex = index;
    index += 1;
    if(index >= 0 && index <= _imageArray.count) {
        self.titleName.text = [NSString stringWithFormat:@"%@/%@",@(index),@(_imageArray.count)];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WSImageBroserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WSImageBroserCell class]) forIndexPath:indexPath];
    if(indexPath.row < _imageArray.count) {
        cell.model = _imageArray[indexPath.row];
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self refreshTitle];
}

@end
