//
//  NeederList.h
//  Danke
//
//  Created by Anik on 2/26/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "Constants.h"
#import "NeedRequest.h"


@interface NeederList : NSObject{
    NSMutableArray *needer;
}

-(NSMutableArray *)execute :(NSString *) productID andTableView:(UITableView *)tableView;

@end
