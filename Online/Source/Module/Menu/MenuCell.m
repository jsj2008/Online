//
//  MenuCell.m
//  Online
//
//  Created by liaojinxing on 14-2-24.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.menuView = [[MenuView alloc] initWithFrame:self.contentView.frame];
    [self.contentView addSubview:self.menuView];
  }
  return self;
}

- (void)configureViewWithMenuType:(MenuType)menuType
{
  [self.menuView configureWithMenuType:menuType];
}

@end
