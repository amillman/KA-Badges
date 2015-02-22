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

static NSString *cellIdentifier = @"Badge";

#pragma mark - View Cycle

- (void)loadView {
    self.view = [[KABBadgesView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.tableView.delegate = self;
    self.view.tableView.dataSource = self;
    
    [self getAllData];
}

#pragma mark - Networking

- (void)getAllData {
    [self getAllCategoriesAndBadges];
}

- (void)getAllCategoriesAndBadges {
    [[AFHTTPRequestOperationManager manager] GET:@"http://www.khanacademy.org/api/v1/badges/categories" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        [self.view.tableView reloadData];
    } failure:nil];
    
}

#pragma mark - TableView Delegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.badges count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cellView = nil;
        
    cellView = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cellView) {
        cellView = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:cellIdentifier];
    }
    
    KABBadge *badge = self.badges[indexPath.row];
    cellView.textLabel.text = badge.name;
    
    return cellView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - Lazy Instantiation

- (NSMutableDictionary *)categories {
    if (!_categories) {
        _categories = [[NSMutableDictionary alloc] init];
    }
    return _categories;
}

- (NSMutableArray *)badges {
    if (!_badges) {
        _badges = [[NSMutableArray alloc] init];
    }
    return _badges;
}

@end
