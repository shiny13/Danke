//
//  ProductList.m
//  Danke
//
//  Created by Anik on 2/7/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "ProductList.h"


@implementation ProductList

-(NSMutableArray *)execute : (UITableView *)tableView
{
    products = [[NSMutableArray alloc]init];

    PFQuery *query = [PFQuery queryWithClassName:ProductClassName];
    [query orderByDescending:@"createdAt"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d products.", (int)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSLog(@"%@", object.createdAt);
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
                
                [products addObject:p];
            }
            dispatch_async(dispatch_get_main_queue(), ^ {
                [tableView reloadData];
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return products;
    
}

@end
