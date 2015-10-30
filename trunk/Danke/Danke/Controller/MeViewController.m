//
//  MeViewController.m
//  Danke
//
//  Created by Anik on 2/7/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "MeViewController.h"
#import "SWRevealViewController.h"
#import "GiveViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *FBuser, NSError *error) {
        if (error) {
            // Handle error
        }
        
        else {
            NSString *userName = [FBuser name];
            self.userName.text = userName;
            NSString *userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [FBuser objectID]];
            NSData *data;
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:userImageURL]];
            
            self.profileImageView.image = [UIImage imageWithData:data];
        }
    }];

    [self.view bringSubviewToFront:self.infoView];

}

- (IBAction)giveButtonTapped:(id)sender {
    
    GiveViewController *giveView = [self.storyboard instantiateViewControllerWithIdentifier:@"giveScreenView"];
    [self.navigationController pushViewController:giveView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
