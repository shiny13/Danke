//
//  ShowinMapViewController.m
//  Danke
//
//  Created by Anik on 2/26/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "ShowinMapViewController.h"

#define METERS_PER_MILE 1609.344

@interface ShowinMapViewController ()

@end

@implementation ShowinMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 23.046;
    coordinate.longitude = 91.072;

    Annotation *annotation = [[Annotation alloc] initWithName:@"demo" subtitle:@"subtitle" coordinate:coordinate] ;
    [_mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
