//
//  CategoryList.m
//  Danke
//
//  Created by Anik on 2/7/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "CategoryList.h"
#import "Constants.h"

@implementation CategoryList

-(NSMutableArray *)execute : (UICollectionView *) collectionView
{
    categories = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:CategoryClassName];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d categories.", (int)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSLog(@"%@", object.createdAt);
                ProductCategory *category = [[ProductCategory alloc]init];
                category.objectId = object.objectId;
                category.categoryName = object[CategoryName];
                category.categoryImage = object[CategoryImage];
                [categories addObject:category];
            }
            dispatch_async(dispatch_get_main_queue(), ^ {
                [collectionView reloadData];
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return categories;
    
}

@end
