//
//  OnlineDetailHeaderView.m
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineDetailHeaderView.h"
#import "ImageHelper.h"
#import "NSDate+Online.h"
#import "UIColor+Hex.h"
#import "FBShimmeringView.h"

@interface OnlineDetailHeaderView ()

@property (nonatomic, strong) FBShimmeringView *shimmeringView;

@end

@implementation OnlineDetailHeaderView

- (void)awakeFromNib
{
  CAGradientLayer *maskLayer = [CAGradientLayer layer];
  maskLayer.anchorPoint = CGPointZero;
  maskLayer.startPoint = CGPointMake(0.5f, 1.0f);
  maskLayer.endPoint = CGPointMake(0.5f, 0.0f);
  UIColor *outerColor = [UIColor colorWithWhite:1.0 alpha:1.0];
  UIColor *innerColor = [UIColor colorWithWhite:1.0 alpha:0.5];
  maskLayer.colors = @[(id)innerColor.CGColor, (id)outerColor.CGColor, (id)innerColor.CGColor, (id)outerColor.CGColor, (id)outerColor.CGColor];
  maskLayer.locations = @[@0.0, @0.15, @0.5, @0.85, @1.0f];
  maskLayer.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
  self.coverImageView.layer.mask = maskLayer;
}

- (FBShimmeringView *)shimmeringView
{
  if (!_shimmeringView) {
    _shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.bounds];
    _shimmeringView.contentView = self.titleLabel;
    if (_shimmeringView.superview == nil) {
      [self addSubview:_shimmeringView];
    }
  }
  return _shimmeringView;
}

- (void)configureWithOnline:(Online *)online
{
  [self.titleLabel setTextColor:[UIColor blackColor]];
  [self.titleLabel setFont:[UIFont systemFontOfSize:17]];
  [self.timeLabel setTextColor:[UIColor blackColor]];
  [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
  
  CGRect frame = self.coverImageView.frame;
  [ImageHelper colorImageView:self.coverImageView
                        color:[UIColor colorWithHex:0x888888 alpha:0.85f]
                 withImageURL:online.image
             destionationSize:frame.size];
  
  [self.titleLabel setText:online.title];
  [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
  NSString *timeText = [NSString stringWithFormat:@"活动日期:%@-%@",
                        [NSDate dateStringOnlineStyleString:online.beginTime],
                        [NSDate dateStringOnlineStyleString:online.endTime]];
  [self.timeLabel setText:timeText];
  
  [self.participateLabel setText:[NSString stringWithFormat:@"%d人参加", online.participantCount]];
  [self.likeLabel setText:[NSString stringWithFormat:@"%d人喜欢", online.likeCount]];
  [self.photoLabel setText:[NSString stringWithFormat:@"%d张图片", online.photoCount]];
}

- (void)startShimmering
{
  [self.shimmeringView setShimmering:YES];
}

- (void)stopShimmering
{
  [self.shimmeringView setShimmering:NO];
}


@end
