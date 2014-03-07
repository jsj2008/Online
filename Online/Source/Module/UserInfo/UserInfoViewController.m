//
//  UserInfoViewController.m
//  Online
//
//  Created by liaojinxing on 14-3-7.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "UserInfoViewController.h"
#import "OnlineAccount.h"
#import "ImageHelper.h"
#import "DOUAccountManager.h"

@implementation UserInfoViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self configureUserInfo];
}

- (IBAction)logout:(id)sender
{
  OnlineAccount *account = [OnlineAccount currentAccount];
  [[DOUAccountManager sharedInstance] deleteAccount:account];
}

- (void)configureUserInfo
{
  OnlineAccount *account = [OnlineAccount currentAccount];
  [ImageHelper scaleAndClipImageView:self.avatarView
                        withImageURL:account.user.largeAvatar
                    destionationSize:self.avatarView.frame.size];
  [self.nameLabel setText:account.user.name];
}

@end
