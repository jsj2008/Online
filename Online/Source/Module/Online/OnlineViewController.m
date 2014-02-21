//
//  OnlineViewController.m
//  Online
//
//  Created by liaojinxing on 14-2-21.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "OnlineViewController.h"

@implementation OnlineViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
	
}

- (void)sendOnlineRequest
{
  
}

#pragma mark - UICollectionView Data Source Methods
// Default is one
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
  return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	//static int increase;
	return CGSizeMake(180,100);// CGSizeMake(180-((increase%3)*10), 80+(increase*3));
}

#pragma mark - Gesture recognizers
- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer;
{
	
}


@end
