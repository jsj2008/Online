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
    _menuView.delegate = self;
  }
  return _menuView;
}

- (void)changeMenuViewType:(MenuType)type
{
  [_menuView configureWithMenuType:type];
}

- (void)presentMenuViewController
{
  MenuViewController *controller = [[MenuViewController alloc] init];
  controller.delegate = self;
  [self presentViewController:controller animated:YES completion:^{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat middleX = ceilf(self.view.frame.size.width / 2);
    CGFloat middleY = ceilf(self.view.frame.size.height / 2);
    NSArray *values = [NSArray arrayWithObjects:
                       [NSValue valueWithCGPoint:CGPointMake(middleX, middleY)],
                       [NSValue valueWithCGPoint:CGPointMake(middleX, middleY - 10)],
                       nil];
    [animation setValues:values];
    [animation setDuration:0.2];
    [animation setAutoreverses:YES];

    [controller.view.layer addAnimation:animation forKey:nil];
  }];
}

//TODO: move it away
//implemented by subclass
- (void)selectMenuType:(MenuType)menuType
{
  
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view addSubview:self.bodyView];
  [self.view addSubview:self.menuView];
  [self changeMenuViewType:kGuessYouLike];
}

@end
