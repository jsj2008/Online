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

@interface OnlineViewController ()
{
  NSMutableArray *_dataArray;
}
@property (nonatomic, strong) NSString *currentCate;
@property (assign, nonatomic) CATransform3D initialTransformation;
@property (nonatomic, strong) NSMutableSet *shownIndexes;
@property (nonatomic, strong) YARefreshControl *refreshControl;


@end

@implementation OnlineViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.currentCate = @"day";
  [self sendOnlineRequestWithCate:self.currentCate loadMore:NO];

  self.tableView = [[UITableView alloc] initWithFrame:self.bodyView.frame];
  [self.bodyView addSubview:self.tableView];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  self.tableView.rowHeight = kOnlineCellHeight;
  [self.tableView setHidden:YES];
  _dataArray = [NSMutableArray array];
  [self initAnimationRelated];
  [self initRefreshControlRelated];
}

- (void)initAnimationRelated
{
  CGFloat rotationAngleDegrees = -15;
  CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
  CGPoint offsetPositioning = CGPointMake(-20, -20);
  
  CATransform3D transform = CATransform3DIdentity;
  transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
  transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
  _initialTransformation = transform;
  
  _shownIndexes = [NSMutableSet set];
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
  int start = loadMore ? _dataArray.count : 0;
  [self.httpClient getHotOnlinesByCast:cate start:start count:10 succeeded:^(OnlineArray *onlineArray) {
    if (loadMore) {
      [_dataArray addObjectsFromArray:onlineArray.onlines];
      [weakSelf.tableView reloadData];
    } else {
      _dataArray = [NSMutableArray arrayWithArray:onlineArray.onlines];
      _shownIndexes = [NSMutableSet set];
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (![self.shownIndexes containsObject:indexPath]) {
    [self.shownIndexes addObject:indexPath];
    
    UIView *card = [(OnlineCell* )cell mainView];
    
    card.layer.transform = self.initialTransformation;
    card.layer.opacity = 0.8;
    
    [UIView animateWithDuration:0.4 animations:^{
      card.layer.transform = CATransform3DIdentity;
      card.layer.opacity = 1;
    }];
  }
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

- (YARefreshControl *)refreshControl
{
  if (!_refreshControl) {
    _refreshControl = [[YARefreshControl alloc] initWithScrollView:self.tableView];
  }
  return _refreshControl;
}

@end
