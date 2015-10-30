//
//  User.h
//  Danke
//
//  Created by Anik on 2/7/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface User : NSObject{
    
}

@property NSString *objectId;
@property NSString *name;
@property NSString *fbId;
@property NSString *fbAccessCode;
@property NSString *googleId;
@property NSString *googleAccessCode;
@property NSString *language;
@property CLLocationCoordinate2D location;
@property int totalGive;
@property int totalNeed;
@property NSString *profilePicture;

@end
