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
  NSString *_currentCate;
}
@property (assign, nonatomic) CATransform3D initialTransformation;
@property (nonatomic, strong) NSMutableSet *shownIndexes;
@end

@implementation OnlineViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  _currentCate = @"day";
  [self sendOnlineRequestWithCate:_currentCate loadMore:NO];

  self.tableView = [[UITableView alloc] initWithFrame:self.bodyView.frame];
  [self.bodyView addSubview:self.tableView];
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  [self.tableView setBackgroundColor:[UIColor colorWithHex:0x24282F alpha:1.0f]];
  [self.tableView setHidden:YES];
  _dataArray = [NSMutableArray array];
  [self initAnimationRelated];
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

- (void)sendOnlineRequestWithCate:(NSString *)cate loadMore:(BOOL)loadMore
{
  __weak typeof(self) weakSelf = self;
  [self.httpClient getHotOnlinesByCast:cate start:0 count:10 succeeded:^(OnlineArray *onlineArray) {
    if (loadMore) {
      [_dataArray addObjectsFromArray:onlineArray.onlines];
    } else {
      _dataArray = [NSMutableArray arrayWithArray:onlineArray.onlines];
      _shownIndexes = [NSMutableSet set];
    }
    [weakSelf.tableView setHidden:NO];
    [weakSelf.tableView reloadData];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 200;
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
    [self sendOnlineRequestWithCate:_currentCate loadMore:NO];
  }
  [self changeMenuViewType:menuType];
}

@end
