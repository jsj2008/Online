//
//  OnlineDetailCell.m
//  Online
//
//  Created by liaojinxing on 14-2-27.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineDetailCell.h"
#import "ImageHelper.h"
#import "UIColor+Hex.h"
#import "AppConstant.h"

@interface OnlineDetailCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *authorLabel;

@end

@implementation OnlineDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.photoImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.photoImageView];
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, kAvatarSize, kAvatarSize)];
    [self.contentView addSubview:self.avatarImageView];
    
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + kAvatarSize,
                                                                 20, 200, 20)];
    [self.authorLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:self.authorLabel];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithHex:0xFFFFFF alpha:0.05];
    bgColorView.layer.cornerRadius = 7;
    bgColorView.layer.masksToBounds = YES;
    [self setSelectedBackgroundView:bgColorView];
  }
  return self;
}

- (void)configureWithPhoto:(Photo *)photo
{
  CGFloat width = self.frame.size.width;
  CGFloat height = [[self class] heightWithPhoto:photo];
  [self.photoImageView setImage:nil];
  [self.photoImageView setFrame:CGRectMake(0, 0, width, height)];

  [ImageHelper scaleAndClipImageView:self.photoImageView
                        withImageURL:photo.image
                    destionationSize:CGSizeMake(width, height)];
  //[self.photoImageView setupImageViewer];
  [ImageHelper configureAvatarImageView:self.avatarImageView withImageURL:photo.author.avatar];
}

+ (CGFloat)heightWithPhoto:(Photo *)photo
{
  NSNumber *width, *height;
  if (photo.sizes.large && photo.sizes.large.count > 1) {
    width = photo.sizes.large[0];
    height = photo.sizes.large[1];
  }
  return [ImageHelper scaleHeightWithFixedWidth:[[UIScreen mainScreen] bounds].size.width
                                    originWidth:width.floatValue
                                   originHeight:height.floatValue];
}

@end
