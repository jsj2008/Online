//
//  OnlineDetailHeaderView.m
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineDetailHeaderView.h"
#import "ImageHelper.h"

@interface OnlineDetailHeaderView ()

@end

@implementation OnlineDetailHeaderView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
  }
  return self;
}

- (void)configureWithOnline:(Online *)online
{
  [self.titleLabel setTextColor:[UIColor whiteColor]];
  [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
  [self.timeLabel setTextColor:[UIColor whiteColor]];
  [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
  
  CGRect frame = self.coverImageView.frame;
  //[ImageHelper scaleAndClipImageView:self.coverImageView withImageURL:online.image destionationSize:frame.size];
  [ImageHelper colorImageView:self.coverImageView withImageURL:online.image destionationSize:frame.size];
  
  [self.titleLabel setText:online.title];
  [self.timeLabel setText:online.beginTime];
}


@end
