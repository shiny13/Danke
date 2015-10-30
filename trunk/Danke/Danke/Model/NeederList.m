//
//  NeederList.m
//  Danke
//
//  Created by Anik on 2/26/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "NeederList.h"

@implementation NeederList

-(NSMutableArray *)execute :(NSString *) productID andTableView:(UITableView *)tableView{
    needer = [[NSMutableArray alloc]init];
    
    PFQuery *query = [PFQuery queryWithClassName:NeedRequestClassName];
    [query whereKey:NeedRequestProductID equalTo:productID];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d products.", (int)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
                NSLog(@"%@", object.createdAt);
                NeedRequest *p = [[NeedRequest alloc]init];
                p.objectId = object.objectId;
                p.neederID = object[NeedRequestNeederID];
                p.productID = object[NeedRequestProductID];
                
                [needer addObject:p];
            }
            dispatch_async(dispatch_get_main_queue(), ^ {
                if (needer.count > 0) {
                    [tableView reloadData];
                }
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    return needer;
}

@end
