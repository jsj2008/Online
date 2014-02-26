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

@interface OnlineViewController ()

@property (nonatomic, strong) NSString *currentCate;

@end

@implementation OnlineViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.currentCate = @"day";
  [self sendOnlineRequestWithCate:self.currentCate loadMore:NO];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  self.tableView.rowHeight = kOnlineCellHeight;
  [self.tableView setHidden:YES];
  [self initRefreshControlRelated];
}

- (void)initRefreshControlRelated
{
  __weak typeof(self) weakSelf = self;
  [self.refreshControl setCanRefreshDirection:kYARefreshableDirectionBottom];
  [self.refreshControl setRefreshHandleAction:^(YARefreshDirection direction) {
    [weakSelf sendOnlineRequestWithCate:weakSelf.currentCate loadMore:YES];
  }];
}

- (void)sendOnlineRequestWithCate:(NSString *)cate loadMore:(BOOL)loadMore
{
  __weak typeof(self) weakSelf = self;
  int start = loadMore ? self.dataArray.count : 0;
  [self.httpClient getHotOnlinesByCast:cate start:start count:10 succeeded:^(OnlineArray *onlineArray) {
    if (loadMore) {
      [self.dataArray addObjectsFromArray:onlineArray.onlines];
      [weakSelf.tableView reloadData];
    } else {
      self.dataArray = [NSMutableArray arrayWithArray:onlineArray.onlines];
      self.shownIndexes = [NSMutableSet set];
      [weakSelf.tableView setHidden:NO];
      [weakSelf.tableView reloadData];
      [weakSelf.tableView setContentOffset:CGPointZero];
    }
  } failed:^(DOUError *error) {
    NSLog(@"%@", error);
  }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  OnlineCell *onlineCell = [tableView dequeueReusableCellWithIdentifier:@"OnlineCell"];
  if (!onlineCell) {
    onlineCell = [[OnlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OnlineCell"];
  }
  Online *online = [self.dataArray objectAtIndex:indexPath.row];
  [onlineCell configureWithOnline:online];
  return onlineCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  Online *online = [self.dataArray objectAtIndex:indexPath.row];
  OnlineDetailController *controller = [[OnlineDetailController alloc] initWithOnline:online];
  [self.navigationController pushViewController:controller animated:YES];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
