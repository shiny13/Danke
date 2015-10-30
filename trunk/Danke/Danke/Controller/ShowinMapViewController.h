//
//  ShowinMapViewController.h
//  Danke
//
//  Created by Anik on 2/26/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"


@interface ShowinMapViewController : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property CLLocationCoordinate2D location;

@end
