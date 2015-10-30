//
//  GiveDetailViewController.m
//  Danke
//
//  Created by Anik on 2/8/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "GiveDetailViewController.h"

@interface GiveDetailViewController ()

@end

@implementation GiveDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _product.title;
    _postedDate.text = [NSString stringWithFormat:@"%@", _product.postedDate];
    _postedBy.text = _product.postedById;
    _pickupPlace.text = _product.pickupPlace;
    
    if (_product.itemImage1Data) {
        _productImageView1.image = [UIImage imageWithData:_product.itemImage1Data];
    }
    
    if (_product.itemImage2) {
        [_product.itemImage2 getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

            _productImageView2.image = [UIImage imageWithData:data];
            _product.itemImage2Data = data;
        }];
    }
    
    NSString *parseCurrentUser = [[PFUser currentUser] objectId];
    NSLog(@"parse user : %@", parseCurrentUser);
    NSLog(@"product user : %@",_product.postedById);
    
    if ([parseCurrentUser isEqualToString:_product.postedById]) {
     //   [_chatButton setTitle:@"Delete this Give" forState:UIControlStateNormal];
        _chatButton.enabled = NO;
        _wantButton.enabled = NO;
        _chatButton.backgroundColor = [UIColor grayColor];
        _wantButton.backgroundColor = [UIColor grayColor];
    }else{
        //need to check if user alread apply for need
    }
    
    _productList = [[NeederList alloc]init];
    
    [self.view bringSubviewToFront:self.titleandDescriptionView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _productArray = [_productList execute:_product.objectId andTableView:_mNeederTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _productArray.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%d Needer", (int)_productArray.count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NeederTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"neederCell" forIndexPath:indexPath];
    NeedRequest *product = [_productArray objectAtIndex:indexPath.row];
    NSLog(@"product : %@", product.neederID);
    NSLog(@"product date : %@", product.objectId);

    cell.NeederNameLabel.text = product.neederID;
    if ([[[PFUser currentUser] objectId] isEqualToString:_product.postedById]) {
        cell.GiveButton.hidden = NO;
    }else{
        cell.GiveButton.hidden = YES;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)mapButtonTapped:(id)sender {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 23.046;
    coordinate.longitude = 91.072;
 //   coordinate = _product.location;
    ShowinMapViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"mapView"];
    vc.location = coordinate;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)chatButtonTapped:(id)sender {
    
}

- (IBAction)wantButtonTapped:(id)sender {
    
    PFObject *testObject = [PFObject objectWithClassName:NeedRequestClassName];
    testObject[NeedRequestProductID] = _product.objectId;
    testObject[NeedRequestNeederID] = [[PFUser currentUser] objectId];
    
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //show a success alert view
            NSLog(@"successfully added in Parse. Now going to previous view controller");
            [Utils showAlert:@"Success" andMessage:@"Successfully added your request."];
            _wantButton.enabled = NO;
        } else {
            [Utils showAlert:@"Error" andMessage:@"Something went wrong while uploading to parse. please try again later."];
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

@end
