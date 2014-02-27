//
//  OnlineDetailController.m
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineDetailController.h"
#import "OnlineDetailHeaderView.h"

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"no"];
  [cell.imageView setImage:[UIImage imageNamed:@"background"]];
  return cell;
}

@end
