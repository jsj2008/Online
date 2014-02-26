//
//  OnlineCell.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+FLKAutoLayout.h"
#import "UIColor+Hex.h"

@interface OnlineCell ()

@property (nonatomic, strong) UIImageView *onlineImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation OnlineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    self.onlineImageView = [[UIImageView alloc] init];
    [self.onlineImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.onlineImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setBackgroundColor:[UIColor randomDarkColor]];
    [self.titleLabel setTextColor:[UIColor randomThinColor]];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.titleLabel];
    
    self.descLabel = [[UILabel alloc] init];
    [self.descLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.descLabel];
    
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
  
  [self.onlineImageView alignCenterXWithView:self.contentView predicate:@"0"];
  [self.onlineImageView alignCenterYWithView:self.contentView predicate:@"0"];
  [self.onlineImageView constrainHeightToView:self.contentView predicate:@"-10"];
  [self.onlineImageView constrainWidthToView:self.contentView predicate:@"-20"];
  
  [self.titleLabel constrainTopSpaceToView:self.contentView predicate:@"-50"];
  [self.titleLabel alignLeading:@"15" trailing:nil toView:self.contentView];
  [self.titleLabel constrainWidthToView:self.contentView predicate:@"<=-20"];
}

- (void)configureWithOnline:(Online *)online
{
  [self.onlineImageView setImageWithURL:[NSURL URLWithString:online.image]];
  [self.titleLabel setText:online.title];
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  [self.contentView setNeedsLayout];
  [self.contentView layoutIfNeeded];
}

@end
