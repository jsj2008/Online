//
//  BaseViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "BaseViewController.h"
#import "AppConstant.h"

@implementation BaseViewController

@synthesize bodyView = _bodyView;

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
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kFooterViewHeight);
    _bodyView = [[UIView alloc] initWithFrame:frame];
  }
  return _bodyView;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view addSubview:self.bodyView];
}

@end
