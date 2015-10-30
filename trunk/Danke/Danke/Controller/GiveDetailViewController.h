//
//  GiveDetailViewController.h
//  Danke
//
//  Created by Anik on 2/8/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Constants.h"
#import <Parse/Parse.h>
#import "Utils.h"
#import "NeederList.h"
#import "NeederTableViewCell.h"
#import "ShowinMapViewController.h"


@interface GiveDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property Product *product;

@property NeederList *productList;
@property NSMutableArray *productArray;

@property (weak, nonatomic) IBOutlet UIImageView *productImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView2;
@property (weak, nonatomic) IBOutlet UILabel *pickupPlace;
@property (weak, nonatomic) IBOutlet UILabel *postedBy;
@property (weak, nonatomic) IBOutlet UILabel *postedDate;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIView *titleandDescriptionView;
@property (weak, nonatomic) IBOutlet UIButton *wantButton;
@property (weak, nonatomic) IBOutlet UITableView *mNeederTableView;

@end
