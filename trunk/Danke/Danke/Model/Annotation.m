//
//  Annotation.m
//  Danke
//
//  Created by Anik on 2/26/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

- (id)initWithName:(NSString*)title subtitle:(NSString*)subtitle coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _title;
}

- (NSString *)subtitle {
    return _subtitle;
}

- (void)setTitle:(NSString *)title {

    _title = title;
}

- (void)setSubtitle:(NSString *)subtitle {

    _subtitle = subtitle;
}

- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

@end
