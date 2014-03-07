//
//  UserInfoViewController.h
//  Online
//
//  Created by liaojinxing on 14-3-7.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView *avatarView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;

- (IBAction)logout:(id)sender;
- (void)configureUserInfo;

@end
