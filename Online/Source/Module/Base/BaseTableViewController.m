//
//  BaseTableViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-26.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@property (assign, nonatomic) CATransform3D initialTransformation;

@end

@implementation BaseTableViewController
@synthesize refreshControl = _refreshControl;

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.tableView = [[UITableView alloc] initWithFrame:self.bodyView.frame];
  [self.bodyView addSubview:self.tableView];
  
  [self initAnimationRelated];
  _shownIndexes = [NSMutableSet set];
  
  self.dataArray = [NSMutableArray array];
}

- (void)initAnimationRelated
{
  CGFloat rotationAngleDegrees = -15;
  CGFloat rotationAngleRadians = rotationAngleDegrees * (M_PI/180);
  CGPoint offsetPositioning = CGPointMake(-20, -20);
  
  CATransform3D transform = CATransform3DIdentity;
  transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
  transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
  _initialTransformation = transform;
}

- (YARefreshControl *)refreshControl
{
  if (!_refreshControl) {
    _refreshControl = [[YARefreshControl alloc] initWithScrollView:self.tableView];
  }
  return _refreshControl;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (![self.shownIndexes containsObject:indexPath]) {
    [self.shownIndexes addObject:indexPath];
    
    UIView *card = [cell contentView];
    
    card.layer.transform = self.initialTransformation;
    card.layer.opacity = 0.8;
    
    [UIView animateWithDuration:0.3 animations:^{
      card.layer.transform = CATransform3DIdentity;
      card.layer.opacity = 1;
    }];
  }
}

@end
