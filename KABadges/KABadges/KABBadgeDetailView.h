//
//  KABBadgeDetailView.h
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KABBadgeDetailView : UIView
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *categoryLabel;
@property (strong, nonatomic) UILabel *detailsLabel;
@property (strong, nonatomic) UILabel *pointValueLabel;
@end
