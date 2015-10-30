//
//  HomeTableViewCell.h
//  Danke
//
//  Created by Anik on 2/11/15.
//  Copyright (c) 2015 Anik. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPostedbyLabel;
@property (weak, nonatomic) IBOutlet UILabel *productPostedTime;
@property (weak, nonatomic) IBOutlet UILabel *productPicupPlace;

@end
