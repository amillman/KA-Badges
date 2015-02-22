//
//  KABCategory.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABCategory.h"

@implementation KABCategory

- (NSMutableArray *)badges {
    if (!_badges) {
        _badges = [[NSMutableArray alloc] init];
    }
    return _badges;
}

@end
