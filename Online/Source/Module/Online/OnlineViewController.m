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
#import "UIColor+Hex.h"
#import "YAUIKit.h"
#import "AppConstant.h"
#import "OnlineDetailController.h"
#import "UltraCollectionViewLayout.h"
#import "LoginViewController.h"
#import "OnlineAccount.h"

#define CELL_IDENTIFIER        @"CollectionCell"
#define ONLINE_FOOTER_IDENTIFIER  @"OnlineFooter"

@interface OnlineViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSString *currentCate;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation OnlineViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.currentCate = @"day";
  [self sendOnlineRequestWithCate:self.currentCate loadMore:NO];
  [self.bodyView addSubview:self.collectionView];
  self.dataArray = [NSMutableArray array];
  [self initRefreshControlRelated];
}

- (UICollectionView *)collectionView
{
  if (!_collectionView) {
    UltraCollectionViewLayout *layout = [[UltraCollectionViewLayout alloc] init];
    layout.expandItemHeight = kOnlineCellHeight;
    layout.shrinkItemHeight = kOnlineCellShrinkHeight;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bodyView.bounds collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    _collectionView.decelerationRate = UIScrollViewDecelerationRateNormal / 10;
    [_collectionView registerClass:[OnlineCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
    [_collectionView registerClass:[UICollectionReusableView class]
        forSupplementaryViewOfKind:collectionKindSectionFooter
               withReuseIdentifier:ONLINE_FOOTER_IDENTIFIER];
  }
  return _collectionView;
}

- (void)initRefreshControlRelated
{
  self.refreshControl = [[YARefreshControl alloc] initWithScrollView:self.collectionView];
  __weak typeof(self) weakSelf = self;
  [self.refreshControl setCanRefreshDirection:kYARefreshableDirectionBottom];
  [self.refreshControl setRefreshHandleAction:^(YARefreshDirection direction) {
    [weakSelf sendOnlineRequestWithCate:weakSelf.currentCate loadMore:YES];
    [weakSelf.refreshControl stopRefreshAtDirection:kYARefreshDirectionBottom animated:YES completion:nil];
  }];
}

- (void)sendOnlineRequestWithCate:(NSString *)cate loadMore:(BOOL)loadMore
{
  __weak typeof(self) weakSelf = self;
  int start = loadMore ? (int)self.dataArray.count : 0;
  [self.httpClient getHotOnlinesByCast:cate start:start count:10 succeeded:^(OnlineArray *onlineArray) {
    if (loadMore) {
      [self.dataArray addObjectsFromArray:onlineArray.onlines];
      [weakSelf.collectionView reloadData];
    } else {
      self.dataArray = [NSMutableArray arrayWithArray:onlineArray.onlines];
      [weakSelf.collectionView setHidden:NO];
      [weakSelf.collectionView reloadData];
      [weakSelf.collectionView setContentOffset:CGPointZero];
    }
  } failed:^(DOUError *error) {
    NSLog(@"%@", error);
  }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  OnlineCell *onlineCell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
  Online *online = [self.dataArray objectAtIndex:indexPath.row];
  [onlineCell configureWithOnline:online];
  return onlineCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  Online *online = [self.dataArray objectAtIndex:indexPath.row];
  OnlineDetailController *controller = [[OnlineDetailController alloc] initWithOnline:online];
  [self.navigationController pushViewController:controller animated:YES];
  [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
  UICollectionReusableView *reusableView =
  [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                     withReuseIdentifier:ONLINE_FOOTER_IDENTIFIER
                                            forIndexPath:indexPath];
  return reusableView;
}


- (void)selectMenuType:(MenuType)menuType
{
  NSString *cate = self.currentCate;
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
    {
      if (![OnlineAccount isLogin]) {
        LoginViewController *controller = [[LoginViewController alloc] initWithNibName:@"LoginView" bundle:nil];
        [self.navigationController pushViewController:controller animated:YES];
      }
    }
      break;
    default:
      break;
  }
  if (![cate isEqualToString:self.currentCate]) {
    self.currentCate = cate;
    [self sendOnlineRequestWithCate:self.currentCate loadMore:NO];
  }
  [self changeMenuViewType:menuType];
}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGPoint point = scrollView.contentOffset;
  UltraCollectionViewLayout *layout = (UltraCollectionViewLayout *)self.collectionView.collectionViewLayout;
  CGPoint anotherPoint = CGPointMake(point.x, point.y + kOnlineCellHeight - kOnlineCellShrinkHeight + 50);
  NSIndexPath *path = [self.collectionView indexPathForItemAtPoint:anotherPoint];
  if (point.y <= layout.shrinkItemHeight) {
    path = [NSIndexPath indexPathForRow:0 inSection:0];
  }
  
  [self.collectionView performBatchUpdates:^{
    [layout setShowingIndex:path.item];
  } completion:nil];
  
  [self.collectionView scrollToItemAtIndexPath:path
                              atScrollPosition:UICollectionViewScrollPositionLeft
                                      animated:NO];
}
*/

@end
