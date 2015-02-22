//
//  KABBadgesViewController.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABBadgesViewController.h"
#import "KABBadgesView.h"
#import "AFNetworking.h"
#import "KABBadge.h"

@interface KABBadgesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) KABBadgesView *view;
@property (strong, nonatomic) NSMutableDictionary *categories;
@property (strong, nonatomic) NSMutableArray *badges;
@end

@implementation KABBadgesViewController

#pragma mark - View Cycle

- (void)loadView {
    self.view = [[KABBadgesView alloc] init];
    [self getAllData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Networking

- (void)getAllData {
    [self getAllCategories];
}

- (void)getAllCategories {
    [[AFHTTPRequestOperationManager manager] GET:@"http://www.khanacademy.org/api/v1/categories" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *responseCategories = responseObject;
        for(NSDictionary *categoryJSON in responseCategories) {
            [self.categories setObject:categoryJSON[@"type_label"] forKey:categoryJSON[@"category"]];
        }
        [self getAllBadges];
    } failure:nil];
}

- (void)getAllBadges {
    [[AFHTTPRequestOperationManager manager] GET:@"http://www.khanacademy.org/api/v1/badges" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *responseBadges = responseObject;
        for(NSDictionary *badgeJSON in responseBadges) {
            KABBadge *badge = [[KABBadge alloc] init];
            badge.name = badgeJSON[@"description"];
            badge.details = badgeJSON[@"safe_extended_description"];
            badge.badgeCategory = badgeJSON[@"badge_category"];
            badge.pointValue = badgeJSON[@"points"];
            
            NSDictionary *iconDictionary = badgeJSON[@"icons"];
            badge.smallIconURL = iconDictionary[@"compact"];
            badge.largeIconURL = iconDictionary[@"large"];
            
            [self.badges addObject:badge];
        }
    } failure:nil];
    
}
@end
