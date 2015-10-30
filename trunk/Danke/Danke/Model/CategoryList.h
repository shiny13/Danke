//
//  CategoryList.h
//  Danke
//
//  Created by Anik on 2/7/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "ProductCategory.h"

@interface CategoryList : NSObject{
    NSMutableArray *categories;
}

-(NSMutableArray *)execute : (UICollectionView *) collectionView;

@end
