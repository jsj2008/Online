//
//  BaseViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "BaseViewController.h"
#import "UIView+FLKAutoLayout.h"
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
    _bodyView = [[UIView alloc] init];
    [_bodyView alignCenterXWithView:self.view predicate:nil];
    [_bodyView constrainWidthToView:self.view predicate:nil];
    [_bodyView constrainTopSpaceToView:self.view predicate:nil];
    [_bodyView constrainHeightToView:self.view predicate:[NSString stringWithFormat:@"-%f", kFooterViewHeight]];
  }
  return _bodyView;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view addSubview:self.bodyView];
}

@end
