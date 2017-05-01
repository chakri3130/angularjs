//
//  ViewController.m
//  Logindemo
//
//  Created by srinivas on 12/21/16.
//  Copyright © 2016 srinivas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblLoginStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePicture;
@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;
-(void)toggleHiddenState:(BOOL)shouldHide;
@end

@implementation ViewController

-(void)toggleHiddenState:(BOOL)shouldHide{
    self.lblUsername.hidden = shouldHide;
    self.lblEmail.hidden = shouldHide;
    self.profilePicture.hidden = shouldHide;
    self.lblLoginStatus.hidden=shouldHide;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self toggleHiddenState:YES];
    self.lblLoginStatus.text = @"";
    self.loginButton.delegate =self;
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    self.lblLoginStatus.text=@"you are logged In";
    [self toggleHiddenState:NO];
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    NSLog(@"%@", user);
    self.profilePicture.profileID = user.id;
    self.lblUsername.text = user.name;
    self.lblEmail.text = [user objectForKey:@"email"];
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    self.lblLoginStatus.text=@"you are logged out";
    [self toggleHiddenState:YES];
}
- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
