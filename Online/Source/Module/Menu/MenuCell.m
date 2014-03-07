//
//  MenuCell.m
//  Online
//
//  Created by liaojinxing on 14-2-24.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "MenuCell.h"
#import "UIColor+Hex.h"

@implementation MenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.menuView = [[MenuView alloc] initWithFrame:self.contentView.frame];
    [self.menuView removeTapGestureRecognizer];
    [self.contentView addSubview:self.menuView];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithHex:0xFFFFFF alpha:0.05];
    bgColorView.layer.cornerRadius = 7;
    bgColorView.layer.masksToBounds = YES;
    [self setSelectedBackgroundView:bgColorView];
  }
  return self;
}

- (void)configureViewWithMenuType:(MenuType)menuType
{
  [self.menuView configureWithMenuType:menuType];
}

@end
