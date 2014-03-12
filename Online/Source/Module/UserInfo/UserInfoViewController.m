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
#import "LoginViewController.h"

@implementation UserInfoViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.bodyView removeFromSuperview];
  [self configureUserInfo];
  [self.menuView configureWithTitle:@"线上活动" imageName:@"ic_tool_back"];
  [self.menuView removeTapGestureRecognizer];
}

- (IBAction)logout:(id)sender
{
  NSLog(@"haha");
  OnlineAccount *account = [OnlineAccount currentAccount];
  [[DOUAccountManager sharedInstance] deleteAccount:account];
  [self backToParent];
}

- (void)configureUserInfo
{
  OnlineAccount *account = [OnlineAccount currentAccount];
  [ImageHelper scaleAndClipImageView:self.avatarView
                        withImageURL:account.user.largeAvatar
                    destionationSize:self.avatarView.frame.size];
  [self.nameLabel setText:account.user.name];
}


- (void)backToParent
{
  [self.navigationController popViewControllerAnimated:YES];
}

@end
