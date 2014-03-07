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

@property (nonatomic, strong) UILabel *titleLabel;
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
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.titleLabel];
    
    self.imageView = [[UIImageView alloc] init];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.imageView];
    
    [self.titleLabel alignCenterXWithView:self predicate:nil];
    [self.titleLabel alignCenterYWithView:self predicate:nil];
    [self.imageView alignTop:@"5" leading:@"10" toView:self];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(titlePressed)];
    [self addGestureRecognizer:recognizer];
  }
  return self;
}

- (void)configureWithTitle:(NSString *)title imageName:(NSString *)imageName
{
  [self.titleLabel setText:title];
  [self.imageView setImage:[UIImage imageNamed:imageName]];
}

- (NSArray *)titleArray
{
  if (!_titleArray) {
    _titleArray = [NSArray arrayWithObjects:
                  @"今日热门", @"本周热门", @"最新活动", @"我的信息", nil];
  }
  return _titleArray;
}

- (NSArray *)imageArray
{
  if (!_imageArray) {
    _imageArray = [NSArray arrayWithObjects:
                  @"today-32", @"week_view-32", @"menu-32", @"checked_user-32", nil];
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
