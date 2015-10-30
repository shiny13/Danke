//
//  HomeViewController.m
//  Danke
//
//  Created by Anik on 2/6/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "GiveViewController.h"
#import "GiveDetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


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
    _productList = [[ProductList alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _productArray = [_productList execute:self.tableView];
}

- (IBAction)giveButtonTapped:(id)sender {
    
    GiveViewController *giveView = [self.storyboard instantiateViewControllerWithIdentifier:@"giveScreenView"];
    [self.navigationController pushViewController:giveView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _productArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
 
 // Configure the cell...
    Product *product = [_productArray objectAtIndex:indexPath.row];
    NSLog(@"product : %@", product.title);
    NSLog(@"product date : %@", product.postedDate);
    cell.productTitleLabel.text = product.title;
    cell.productPostedbyLabel.text = product.postedById;
    cell.productPostedTime.text = [NSString stringWithFormat:@"%@", product.postedDate];
    cell.productPicupPlace.text = product.pickupPlace;
    if (product.itemImage1) {
   //     cell.productImageView = [[PFImageView alloc] init];
   //     cell.productImageView.file = product.itemImage1;
   //     [cell.productImageView loadInBackground];
        [product.itemImage1 getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            // Now that the data is fetched, update the cell's image property.
            cell.productImageView.image = [UIImage imageWithData:data];
            product.itemImage1Data = data;
        }];
    }else{
        cell.productImageView.image = [UIImage imageNamed:@"photo"];
    }
    
 
 return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GiveDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"itemDetailView"];
    detailView.product = [_productArray objectAtIndex:indexPath.row];;
    [self.navigationController pushViewController:detailView animated:YES];
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
