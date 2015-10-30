//
//  StartViewController.m
//  Danke
//
//  Created by Anik on 2/6/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "StartViewController.h"
#import "AppDelegate.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationTextView.delegate = self;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    self.pickerData = @[@"English", @"German"];
    
    self.languagePicker.dataSource = self;
    self.languagePicker.delegate = self;
    
    //By default setting the language to english
    self.langChosen = self.pickerData[0];
}

- (void) viewWillAppear:(BOOL)animated
{
    [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *FBuser, NSError *error) {
        if (error) {
            NSLog(@"Error in connecting to facebook StartViewController");
        }
        
        else {
            self.userName = [FBuser name];
            self.fbUserID = [FBuser objectID];
            self.welcomeTextView.text = [[NSString alloc] initWithFormat:@"Hello %@", self.userName];
            self.userImageURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [FBuser objectID]];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.userImageURL]];
            self.profileImageView.image = [UIImage imageWithData:imageData];
            
            //Saving image locally in documents directory of the app
            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *jpegFilePath = [NSString stringWithFormat:@"%@/profilePicture.jpg",docDir];
            NSData *data = [NSData dataWithData:UIImageJPEGRepresentation([UIImage imageWithData:imageData], 1.0f)];//1.0f = 100% quality
            [data writeToFile:jpegFilePath atomically:YES];

        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.langChosen = self.pickerData[row];
    
}

- (IBAction)startButtonTapped:(id)sender {
    NSLog(@"Selected language: %@", self.langChosen);
    NSString *location = self.locationTextView.text;
    
    PFObject *dankeUser = [PFObject objectWithClassName:@"DankeUser"];
    dankeUser[@"Name"] = self.userName;
    
    //Fill up the FbID or GoogleID field in parse
    if(![self.fbUserID isEqualToString:@""])
        dankeUser[@"FbID"] = self.fbUserID;
    else if(![self.googleID isEqualToString:@""])
        dankeUser[@"GoogleID"] = self.googleID;
    
    dankeUser[@"Language"] = self.langChosen;
    //dankeUser[@"Location"] = self.currentGeoPoint;
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *jpegFilePath = [NSString stringWithFormat:@"%@/profilePicture.jpg",docDir];
    //NSData *data = [[NSFileManager defaultManager] contentsAtPath:jpegFilePath];
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:jpegFilePath];
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    dankeUser[@"ProfilePicture"] = imageFile;
    
    dankeUser[@"ACL"] = [PFACL ACLWithUser:[PFUser currentUser]];
    
    //Saving the object to parse
    [dankeUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Saving dankeUser successful in parse.");
        } else {
            NSLog(@"Saving dankeUser unsuccessful in parse.");        }
    }];
    
    SWRevealViewController *revealedView = [self.storyboard instantiateViewControllerWithIdentifier:@"swRevealView"];
 //   [self.navigationController pushViewController:revealedView animated:YES];
    [self.navigationController setViewControllers:@[revealedView] animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.locationTextView resignFirstResponder];
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    //NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    self.currentGeoPoint = [PFGeoPoint geoPointWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
}


@end
