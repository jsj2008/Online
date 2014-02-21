//
//  BaseCollectionViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "BaseCollectionViewController.h"

@implementation BaseCollectionViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.bodyView.frame];
  [self.bodyView addSubview:self.collectionView];
}

@end
