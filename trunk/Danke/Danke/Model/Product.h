//
//  Product.h
//  Danke
//
//  Created by Anik on 2/7/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <Parse/PFFile.h>

@interface Product : NSObject{
    
}

@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) PFFile *itemImage1;
@property (strong, nonatomic) NSData *itemImage1Data;
@property (strong, nonatomic) PFFile *itemImage2;
@property (strong, nonatomic) NSData *itemImage2Data;
@property (strong, nonatomic) NSString *postedById;
@property (strong, nonatomic) NSDate *postedDate;
@property (strong, nonatomic) NSString *pickupPlace;
@property CLLocationCoordinate2D location;
@property int point;
@property (strong, nonatomic) NSString *itemDescription;
@property BOOL contactInfoHidden;
@property (strong, nonatomic) NSString *contactInfo;

@end
