//
//  KABBadge.h
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KABBadge : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *details;
@property (strong, nonatomic) NSURL *smallIconURL;
@property (strong, nonatomic) NSURL *largeIconURL;
@property (strong, nonatomic) NSNumber *badgeCategory;
@property (strong, nonatomic) NSNumber *pointValue;

@end
