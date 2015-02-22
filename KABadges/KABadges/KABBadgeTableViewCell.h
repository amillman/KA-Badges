//
//  KABBadgeTableViewCell.h
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KABBadgeTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *photoView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *detailsLabel;
@property (strong, nonatomic) UILabel *pointValueLabel;
@end
