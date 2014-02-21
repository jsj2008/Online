//
//  BaseCollectionViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "UIView+FLKAutoLayout.h"

@implementation BaseCollectionViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.bodyView.frame collectionViewLayout:layout];
  [self.bodyView addSubview:self.collectionView];
}

@end
