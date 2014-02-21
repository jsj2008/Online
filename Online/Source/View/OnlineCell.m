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

@interface OnlineCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation OnlineCell

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {

    self.imageView = [[UIImageView alloc] init];
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setBackgroundColor:[UIColor blackColor]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.titleLabel];
    
    self.descLabel = [[UILabel alloc] init];
    [self.descLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.descLabel];
    
    [self.imageView alignCenterXWithView:self.contentView predicate:@"0"];
    [self.imageView alignCenterYWithView:self.contentView predicate:@"0"];
    [self.imageView constrainHeightToView:self.contentView predicate:@"0"];
    [self.imageView constrainWidthToView:self.contentView predicate:@"0"];
    
    [self.titleLabel constrainTopSpaceToView:self.contentView predicate:@"-50"];
    [self.titleLabel alignLeading:@"5" trailing:nil toView:self.contentView];
    [self.titleLabel constrainWidthToView:self.contentView predicate:@"<=-15"];
  }
  return self;
}

- (void)configureWithOnline:(Online *)online
{
  [self.imageView setImageWithURL:[NSURL URLWithString:online.image]];
  [self.titleLabel setText:online.title];
}

- (void)prepareForReuse
{
  [super prepareForReuse];
  [self setNeedsDisplay];
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  [self.contentView setNeedsLayout];
  [self.contentView layoutIfNeeded];
}

@end
