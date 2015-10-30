//
//  ViewController.m
//  Danke
//
//  Created by Anik on 2/4/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface ViewController ()

@end

@implementation ViewController

static NSString * const kClientId = @"102214385758-rpc1b6gfm35cke3c74f3okb9oas38gcb.apps.googleusercontent.com";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Code added by Shahnawaz
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    signIn.clientID = kClientId;
    
    //We will have to use either one of the scopes
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];
    //signIn.scopes = @[ @"profile" ];
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
    //To automatically sign in user
    [signIn trySilentAuthentication];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
    }
}

-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        self.googleSignInButton.hidden = YES;
        // Perform other actions here, such as showing a sign-out button
    } else {
        self.googleSignInButton.hidden = NO;
        // Perform other actions here
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    if ([PFUser currentUser] && // Check if user is cached
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) { // Check if user is linked to Facebook
        // Present the next view controller without animation
        SWRevealViewController *revealedView = [self.storyboard instantiateViewControllerWithIdentifier:@"swRevealView"];
        [self.navigationController setViewControllers:@[revealedView] animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookButtonTapped:(id)sender {
    
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        } else {
            if (user.isNew) {
                NSLog(@"User with facebook signed up and logged in!");
            } else {
                NSLog(@"User with facebook logged in!");
            }
            [self _presentUserDetailsViewControllerAnimated:YES];
        }
    }];
    
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

- (void)_presentUserDetailsViewControllerAnimated:(BOOL)animated {
    StartViewController *startView = [self.storyboard instantiateViewControllerWithIdentifier:@"startScreenView"];
    [self.navigationController pushViewController:startView animated:YES];
}

//Google+ signout method -> to be implemented later if needed with a button
- (void)signOut {
    [[GPPSignIn sharedInstance] signOut];
}
@end
