//
//  MenuViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-24.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "MenuViewController.h"
#import "AppConstant.h"
#import "MenuCell.h"
#import "UIColor+Hex.h"
#import "CommonMacros.h"

@implementation MenuViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  [self initTableView];
  [self.view setBackgroundColor:MENU_BGCOLOR];
}

- (void)initTableView
{
  CGFloat height = kMenuListSize * kMenuCellHeight;
  CGFloat originY = self.view.frame.size.height - height;
  self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, originY, self.view.frame.size.width, height)
                                                style:UITableViewStylePlain];
  self.tableView.rowHeight = kMenuCellHeight;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.view addSubview:self.tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return kMenuListSize;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *identifier = @"MenuCell";
  MenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  if (indexPath.row < kMenuListSize) {
    [cell configureViewWithMenuType:indexPath.row];
  }
  return cell;
}

@end
