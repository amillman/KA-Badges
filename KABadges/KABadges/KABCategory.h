//
//  KABCategory.h
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KABCategory : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *details;
@property (strong, nonatomic) NSNumber *categoryNumber;
@property (strong, nonatomic) NSURL *smallIconURL;
@property (strong, nonatomic) NSURL *largeIconURL;
@property (strong, nonatomic) NSMutableArray *badges; // of KABBadges

@end
