//
//  KABBadgeDetailViewController.h
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KABBadgeDetailView.h"
#import "KABBadge.h"
#import "KABCategory.h"

@interface KABBadgeDetailViewController : UIViewController
@property (strong, nonatomic) KABBadgeDetailView *view;
@property (strong, nonatomic) KABBadge *badge;
@property (strong, nonatomic) KABCategory *category;
@end
