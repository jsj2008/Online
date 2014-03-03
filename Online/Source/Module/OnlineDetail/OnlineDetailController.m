//
//  OnlineDetailController.m
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineDetailController.h"
#import "OnlineDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "OnlineDetailCell.h"

@interface OnlineDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) Online *online;
@property (nonatomic, strong) OnlineDetailHeaderView *headerView;

@end

@implementation OnlineDetailController

- (id)initWithOnline:(Online *)online
{
  self = [super init];
  if (self) {
    self.online = online;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.rowHeight = 150;
  
  self.tableView.tableHeaderView = self.headerView;
  
  [self initRefreshControlRelated];
  
  [self sendPhotosRequest];
}

- (void)initRefreshControlRelated
{
  __weak typeof(self) weakSelf = self;
  [self.refreshControl setCanRefreshDirection:kYARefreshableDirectionBottom];
  [self.refreshControl setRefreshHandleAction:^(YARefreshDirection direction) {
    [weakSelf sendPhotosRequest];
    [weakSelf.refreshControl stopRefreshAtDirection:kYARefreshDirectionBottom animated:YES completion:nil];
  }];
}

- (OnlineDetailHeaderView *)headerView
{
  if (!_headerView) {
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, 284);
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"OnlineDetailHeaderView"
                                                      owner:self
                                                    options:nil];
    
    _headerView = [nibViews objectAtIndex: 0];
    [_headerView configureWithOnline:self.online];
    [_headerView setFrame:frame];
  }
  return _headerView;
}

- (void)sendPhotosRequest
{
  __weak typeof(self) weakSelf = self;
  [self.httpClient getPhotosOfAlbumID:self.online.albumID
                                start:(int)self.dataArray.count
                                count:10
                            succeeded:^(PhotoArray *photoArray) {
                              [weakSelf.dataArray addObjectsFromArray:photoArray.photos];
                              [weakSelf.tableView reloadData];
                            } failed:NULL];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  Photo *photo = [self.dataArray objectAtIndex:indexPath.row];
  return [OnlineDetailCell heightWithPhoto:photo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier = @"OnlineDetailCell";
  OnlineDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[OnlineDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  Photo *photo = [self.dataArray objectAtIndex:indexPath.row];
  [cell configureWithPhoto:photo];
  return cell;
}


@end
