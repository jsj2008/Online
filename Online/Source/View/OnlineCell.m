//
//  OnlineCell.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineCell.h"
#import "UIImageView+WebCache.h"

@interface OnlineCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation OnlineCell

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    [self.contentView addSubview:self.imageView];
  }
  return self;
}

- (void)configureWithOnline:(Online *)online
{
  [self.imageView setImageWithURL:[NSURL URLWithString:online.image]];
}


- (void)prepareForReuse {
  [super prepareForReuse];
  [self setNeedsDisplay];
}

@end
