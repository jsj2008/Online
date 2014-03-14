//
//  BaseViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "BaseViewController.h"
#import "AppConstant.h"
#import "UIView+YAUIKit.h"
#import "YAPanBackController.h"
#import "CECubeAnimationController.h"
#import "CEPortalAnimationController.h"

@interface BaseViewController () <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) YAPanBackController *panBackController;
@property (nonatomic, strong) CEPortalAnimationController *portalAnimationController;

@end

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

- (CEPortalAnimationController *)portalAnimationController
{
  if (!_portalAnimationController) {
    _portalAnimationController = [[CEPortalAnimationController alloc] init];
    _portalAnimationController.duration = 0.3f;
  }
  return _portalAnimationController;
}

- (void)changeMenuViewType:(MenuType)type
{
  [_menuView configureWithMenuType:type];
}

- (void)presentMenuViewController
{
  MenuViewController *controller = [[MenuViewController alloc] init];
  controller.delegate = self;
  controller.transitioningDelegate = self;
  [self presentViewController:controller animated:YES completion:NULL];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
  
  return self.portalAnimationController;
}

//TODO: move it away
//implemented by subclass
- (void)selectMenuType:(MenuType)menuType
{
}

- (void)backToParent
{
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view addSubview:self.bodyView];
  [self.view addSubview:self.menuView];
  [self changeMenuViewType:kTodayHotOnline];
  [self setupPanBackController];
}

- (void)setupPanBackController
{
  _panBackController = [[YAPanBackController alloc] initWithCurrentViewController:self];
  __block UIView *maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  __block CGFloat preChangePrecent = 0;
  [_panBackController setPanBackPrelayoutsBlock:^(UIView *fromView, UIView *toView) {
    [maskView setBackgroundColor:[UIColor blackColor]];
    [maskView setAlpha:0.7];
    [toView addSubview:maskView];
    [toView setFrameOriginX:-(toView.frame.size.width / 2)];
  } panChangedBlock:^(UIView *fromView, UIView *toView, CGFloat changedPrecent) {
    [fromView setFrameOriginX:changedPrecent * fromView.bounds.size.width];
    [maskView setAlpha:(1 - changedPrecent) * 0.7];
    CGFloat changeValue = [UIScreen mainScreen].applicationFrame.size.width * (changedPrecent - preChangePrecent) / 2;
    [toView setFrameOriginX:toView.frame.origin.x + changeValue];
    preChangePrecent = changedPrecent;
  } animationsBlock:^(UIView *fromView, UIView *toView, BOOL success) {
    if (success) {
      [fromView setFrameOriginX:fromView.frame.size.width];
      [maskView setAlpha:0];
      [toView setFrameOriginX:0];
    } else {
      [fromView setFrameOriginX:0];
      [maskView setAlpha:.7];
      [toView setFrameOriginX:-(toView.frame.size.width / 2)];
    }
  } completionBlock:^(UIView *fromView, UIView *toView, BOOL success) {
    if (success) {
      [toView setFrameOriginX:0];
      [maskView removeFromSuperview];
    } else {
      [toView setFrameOriginX:-(toView.frame.size.width / 2)];
      [maskView removeFromSuperview];
    }
  }];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [_panBackController addPanBackToView:self.view];
}

- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  [_panBackController removePanBackFromView:self.view];
}

@end
