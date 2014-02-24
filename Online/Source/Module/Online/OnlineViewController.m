//
//  OnlineViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineViewController.h"
#import "OnlineCell.h"
#import "LessBoringFlowLayout.h"

@interface OnlineViewController ()
{
  NSMutableArray *_dataArray;
  NSInteger _showingIndex;
  NSString *_currentCate;
}
@end

@implementation OnlineViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  _currentCate = @"day";
  [self sendOnlineRequestWithCate:_currentCate];

  UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
  
  layout.minimumInteritemSpacing = 10.f;
  layout.minimumLineSpacing = 10.f;
  layout.itemSize = CGSizeMake(self.view.frame.size.width - 20, 200);
  [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.bodyView.frame collectionViewLayout:layout];
  [self.bodyView addSubview:self.collectionView];
  
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  
  [self.collectionView registerClass:[OnlineCell class] forCellWithReuseIdentifier:@"OnlineCell"];
  [self.collectionView setBackgroundColor:[UIColor blackColor]];
  _dataArray = [NSMutableArray array];
  _showingIndex = 0;
}

- (void)sendOnlineRequestWithCate:(NSString *)cate
{
  __weak typeof(self) weakSelf = self;
  [self.httpClient getHotOnlinesByCast:cate start:0 count:10 succeeded:^(OnlineArray *onlineArray) {
    _dataArray = [NSMutableArray arrayWithArray:onlineArray.onlines];
    [weakSelf.collectionView reloadData];
  } failed:^(DOUError *error) {
    NSLog(@"%@", error);
  }];
}

#pragma mark - UICollectionView Data Source Methods
// Default is one
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
  OnlineCell *onlineCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OnlineCell" forIndexPath:indexPath];
  if (!onlineCell) {
    onlineCell = [[OnlineCell alloc] init];
  }
  Online *online = [_dataArray objectAtIndex:indexPath.row];
  [onlineCell configureWithOnline:online];
  return onlineCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == _showingIndex) {
    return CGSizeMake(self.view.frame.size.width, 320);
  } else {
    return CGSizeMake(self.view.frame.size.width, 200);
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGPoint point = scrollView.contentOffset;
  point.y += 200;
  NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
  if (indexPath.row != _showingIndex) {
    _showingIndex = indexPath.row;

    [self.collectionView performBatchUpdates:^{
      [self.collectionView reloadData];
    } completion:^(BOOL finished) {}];
  }
}

- (void)selectMenuType:(MenuType)menuType
{
  NSString *cate = _currentCate;
  switch (menuType) {
    case kGuessYouLike:

      break;
    case kTodayHotOnline:
      cate = @"day";
      break;
    case kLatestOnline:
      cate = @"latest";
      break;
    case kWeekHotOnline:
      cate = @"week";
      break;
    case kProfile:
      
      break;
    default:
      break;
  }
  if (![cate isEqualToString:_currentCate]) {
    _currentCate = cate;
    [self sendOnlineRequestWithCate:_currentCate];
  }
  [self changeMenuViewType:menuType];
}

@end
