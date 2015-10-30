//
//  HomeNewViewController.m
//  Danke
//
//  Created by Anik on 2/15/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "HomeNewViewController.h"

@implementation HomeNewViewController

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        
        // The className to query on
        self.parseClassName = ProductClassName;
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"text";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
        
        _productArray = [[NSMutableArray alloc] init];
    }
    return self;
}
/*
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // This table displays items in the Todo class
        self.parseClassName = ProductClassName;
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 25;
    }
    return self;
}
*/

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
    
}

- (IBAction)giveButtonTapped:(id)sender {
    
    GiveViewController *giveView = [self.storyboard instantiateViewControllerWithIdentifier:@"giveScreenView"];
    [self.navigationController pushViewController:giveView animated:YES];
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
     //   query.cachePolicy = kPFCachePolicyIgnoreCache;
    }
    
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeCell"];
    }
    // Configure the cell to show todo item with a priority at the bottom
    NSLog(@"object : %@", object);
    Product *p = [[Product alloc]init];
    p.objectId = object.objectId;
    p.title = object[ProductTitle];
    p.itemDescription = object[ProductDescription];
    p.postedById = object[ProductPostedById];
    p.postedDate = object.createdAt;
    
    PFFile *image = object[ProductItemImage1];
    p.itemImage1 = image;
    NSLog(@"%@",image.url);
    
    PFFile *image2 = object[ProductItemImage2];
    p.itemImage2 = image2;
    NSLog(@"%@",image2.url);
    
    [_productArray addObject:p];
    
    cell.productTitleLabel.text = p.title;
    cell.productPostedbyLabel.text = p.postedById;
    cell.productPostedTime.text = [NSString stringWithFormat:@"%@", p.postedDate];
    cell.productPicupPlace.text = p.pickupPlace;
    if (p.itemImage1) {
        [p.itemImage1 getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            // Now that the data is fetched, update the cell's image property.
            cell.productImageView.image = [UIImage imageWithData:data];
            p.itemImage1Data = data;
        }];
    }else{
        cell.productImageView.image = [UIImage imageNamed:@"photo"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GiveDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"itemDetailView"];
    detailView.product = [_productArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailView animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116.0f;
}

@end
