//
//  OnlineViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineViewController.h"
#import "OnlineCell.h"

@interface OnlineViewController ()
{
  NSMutableArray *_dataArray;
}
@end

@implementation OnlineViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self sendOnlineRequest];

  UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
  [layout setItemSize:CGSizeMake(self.view.frame.size.width, 200)];
  [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
  self.collectionView.collectionViewLayout = layout;
  
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  
  
  [self.collectionView registerClass:[OnlineCell class] forCellWithReuseIdentifier:@"OnlineCell"];
  [self.collectionView setBackgroundColor:[UIColor blackColor]];
  _dataArray = [NSMutableArray array];
}

- (void)sendOnlineRequest
{
  [self.httpClient getDailyHotOnlinesWithStart:0 count:10 succeeded:^(OnlineArray *onlineArray) {
    [_dataArray addObjectsFromArray:onlineArray.onlines];
    [self.collectionView reloadData];
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

@end
