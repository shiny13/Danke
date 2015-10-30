//
//  CetegoryViewController.h
//  Danke
//
//  Created by Anik on 2/7/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryList.h"

@interface CetegoryViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) CategoryList *categoryList;
@property (strong, nonatomic) NSMutableArray *categoryArray;

@end
