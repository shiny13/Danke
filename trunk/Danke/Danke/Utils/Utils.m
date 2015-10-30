//
//  Utils.m
//  Danke
//
//  Created by Anik on 2/26/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+(void)showAlert:(NSString *)title andMessage:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
    [alert show];
}

@end
