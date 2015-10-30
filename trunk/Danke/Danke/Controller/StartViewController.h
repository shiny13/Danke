//
//  StartViewController.h
//  Danke
//
//  Created by Anik on 2/6/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>


@interface StartViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate>
{
}

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIPickerView *languagePicker;
@property (strong) NSArray *pickerData;
@property (strong) NSString *langChosen;
@property (strong) NSString *userName;
@property (strong) NSString *fbUserID;
@property (strong) NSString *googleID;
@property (strong) NSString *userImageURL;
@property (strong) PFGeoPoint *currentGeoPoint;
@property (strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *locationTextView;
@property (weak, nonatomic) IBOutlet UILabel *welcomeTextView;

@end
