//
//  KABBadgeDetailViewController.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABBadgeDetailViewController.h"

@implementation KABBadgeDetailViewController

#pragma mark - ViewController Life Cycle

- (void)loadView {
    self.view = [[KABBadgeDetailView alloc] init];
}

#pragma mark - Lazy Instantiation

- (KABBadge *)badge {
    if (!_badge ) {
        _badge = [[KABBadge alloc] init];
    }
    return _badge;
}

- (KABCategory *)category {
    if (!_category ) {
        _category = [[KABCategory alloc] init];
    }
    return _category;
}

@end
