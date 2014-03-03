//
//  LoginViewController.m
//  Online
//
//  Created by liaojinxing on 14-3-3.
//  Copyright (c) 2014年 douban. All rights reserved.
//

#import "LoginViewController.h"
#import "DOUOAuth.h"
#import "DOUOAuthClient.h"
#import "iToast.h"
#import "DataFormatHelper.h"
#import "OnlineAccount.h"
#import "DOUAccountManager.h"

@interface LoginViewController ()
{
  DOUOAuth *_oauthInfo;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self loadSubViews];
}

- (void)loadSubViews
{  
  _emailTextField.accessibilityLabel = @"emailTextField";
  _emailTextField.backgroundColor = [UIColor clearColor];
  _emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  _emailTextField.delegate = self;
  _emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
  _emailTextField.returnKeyType = UIReturnKeyNext;
  _emailTextField.borderStyle = UITextBorderStyleNone;
  _emailTextField.placeholder = @"name@email.com";
  
  _passwordTextField.accessibilityLabel = @"passwordTextField";
  _passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  _passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  _passwordTextField.delegate = self;
  _passwordTextField.secureTextEntry = YES;
  _passwordTextField.borderStyle = UITextBorderStyleNone;
  
  _emailTextField.delegate = self;
  _passwordTextField.delegate = self;
  
  [_loginButton addTarget:self
                   action:@selector(loginBegin)
         forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  UITouch *touch = [touches anyObject];
  if (touch.phase == UITouchPhaseBegan) {
    if ([_emailTextField isFirstResponder]) {
      [_emailTextField resignFirstResponder];
    }
    if ([_passwordTextField isFirstResponder]) {
      [_passwordTextField resignFirstResponder];
    }
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  if (textField == _emailTextField || textField == _passwordTextField) {
    [textField resignFirstResponder];
  }
  if (textField == _emailTextField) {
    [_passwordTextField becomeFirstResponder];
  } else if (textField == _passwordTextField) {
    [self loginBegin];
  }
  return YES;
}

#pragma mark - Authorization view controller delegate

- (void)goOutOfLoginView
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginBegin
{
  _emailTextField.leftViewMode = UITextFieldViewModeNever;
  _passwordTextField.leftViewMode = UITextFieldViewModeNever;
  NSString *email = [_emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  if (email == nil || [email isEqualToString:@""]) {
    _emailTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    [_emailTextField becomeFirstResponder];
    iToast *toast = [iToast makeText:NSLocalizedString(@"inputUserName", @"")];
    [toast show];
    return;
  }
  if (![DataFormatHelper validateEmail:email]) {
    if (![DataFormatHelper validatePhoneNumber:email]) {
      _emailTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
      [_emailTextField becomeFirstResponder];
      iToast *toast = [iToast makeText:NSLocalizedString(@"emailFormatError", @"")];
      [toast show];
      return;
    }
  }
  NSString *pass = [_passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  if (pass == nil || [pass isEqualToString:@""]) {
    _passwordTextField.leftViewMode = UITextFieldViewModeUnlessEditing;
    [_passwordTextField becomeFirstResponder];
    iToast *toast = [iToast makeText:NSLocalizedString(@"inputPassword", @"")];
    [toast show];
    return;
  }
  [self startLogin];
}

- (void)startLogin
{
  NSString *editedEmailString = [_emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  editedEmailString = [editedEmailString stringByReplacingOccurrencesOfString:@"＠" withString:@"@"];
  
  DOUOAuthClient *client = [[DOUOAuthClient alloc]initWithBaseURL:kDoubanOAuthBaseURLString];
  [client fetchAccessTokenWithUsername:editedEmailString
                              password:self.passwordTextField.text
                               success:^(DOUOAuth *oauth) {
                                 _oauthInfo = oauth;
                                 [self loginFinished];
                                 [self dismissViewControllerAnimated:YES completion:nil];
                               } failure:^(DOUError *requestError) {
                                 [self loginFailed];
                               }];
}

- (void)loginFinished
{
  [self.httpClient getUserByID:_oauthInfo.doubanUserID
                       succeeded:^(User *user) {
                         OnlineAccount *account = [[OnlineAccount alloc] initWithUser:user oauth:_oauthInfo];
                         [[DOUAccountManager sharedInstance] addAccount:account];
                       } failed:NULL];
  
  [DOUAPIClient setOAuth:_oauthInfo];
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginFailed
{
  iToast *toast = [iToast makeText:NSLocalizedString(@"loginFailed", @"")];
  [toast show];
}

- (void)loginCanceled
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)oAuthLoginCanceledOrFailed
{
  [self loginCanceled];
}

- (void)oAuthLoginSucceed:(DOUOAuth *)auth
{
  _oauthInfo = auth;
  [self loginFinished];
}

@end

