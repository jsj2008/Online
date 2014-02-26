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

  self.tableView = [[UITableView alloc] initWithFrame:self.bodyView.frame];
  [self.bodyView addSubview:self.tableView];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  [self.tableView setBackgroundColor:[UIColor colorWithHex:0x24282F alpha:1.0f]];
  _dataArray = [NSMutableArray array];
  _showingIndex = 0;
}

- (void)sendOnlineRequestWithCate:(NSString *)cate
{
  __weak typeof(self) weakSelf = self;
  [self.httpClient getHotOnlinesByCast:cate start:0 count:10 succeeded:^(OnlineArray *onlineArray) {
    _dataArray = [NSMutableArray arrayWithArray:onlineArray.onlines];
    [weakSelf.tableView reloadData];
  } failed:^(DOUError *error) {
    NSLog(@"%@", error);
  }];
}

#pragma mark - UICollectionView Data Source Methods
// Default is one
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  OnlineCell *onlineCell = [tableView dequeueReusableCellWithIdentifier:@"OnlineCell"];
  if (!onlineCell) {
    onlineCell = [[OnlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OnlineCell"];
  }
  Online *online = [_dataArray objectAtIndex:indexPath.row];
  [onlineCell configureWithOnline:online];
  return onlineCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 200;
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
