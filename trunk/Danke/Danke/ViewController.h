//
//  ViewController.h
//  Danke
//
//  Created by Anik on 2/4/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StartViewController.h"
#import <GooglePlus/GooglePlus.h>

@class GPPSignInButton;
@interface ViewController : UIViewController <GPPSignInDelegate>

@property (strong) UIActivityIndicatorView *activityIndicator;

@property (retain, nonatomic) IBOutlet GPPSignInButton *googleSignInButton;

@end

