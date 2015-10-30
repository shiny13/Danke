//
//  HomeNewViewController.h
//  Danke
//
//  Created by Anik on 2/15/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "Constants.h"
#import "HomeTableViewCell.h"
#import "Product.h"
#import "GiveDetailViewController.h"
#import "SWRevealViewController.h"
#import "GiveViewController.h"

@interface HomeNewViewController : PFQueryTableViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property NSMutableArray *productArray;

@end
