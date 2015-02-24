//
//  KABBadgeDetailView.h
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KABBadge.h"
#import "KABCategory.h"

@interface KABBadgeDetailView : UIView
- (void)configureWithBadge:(KABBadge *)badge category:(KABCategory *)category placeholderImage:(UIImage *)image;
@end
