//
//  GiveViewController.h
//  Danke
//
//  Created by Anik on 2/8/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Constants.h"
#import "SPGooglePlacesAutocomplete.h"
#import <CoreLocation/CoreLocation.h>

@interface GiveViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate,UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate>{
    NSString *_button_id;
    UIImage *image1;
    UIImage *image2;
    UITableView *autocompleteTableView;
    NSArray *searchResultPlaces;
    SPGooglePlacesAutocompleteQuery *searchQuery;
    BOOL shouldBeginEditing;
    CLLocationManager *locationManager;
    CLLocation *currentCentre;
    double lat;
    double lng;
    SPGooglePlacesAutocompletePlace *selectedPlace;
    NSString *selectedCatagory;
  
    NSArray *catagory;
}


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *pickupPlaceTextField;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UISwitch *enableContactSwitch;
@property (weak, nonatomic) IBOutlet UIButton *giveButton;


@end
