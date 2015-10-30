//
//  HomeViewController.h
//  Danke
//
//  Created by Anik on 2/6/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductList.h"
#import "HomeTableViewCell.h"

@interface HomeViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property ProductList *productList;
@property NSMutableArray *productArray;

@end
