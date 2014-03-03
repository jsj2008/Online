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

#define CELL_IDENTIFIER        @"CollectionCell"

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
  [self.collectionView setHidden:YES];
  
  self.dataArray = [NSMutableArray array];
}

- (UICollectionView *)collectionView
{
  if (!_collectionView) {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(300, 200);
    //layout.expandItemHeight = 300;
    //layout.shrinkItemHeight = 120;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bodyView.bounds collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    _collectionView.decelerationRate = UIScrollViewDecelerationRateNormal / 10;
    [_collectionView registerClass:[OnlineCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
  }
  return _collectionView;
}


/*
- (void)initRefreshControlRelated
{
  __weak typeof(self) weakSelf = self;
  [self.refreshControl setCanRefreshDirection:kYARefreshableDirectionBottom];
  [self.refreshControl setRefreshHandleAction:^(YARefreshDirection direction) {
    [weakSelf sendOnlineRequestWithCate:weakSelf.currentCate loadMore:YES];
    [weakSelf.refreshControl stopRefreshAtDirection:kYARefreshDirectionBottom animated:YES completion:nil];
  }];
}
*/
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


@end
