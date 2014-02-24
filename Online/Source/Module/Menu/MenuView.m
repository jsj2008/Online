//
//  MenuView.m
//  Online
//
//  Created by liaojinxing on 14-2-24.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "MenuView.h"
#import "UIView+FLKAutoLayout.h"
#import "UIColor+Hex.h"
#import "CommonMacros.h"

@interface MenuView ()

@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation MenuView

@synthesize titleArray = _titleArray;
@synthesize imageArray = _imageArray;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:MENU_BGCOLOR];
    self.titleButton = [[UIButton alloc] init];
    [self.titleButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleButton addTarget:self
                         action:@selector(titlePressed)
               forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.titleButton];
    
    self.imageView = [[UIImageView alloc] init];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.imageView];
    
    [self.titleButton alignCenterXWithView:self predicate:nil];
    [self.titleButton alignCenterYWithView:self predicate:nil];
    [self.imageView alignTop:@"5" leading:@"10" toView:self];
  }
  return self;
}

- (void)configureWithTitle:(NSString *)title imageName:(NSString *)imageName
{
  [self.titleButton setTitle:title forState:UIControlStateNormal];
  [self.imageView setImage:[UIImage imageNamed:imageName]];
}

- (NSArray *)titleArray
{
  if (!_titleArray) {
    _titleArray = [NSArray arrayWithObjects:
                   @"猜你喜欢", @"今日热门", @"本周热门", @"最新活动", @"我的信息", nil];
  }
  return _titleArray;
}

- (NSArray *)imageArray
{
  if (!_imageArray) {
    _imageArray = [NSArray arrayWithObjects:
                   @"likes-32", @"today-32", @"week_view-32", @"menu-32", @"checked_user-32", nil];
  }
  return _imageArray;
}

- (void)configureWithMenuType:(MenuType)menuType
{
  NSString *title = [self.titleArray objectAtIndex:menuType];
  NSString *imageName = [self.imageArray objectAtIndex:menuType];
  [self configureWithTitle:title imageName:imageName];
}

- (void)titlePressed
{
  [self.delegate presentMenuViewController];
}

@end
