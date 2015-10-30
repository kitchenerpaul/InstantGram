//
//  LoginViewController.m
//  InstantGram
//
//  Created by Paul Kitchener on 10/29/15.
//  Copyright © 2015 Paul Kitchener. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4.h>
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    

}


-(IBAction)onFacebookLoginPressed:(id)sender {
    [self didLogin:YES];

    }

-(void)didLogin:(BOOL)loggedIn{
    if (loggedIn) {
        [self performSegueWithIdentifier:@"LoginSuccessfulID" sender:self];
        NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];

        // Login PFUser using Facebook
        [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
            if (!user) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else if (user.isNew) {
                NSLog(@"User signed up and logged in through Facebook!");
            } else {
                NSLog(@"User logged in through Facebook!");
            }
            [self didLogin:YES];
        }];

    } else {
        NSLog(@"Error");
    }
}



-(IBAction)unwindToLoginViewController:(UIStoryboardSegue *)segue {

}

@end
