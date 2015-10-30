//
//  GiveViewController.m
//  Danke
//
//  Created by Anik on 2/8/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "GiveViewController.h"
#import "Reachability.h"

@interface GiveViewController ()

@end

@implementation GiveViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] initWithApiKey:@"AIzaSyAFsaDn7vyI8pS53zBgYRxu0HfRwYqH-9E"];
//        shouldBeginEditing = YES;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self findCurrentLocation];
    searchQuery = [[SPGooglePlacesAutocompleteQuery alloc] initWithApiKey:@"AIzaSyAFsaDn7vyI8pS53zBgYRxu0HfRwYqH-9E"];
    shouldBeginEditing = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    self.descriptionTextView.delegate = self;
    self.titleTextField.delegate =self;
    self.pickupPlaceTextField.delegate =self;
    
    autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, 320, 120) style:UITableViewStylePlain];
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    
     [[UIApplication sharedApplication].keyWindow addSubview:autocompleteTableView];
   // [self.view addSubview:autocompleteTableView];
    catagory = [NSArray arrayWithObjects:@"catagory 0",@"catagory 1",@"catagory 2",@"catagory 3",@"catagory 4",@"catagory 5",@"catagory 6",@"catagory 7",@"catagory 8",nil];
    // Do any additional setup after loading the view.
}
-(void)dismissKeyboard {
    [_descriptionTextView resignFirstResponder];
    [_titleTextField resignFirstResponder];
    [_pickupPlaceTextField resignFirstResponder];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    if(_descriptionTextView.returnKeyType==UIReturnKeyDefault)
    {
        //Your search key code
        
        [_descriptionTextView resignFirstResponder];
        
        
    }
    if(_titleTextField.returnKeyType==UIReturnKeyDefault)
    {
        
        [_titleTextField resignFirstResponder];
        
        
    }
    if(_pickupPlaceTextField.returnKeyType==UIReturnKeyDefault)
    {
        
        [_pickupPlaceTextField resignFirstResponder];
        
    }
    return 1;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if([text isEqualToString:@"\n"]) {
        [_descriptionTextView resignFirstResponder];
        
        
        return NO;
    }

    
    return YES;
}

-(void) textViewDidEndEditing:(UITextView *)textView{
[self animateTextFields:textView up:NO];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    
    [self animateTextFields:textView up:YES];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
     int movementDistance = -130; // tweak as needed
     float movementDuration = 0.3f; // tweak as needed
    
    if([textField viewWithTag:400]){
    
    movementDistance = -320;
    movementDuration = 0.3f;
    }
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

-(void)animateTextFields:(UITextView*)textField up:(BOOL)up
{
    const int movementDistance = -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addFirstImageButtonTapped:(id)sender {
    
    [self openActionSheet:@"1"];
    
}

-(void) openActionSheet:(NSString *) sender{
    
    _button_id =sender;
    
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"Choose Photo"
                                                           delegate:self
                                                  cancelButtonTitle: nil
                                             destructiveButtonTitle: nil
                                                  otherButtonTitles:@"Take From Camera",@"Select From Library", @"Cancel", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.destructiveButtonIndex=2;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([_button_id  isEqual:@"3"]){
       
        selectedCatagory = catagory[buttonIndex];
        [_categoryButton setTitle:selectedCatagory forState:UIControlStateNormal];
        
    }else{
        if (buttonIndex==0) {
            [self takePictureFromCamera];
        }
        else if (buttonIndex==1) {
            [self pickImageFromLibrary];
        
        }
    }
    
}

-(void) pickImageFromLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController* imgPicker=[[UIImagePickerController alloc] init];
       // self.imagePicker = imgPicker;
        //UI Customization
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [[imgPicker navigationBar] setTintColor:[UIColor whiteColor]];
        }
        
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imgPicker.delegate = self;
        
        [self presentViewController:imgPicker animated:YES completion:nil];
        
    } else {
        NSLog(@"Attempted to pick an image with illegal source type '%d'", (int)UIImagePickerControllerSourceTypePhotoLibrary);
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
 [picker dismissViewControllerAnimated:YES completion:NULL];
    
    // Edited image works great (if you allowed editing)
    UIImage *myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIButton *button1;
     if ([_button_id  isEqual: @"1"]) {
         image1 = myImage;
         button1 = (UIButton *)[self.view viewWithTag:1000];
     }else{
         button1 = (UIButton *)[self.view viewWithTag:1001];
         image2 = myImage;
     }
    button1.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button1 setBackgroundImage:myImage forState:UIControlStateNormal];
   
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void) takePictureFromCamera
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController* imgPicker=[[UIImagePickerController alloc] init];
        //self.imagePicker = imgPicker;
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imgPicker.delegate = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            [[imgPicker navigationBar] setTintColor:[UIColor whiteColor]];
        }
        
        [self presentViewController:imgPicker animated:YES completion:nil];
        
    } else {
        NSLog(@"Attempted to pick an image with illegal source type '%d'", (int)UIImagePickerControllerSourceTypePhotoLibrary);
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"MY APP" message:@"CAMERA_NOT_AVAILABLE" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}
- (IBAction)catagoryButtonTapped:(id)sender {

    _button_id =@"3";
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"Choose Photo"
                                                           delegate:self
                                                  cancelButtonTitle: nil
                                             destructiveButtonTitle: nil
                                                  otherButtonTitles:@"catagory 0",@"catagory 1",@"catagory 2",@"catagory 3",@"catagory 4",@"catagory 5",@"catagory 6",@"catagory 7",@"catagory 8",@"Cancel", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.destructiveButtonIndex=2;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];


}

- (IBAction)addSecondImageButtonTapped:(id)sender {
    
    [self openActionSheet:@"2"];
    
}
- (IBAction)giveButtonTapped:(id)sender {
    
    
    NSDictionary *placedetails = [self queryGooglePlaces];
    
    NSString  *lattitude =[[[placedetails objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"];
    NSString  * longitude =[[[placedetails objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"];
    
    NSLog(@"lattitude %@",lattitude);
    NSLog(@"give button tapped. check necessary condition to check if any mandetory field data is empty.");
    //please add a activity indicator to show user that somting is uploading...
    if([_descriptionTextView.text isEqual:@""]){
        
        UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"please write the description" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
        return;
    }
    if([_titleTextField.text isEqual:@""]){
        UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please write title" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
        return;
        
    }
    if([_pickupPlaceTextField.text isEqual:@""]){
        UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please write place" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
        
        return;
        
    }
    NSLog(@"catagory-- %@",[_categoryButton currentTitle]);
    if([[_categoryButton currentTitle] isEqual:@"Category"]){
        UIAlertView  *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select catagory" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
        
        return;
        
    }
    
    PFFile *imageFile1, *imageFile2;
    
    if (image1) {
        NSData *imageData = UIImageJPEGRepresentation(image1, 0.7);
        NSString *filename = [NSString stringWithFormat:@"%@%d.png", _titleTextField.text, 1];
        imageFile1 = [PFFile fileWithName:filename data:imageData];
    }
    
    if (image2) {
        NSData *imageData2 = UIImageJPEGRepresentation(image2, 0.7);
        NSString *filename2 = [NSString stringWithFormat:@"%@%d.png", _titleTextField.text, 2];
        imageFile2 = [PFFile fileWithName:filename2 data:imageData2];
    }
    
    
    
    
    /*
    // Show progress
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Uploading";
    [hud show:YES];
    */
    
    PFObject *testObject = [PFObject objectWithClassName:ProductClassName];
    testObject[ProductTitle] = _titleTextField.text;
    testObject[ProductDescription] = _descriptionTextView.text;
    testObject[ProductPostedById] = [[PFUser currentUser] objectId];
    testObject[ProductPickupPlace] = _pickupPlaceTextField.text;
    if (imageFile1) {
        testObject[ProductItemImage1] = imageFile1;
    }
    if (imageFile2) {
        testObject[ProductItemImage2] = imageFile2;
    }
    
    
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //show a success alert view
            NSLog(@"successfully added in Parse. Now going to previous view controller");
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"Something went wrong while uploading to parse. please try again later.");
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if([textField viewWithTag:400]){
    autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
        
        [self handleSearchForSearchString:substring];
    }
    //[self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return [searchResultPlaces count];
}

- (SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return searchResultPlaces[indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    cell.textLabel.text = [self placeAtIndexPath:indexPath].name;
    
   // cell.textLabel.text = @"aa";//[autocompleteUrls objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    autocompleteTableView.hidden =YES;
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    selectedPlace = [self placeAtIndexPath:indexPath];
    
    //urlField.text = selectedCell.textLabel.text;
    
 //   [self goPressed];
    
}

- (void)handleSearchForSearchString:(NSString *)searchString {
    searchQuery.location = CLLocationCoordinate2DMake(lat, lng);
    searchQuery.input = searchString;
    [searchQuery fetchPlaces:^(NSArray *places, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not fetch Places"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        } else {
            searchResultPlaces = places;
            NSLog(@"places %@",places);
            [autocompleteTableView reloadData];
        }
    }];
}


-(void) viewWillAppear:(BOOL)animated{
    
    
}

-(void) findCurrentLocation{
    
    BOOL network = [self currentNetworkStatus];
    
    if(network){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
        
    }else{
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Please turn on your internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        
    }
    
}

- (BOOL)currentNetworkStatus
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    [locationManager stopUpdatingLocation];
    
    lat = newLocation.coordinate.latitude;
    lng =newLocation.coordinate.longitude;
    //currentCentre = *(__bridge CLLocationCoordinate2D *)(newLocation);
    
}

-(NSDictionary *) queryGooglePlaces {
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?reference=%@&sensor=false&key=%@",selectedPlace.reference,@"AIzaSyAFsaDn7vyI8pS53zBgYRxu0HfRwYqH-9E"];
    
    NSLog(@"%@",url);
     NSURL *googleRequestURL=[NSURL URLWithString:url];
     NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:googleRequestURL];
    //Formulate the string as a URL object.
   
    NSError *error = nil;
     NSURLResponse *response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *singlePlace;
    if (responseData !=Nil) {
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              
                              options:kNilOptions
                              error:&error];
        
        singlePlace = [json objectForKey:@"result"];
        
        
    }
    
    NSLog(@"%@",singlePlace);
    
    //  NSLog(@"second:____________________%@",_singlePlace[0]);
    
//    name =[singlePlace objectForKey:@"name"];
//    address =[singlePlace objectForKey:@"formatted_address"];
//    phoneNumber =[singlePlace objectForKey:@"formatted_phone_number"];
 
    
    return singlePlace;
   
}

@end
