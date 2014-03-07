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
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, assign) BOOL didSetupConstraints;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

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
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.titleLabel];
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.imageButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.imageButton];
    [self.imageButton addTarget:self
                       action:@selector(backToParent)
             forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageButton alignTop:@"5" leading:@"10" toView:self];
    [self.titleLabel alignCenterXWithView:self predicate:nil];
    [self.titleLabel alignCenterYWithView:self predicate:nil];
    [self.titleLabel constrainWidthToView:self predicate:@"*.6"];
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(titlePressed)];
    [self addGestureRecognizer:self.tapRecognizer];
  }
  return self;
}

- (void)configureWithTitle:(NSString *)title imageName:(NSString *)imageName
{
  [self.titleLabel setText:title];
  [self.imageButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
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

- (void)backToParent
{
  [self.delegate backToParent];
}

- (void)removeTapGestureRecognizer
{
  [self removeGestureRecognizer:self.tapRecognizer];
}

- (void)addTapGestureRecognizer
{
  [self addGestureRecognizer:self.tapRecognizer];
}

@end
