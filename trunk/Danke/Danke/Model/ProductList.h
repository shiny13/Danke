//
//  ProductList.h
//  Danke
//
//  Created by Anik on 2/7/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Constants.h"
#import "Product.h"

@interface ProductList : NSObject{
    NSMutableArray *products;
}

-(NSMutableArray *)execute : (UITableView *)tableView;

@end
