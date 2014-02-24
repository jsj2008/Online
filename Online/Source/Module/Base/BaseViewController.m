//
//  BaseViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "BaseViewController.h"
#import "AppConstant.h"
#import "MenuViewController.h"

@implementation BaseViewController

@synthesize bodyView = _bodyView;
@synthesize menuView = _menuView;

- (DOUAPIClient *)httpClient
{
  if (!_httpClient) {
    _httpClient = [DOUAPIClient createHttpClient];
  }
  return _httpClient;
}

- (UIView *)bodyView
{
  if (!_bodyView) {
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kMenuCellHeight);
    _bodyView = [[UIView alloc] initWithFrame:frame];
  }
  return _bodyView;
}

- (MenuView *)menuView
{
  if (!_menuView) {
    CGRect frame = CGRectMake(0, self.view.frame.size.height - kMenuCellHeight, self.view.frame.size.width, kMenuCellHeight);
    _menuView = [[MenuView alloc] initWithFrame:frame];
    [_menuView configureWithMenuType:kGuessYouLike];
    _menuView.delegate = self;
  }
  return _menuView;
}

- (void)presentMenuViewController
{
  MenuViewController *controller = [[MenuViewController alloc] init];
  [self presentViewController:controller animated:YES completion:NULL];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view addSubview:self.bodyView];
  [self.view addSubview:self.menuView];
}

@end
