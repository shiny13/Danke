//
//  Annotation.h
//  Danke
//
//  Created by Anik on 2/26/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotation : NSObject<MKAnnotation>{
    NSString *_title;
    NSString *_subtitle;
    
    CLLocationCoordinate2D _coordinate;
}

- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;
- (id)initWithName:(NSString*)title subtitle:(NSString*)subtitle coordinate:(CLLocationCoordinate2D)coordinate;
@end
