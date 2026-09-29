//
//  HYBLoopScrollView.m
//  HYBLoopScrollView
//
//  Created by huangyibiao on 15/4/1.
//  Copyright (c) 2015年 huangyibiao. All rights reserved.
//

#import "HYBLoopScrollView.h"
#import <objc/message.h>
#import "HYBVideoCollectionCell.h"
NSString * const kCellIdentifier = @"ReuseCellIdentifier";

/**
 *  CollectionView for ad.
 */
@interface HYBCollectionCell : UICollectionViewCell

@property (nonatomic, strong) HYBLoadImageView *imageView;
@property (nonatomic, strong) UILabel          *titleLabel;
@property (nonatomic, assign) BOOL             isDragging;
@end

@implementation HYBCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.imageView = [[HYBLoadImageView alloc] init];
    [self addSubview:self.imageView];
    self.imageView.isCircle = YES;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.titleLabel.hidden = YES;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.titleLabel];
    self.titleLabel.layer.masksToBounds = YES;
  }
  
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  self.imageView.frame = self.bounds;
  self.titleLabel.frame = CGRectMake(0, self.hyb_height - 30, self.hyb_width, 30);
  self.titleLabel.hidden = self.titleLabel.text.length > 0 ? NO : YES;
}

@end

@interface HYBLoopScrollView () <UICollectionViewDataSource, UICollectionViewDelegate> {
  HYBPageControl *_pageControl;
}

//@property (nonatomic, copy) HYBLoopScrollViewDidSelectItemBlock didSelectItemBlock;
@property (nonatomic, copy) HYBLoopScrollViewDidScrollBlock didScrollBlock;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, assign) CFRunLoopTimerRef timer;
@property (nonatomic, assign) NSInteger totalPageCount;

@property (nonatomic, assign) NSInteger previousPageIndex;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, assign) int selPP;
@property (nonatomic, strong) HYBVideoCollectionCell *Video_CollectionCell;

@property (nonatomic, strong) UISlider *videoProgress;//播放进度

@property (nonatomic, assign) BOOL isSeeShow;
@end

@implementation HYBLoopScrollView

- (void)dealloc {
  //  NSLog(@"hybloopscrollview dealloc");
  [[NSNotificationCenter defaultCenter] removeObserver:[UIApplication sharedApplication]
                                                  name:UIApplicationDidReceiveMemoryWarningNotification
                                                object:nil];
}

- (void)pauseTimer {
  if (self.timer) {
    CFRunLoopTimerInvalidate(self.timer);
    CFRunLoopRemoveTimer(CFRunLoopGetCurrent(), self.timer, kCFRunLoopCommonModes);
  }
}

-(void)clearTimer{
    
}

- (void)startTimer {
  [self configTimer];
}

- (void)stopBannarVideo
{
    [self pauseTimer];
    if(self.Video_CollectionCell) {
        [self.Video_CollectionCell stopVideoBoo];
    }
}

- (HYBPageControl *)pageControl {
  return _pageControl;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  [super setBackgroundColor:backgroundColor];
  
  self.collectionView.backgroundColor = backgroundColor;
}

- (void)removeFromSuperview {
  [self pauseTimer];
  
  [super removeFromSuperview];
}

+ (instancetype)loopScrollViewWithFrame:(CGRect)frame
                              imageUrls:(NSArray *)imageUrls
                           timeInterval:(NSTimeInterval)timeInterval
                              didSelect:(HYBLoopScrollViewDidSelectItemBlock)didSelect
                              didScroll:(HYBLoopScrollViewDidScrollBlock)didScroll {
  HYBLoopScrollView *loopView = [[HYBLoopScrollView alloc] initWithFrame:frame];
  loopView.imageUrls = imageUrls;
  loopView.timeInterval = timeInterval;
  loopView.didScrollBlock = didScroll;
  loopView.didSelectItemBlock = didSelect;
  
  return loopView;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.timeInterval = 5.0;
    self.alignment = kPageControlAlignCenter;
    [self configCollectionView];
    self.imageContentMode = UIViewContentModeScaleAspectFill;
    
    [[NSNotificationCenter defaultCenter] addObserver:[UIApplication sharedApplication]
                                             selector:NSSelectorFromString(@"hyb_clearCache")
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
      
    [self addSubview:self.lab_pageController];
      
      
      _videoProgress = [[UISlider alloc] initWithFrame:CGRectMake(20, self.frame.size.height-40, self.frame.size.width-40, 40)];
      [_videoProgress addTarget:self action:@selector(onClickSeekAction:) forControlEvents:UIControlEventValueChanged];
      [_videoProgress addTarget:self action:@selector(onClickSeekTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:self.videoProgress];
      self.videoProgress.hidden = YES;
  }
  return self;
}

- (void)onClickSeekTouchUpInside:(UISlider *)slider
{
    NSLog(@"11_11-%.0f", slider.value);
    
    [self.Video_CollectionCell seeToFloatMehtod:slider.value];
}

- (void)onClickSeekAction:(UISlider *)slider {
    NSLog(@"11_22-%.0f", slider.value);
    self.isSeeShow = YES;
    
}


-(UILabel *)lab_pageController{
    if (_lab_pageController == nil) {
        _lab_pageController = [[UILabel alloc]initWithFrame:CGRectMake(_window_width/2.0-100/2.0, self.hyb_height-30, 100, 30)];
        _lab_pageController.font = SYS_Font(15);
        _lab_pageController.textAlignment = NSTextAlignmentRight;
        _lab_pageController.textColor = [UIColor redColor];
        
    }
    return _lab_pageController;
}

- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  
  self.layout.itemSize = frame.size;
}

- (void)configCollectionView {
  self.layout = [[UICollectionViewFlowLayout alloc] init];
  self.layout .itemSize = self.bounds.size;
  self.layout .minimumLineSpacing = 0;
  self.layout .scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.frame
                                           collectionViewLayout:self.layout];
  self.collectionView.backgroundColor = [UIColor lightGrayColor];
  self.collectionView.pagingEnabled = YES;
  self.collectionView.showsHorizontalScrollIndicator = NO;
  self.collectionView.showsVerticalScrollIndicator = NO;
  [self.collectionView registerClass:[HYBCollectionCell class]
           forCellWithReuseIdentifier:kCellIdentifier];
    [self.collectionView registerClass:[HYBVideoCollectionCell class]
             forCellWithReuseIdentifier:@"HYBVideoCollectionCell"];
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  [self addSubview:self.collectionView];
}

- (void)configTimer {
  if (images.count <= 1) {
    return;
  }
  
  if (self.timer) {
    CFRunLoopTimerInvalidate(self.timer);
    CFRunLoopRemoveTimer(CFRunLoopGetCurrent(), self.timer, kCFRunLoopCommonModes);
  }
  
  __weak __typeof(self) weakSelf = self;
  CFRunLoopTimerRef timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + _timeInterval, _timeInterval, 0, 0, ^(CFRunLoopTimerRef timer) {
    [weakSelf autoScroll];
  });
  
  self.timer = timer;
  CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes);
}

- (void)setPageControlEnabled:(BOOL)pageControlEnabled {
  if (_pageControlEnabled != pageControlEnabled) {
    _pageControlEnabled = pageControlEnabled;
    
    if (_pageControlEnabled) {
      __weak __typeof(self) weakSelf = self;
      self.pageControl.valueChangedBlock = ^(NSInteger clickedAtIndex) {
        // 往左
        NSInteger count = clickedAtIndex - weakSelf.pageControl.currentPage;

        NSInteger toIndex = count + self.previousPageIndex;
        NSIndexPath *indexPath = nil;
        if (toIndex == weakSelf.totalPageCount) {
          toIndex = weakSelf.totalPageCount * 0.5;
          
          // scroll to the middle without animation, and scroll to middle with animation, so that it scrolls
          // more smoothly.
          indexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
          [weakSelf.collectionView scrollToItemAtIndexPath:indexPath
                                      atScrollPosition:UICollectionViewScrollPositionNone
                                              animated:NO];
        } else {
          indexPath = [NSIndexPath indexPathForItem:count > 0 ? toIndex - 1 : toIndex + 1 inSection:0];
          [weakSelf.collectionView scrollToItemAtIndexPath:indexPath
                                          atScrollPosition:UICollectionViewScrollPositionNone
                                                  animated:NO];

          indexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
        }
        
        [weakSelf.collectionView scrollToItemAtIndexPath:indexPath
                                    atScrollPosition:UICollectionViewScrollPositionNone
                                            animated:YES];
        
        [weakSelf.pageControl updateCurrentPageDisplay];
      };
    } else {
      self.pageControl.valueChangedBlock = nil;
    }
  }
}

- (void)configPageControl {
  if (_pageControl == nil) {
    _pageControl = [[HYBPageControl alloc] init];
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
    self.pageControlEnabled = YES;
  }
  
  
  
  CGSize size = [self.pageControl sizeForNumberOfPages:(images.count + 2)];
  self.pageControl.hyb_size = size;
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
  
  if (self.alignment == kPageControlAlignCenter) {
//    self.pageControl.hyb_originX = (self.hyb_width - self.pageControl.hyb_width) / 2.0;
      self.pageControl.frame = CGRectMake(0, self.hyb_height-40, self.hyb_width, 40);
      
  } else if (self.alignment == kPageControlAlignRight) {
    self.pageControl.hyb_rightX = self.hyb_width;
  }
//  self.pageControl.hyb_originY = self.hyb_height - self.pageControl.hyb_height + 5;
    
    [self bringSubviewToFront:self.pageControl];
    
    
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
  _timeInterval = timeInterval;
  
  [self configTimer];
}

- (void)autoScroll {
    if(self.isVideoBoo){
        return;
    }
  NSInteger curIndex = (self.collectionView.contentOffset.x + self.layout.itemSize.width * 0.5) / self.layout.itemSize.width;
  NSInteger toIndex = curIndex + 1;
  
  NSIndexPath *indexPath = nil;
  if (toIndex == self.totalPageCount) {
    toIndex = self.totalPageCount * 0.5;
    
    // scroll to the middle without animation, and scroll to middle with animation, so that it scrolls
    // more smoothly.
    indexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:NO];
  } else {
    indexPath = [NSIndexPath indexPathForItem:toIndex inSection:0];
  }
  
  [self.collectionView scrollToItemAtIndexPath:indexPath
                              atScrollPosition:UICollectionViewScrollPositionNone
                                      animated:YES];
  
}

- (void)setImageUrls:(NSArray *)imageUrls {
  if (![imageUrls isKindOfClass:[NSArray class]]) {
    return;
  }
  
  if (imageUrls == nil || imageUrls.count == 0) {
    self.collectionView.scrollEnabled = NO;
    [self pauseTimer];
//    [self configPageControl];
      images = @[];
    self.totalPageCount = 0;
    [self configPageControl];
    [self.collectionView reloadData];
    return;
  }
  
//  if (images != imageUrls) {
    images = imageUrls;
    
    if (imageUrls.count > 1) {
      self.totalPageCount = imageUrls.count * 50;
      [self configTimer];
      [self configPageControl];
      self.collectionView.scrollEnabled = YES;
    } else {
      // If there is only one page, stop the timer and make scroll enabled to be NO.
      [self pauseTimer];
      
      self.totalPageCount = 1;
      [self configPageControl];
      self.collectionView.scrollEnabled = NO;
    }
    
    [self.collectionView reloadData];
//  }
    
    if(self.isVideoBoo) {
        self.selPP = 0;
    }
    
}

-(void)setItems:(NSArray *)items{
    _items = items;
}

-(void)setPlaceholder:(UIImage *)placeholder{
    
    _placeholder = placeholder;
//    self.imageUrls = @[@"http://"];
//    self.totalPageCount = self.imageUrls.count;
//    [self.collectionView reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.totalPageCount == 0) {
    return;
    }

    self.layout.itemSize = self.hyb_size;

    self.collectionView.frame = self.bounds;
    self.videoProgress.frame = CGRectMake(20, self.bounds.size.height-80, self.bounds.size.width-40, 40);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.totalPageCount * 0.5
                                               inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath
                              atScrollPosition:UICollectionViewScrollPositionNone
                                      animated:NO];

    [self configPageControl];
}

- (void)setAlignment:(HYBPageControlAlignment)alignment {
  if (_alignment != alignment) {
    _alignment = alignment;
    
    [self configPageControl];
    [self.collectionView reloadData];
  }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return self.totalPageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger itemIndex = indexPath.item % images.count;
//    if(self.isVideoBoo && (itemIndex == 0)) {
//
//        HYBVideoCollectionCell *cell = (HYBVideoCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HYBVideoCollectionCell" forIndexPath:indexPath];
//        NSInteger itemIndex = indexPath.item % images.count;
//        if (itemIndex < images.count) {
//          NSString *urlString = images[itemIndex];
//          if ([urlString hasPrefix:@"http://"] || [urlString hasPrefix:@"https://"] || [urlString rangeOfString:@"/"].location != NSNotFound) {
//
//              NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//              cell.video_url = self.video_url;
//              [cell addUIUIDic:@{@"img":urlStr}];
//
//              self.Video_CollectionCell = cell;
//
//              cell.block_ = ^(BOOL boo, float fl_num, float fl_all) {
//
//                  if(!self.isSeeShow) {
//                      self.videoProgress.hidden = boo;
//                      self.videoProgress.maximumValue = fl_all;
//                      self.videoProgress.value = fl_num;
//                  }
//              };
//              cell.twoblock_ = ^(BOOL boo) {
//                  self.isSeeShow = boo;
//              };
//              cell.thrblock_ = ^{
//
//                  UIImageView *vvv_IMg = [[UIImageView alloc] init];
//                  if (self.didSelectItemBlock) {
//                      self.didSelectItemBlock(0,self->images,vvv_IMg);
//                  }
//              };
//          }
//        }
//
//        return cell;
//    }else {
        HYBCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
        
        // 先取消之前的请求
        HYBLoadImageView *preImageView = cell.imageView;
        cell.imageView.contentMode = self.imageContentMode;
        preImageView.shouldAutoClipImageToViewSize = self.shouldAutoClipImageToViewSize;
        
        if ([preImageView isKindOfClass:[HYBLoadImageView class]]) {
          [preImageView cancelRequest];
        }
        
        if (itemIndex < images.count) {
          NSString *urlString = images[itemIndex];
          if ([urlString isKindOfClass:[UIImage class]]) {
            cell.imageView.image = (UIImage *)urlString;
          } else if ([urlString hasPrefix:@"http://"]
                     || [urlString hasPrefix:@"https://"]
                     || [urlString rangeOfString:@"/"].location != NSNotFound) {
              
              NSString *urlStr = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cell.imageView setImageWithURLString:urlStr placeholder:_placeholder];
          } else {
              if (urlString.length == 0) {
                  cell.imageView.image = _placeholder;
              }else{
                  cell.imageView.image = [UIImage imageNamed:urlString];
              }
          }
        }
          //设置占位图
          if (images.count == 0) {
               cell.imageView.image = _placeholder;
          }
        if (self.alignment == kPageControlAlignRight && itemIndex < self.adTitles.count) {
          cell.titleLabel.text = [NSString stringWithFormat:@"   %@", self.adTitles[itemIndex]];
        }
        return cell;
//    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  if (self.totalPageCount == 0) {
    return;
  }
    HYBCollectionCell *cell = (HYBCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
  if (self.didSelectItemBlock) {
    self.didSelectItemBlock(indexPath.item % images.count,images,cell.imageView);
  }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (self.totalPageCount == 0) {
    return;
  }
  
  int itemIndex = (scrollView.contentOffset.x +
                   self.collectionView.hyb_width * 0.5) / self.collectionView.hyb_width;
  itemIndex = itemIndex % images.count;
    
  _pageControl.currentPage = itemIndex;
    self.lab_pageController.text = [NSString stringWithFormat:@"%d/%ld",itemIndex+1,images.count];
  // record
  self.previousPageIndex = itemIndex;
  
  CGFloat x = scrollView.contentOffset.x - self.collectionView.hyb_width;
  NSUInteger index = fabs(x) / self.collectionView.hyb_width;
  CGFloat fIndex = fabs(x) / self.collectionView.hyb_width;
  
  if (self.didScrollBlock && fabs(fIndex - (CGFloat)index) <= 0.00001) {
    self.didScrollBlock(itemIndex);
  }
    if(self.isVideoBoo) {
        NSLog(@"--第几个页面--%d", itemIndex);
        if(self.selPP != itemIndex) {
            self.selPP = itemIndex;
            if(self.selPP != 0) {
                [self.Video_CollectionCell pauseResumeVideoBoo:NO];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  [self pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  [self startTimer];
}

- (void)clearImagesCache {
  // 放在了非公开的扩展中，但是方法是存在的
  if ([[UIApplication sharedApplication] respondsToSelector:NSSelectorFromString(@"hyb_clearDiskCaches")]) {
    ((void (*)(id, SEL))objc_msgSend)([UIApplication sharedApplication], NSSelectorFromString(@"hyb_clearDiskCaches"));
  }
}

- (unsigned long long)imagesCacheSize {
//  NSString *directoryPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/HYBLoopScollViewImages"];
    NSArray *pathArrayF = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *pathF = [pathArrayF objectAtIndex:0];
    //获取文件的完整路径
    NSString *directoryPath = [pathF stringByAppendingPathComponent:@"HYBLoopScollViewImages"];
    BOOL isDir = NO;
    unsigned long long total = 0;
  
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        
        if (isDir) {
            
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            if (error == nil) {
                for (NSString *subpath in array) {
                  NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                  NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    return total;
}

@end
