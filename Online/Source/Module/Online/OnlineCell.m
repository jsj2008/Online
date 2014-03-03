//
//  OnlineCell.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineCell.h"
#import "UIView+FLKAutoLayout.h"
#import "UIColor+Hex.h"
#import "ImageHelper.h"
#import "AppConstant.h"

@interface OnlineCell ()

@property (nonatomic, strong) UIImageView *onlineImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) Online *online;

@end

@implementation OnlineCell

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.mainView = [[UIView alloc] init];
    [self.mainView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.mainView];
    
    self.onlineImageView = [[UIImageView alloc] init];
    [self.onlineImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mainView addSubview:self.onlineImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setBackgroundColor:[UIColor randomDarkColor]];
    [self.titleLabel setTextColor:[UIColor randomThinColor]];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mainView addSubview:self.titleLabel];
    
    self.descLabel = [[UILabel alloc] init];
    [self.descLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.mainView addSubview:self.descLabel];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithHex:0xFFFFFF alpha:0.05];
    bgColorView.layer.cornerRadius = 7;
    bgColorView.layer.masksToBounds = YES;
    [self setSelectedBackgroundView:bgColorView];
  }
  return self;
}

- (void)updateConstraints
{
  [super updateConstraints];
  
  [self.mainView alignCenterXWithView:self.contentView predicate:@"0"];
  [self.mainView alignCenterYWithView:self.contentView predicate:@"0"];
  [self.mainView constrainHeightToView:self.contentView predicate:nil];
  [self.mainView constrainWidthToView:self.contentView predicate:nil];
  
  [self.onlineImageView alignCenterXWithView:self.mainView predicate:@"0"];
  [self.onlineImageView alignCenterYWithView:self.mainView predicate:@"0"];
  [self.onlineImageView constrainHeightToView:self.mainView predicate:@"-10"];
  [self.onlineImageView constrainWidthToView:self.mainView predicate:@"0"];
  
  [self.titleLabel constrainTopSpaceToView:self.mainView predicate:@"-40"];
  [self.titleLabel alignLeading:@"15" trailing:nil toView:self.mainView];
  [self.titleLabel constrainWidthToView:self.mainView predicate:@"<=-40"];
}

- (void)configureWithOnline:(Online *)online
{
  self.online = online;
  [self.onlineImageView setImage:nil];
  
  [ImageHelper scaleAndClipImageView:self.onlineImageView
                        withImageURL:online.image
                    destionationSize:CGSizeMake(self.frame.size.width, kOnlineCellHeight)];
  [self.onlineImageView setContentMode:UIViewContentModeBottom];
  [self.titleLabel setText:online.title];
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  [self.contentView setNeedsLayout];
  [self.contentView layoutIfNeeded];
}

@end
