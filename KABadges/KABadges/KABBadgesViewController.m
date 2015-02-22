//
//  KABBadgesViewController.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABBadgesViewController.h"
#import "KABBadgeDetailViewController.h"
#import "KABBadgesView.h"
#import "KABBadgeTableViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "KABCategory.h"
#import "KABBadge.h"

@interface KABBadgesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) KABBadgesView *view;
@property (strong, nonatomic) NSMutableArray *categories;
@end

@implementation KABBadgesViewController

static NSString *cellIdentifier = @"Badge";

#pragma mark - ViewController Life Cycle

- (void)loadView {
    self.view = [[KABBadgesView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TitleImage"]];
    
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
            KABCategory *category = [[KABCategory alloc] init];
            category.name = categoryJSON[@"type_label"];
            category.details = categoryJSON[@"translated_description"];
            category.categoryNumber = categoryJSON[@"category"];
            category.smallIconURL = [NSURL URLWithString:categoryJSON[@"compact_icon_src"]];
            category.largeIconURL = [NSURL URLWithString:categoryJSON[@"large_icon_src"]];
            
            [self.categories addObject:category];
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
            badge.smallIconURL = [NSURL URLWithString:iconDictionary[@"email"]];
            badge.largeIconURL = [NSURL URLWithString:iconDictionary[@"large"]];
            
            KABCategory *correspondingCategory = self.categories[[badge.badgeCategory intValue]];
            [correspondingCategory.badges addObject:badge];
        }
        [self.view.tableView reloadData];
        [self.view.indicatorView stopAnimating];
    } failure:nil];
    
}

#pragma mark - TableView Delegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.categories count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KABCategory *category = self.categories[section];
    return [category.badges count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    KABCategory *category = self.categories[section];
    return category.name;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KABBadgeTableViewCell *cellView = nil;
        
    cellView = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cellView.photoView cancelImageRequestOperation];
    cellView.photoView.image = nil;
    
    if (!cellView) {
        cellView = [[KABBadgeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:cellIdentifier];
    }
    
    KABCategory *category = self.categories[indexPath.section];
    KABBadge *badge = category.badges[indexPath.row];
    cellView.nameLabel.text = badge.name;
    cellView.detailsLabel.text = badge.details;
    cellView.pointValueLabel.text = [NSString stringWithFormat:@"%@ points", [badge.pointValue stringValue]];
    [cellView.photoView setImageWithURL:badge.smallIconURL];
    
    return cellView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KABBadgeTableViewCell *selectedCell = (KABBadgeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    KABCategory *selectedCategory = self.categories[indexPath.section];
    KABBadge *selectedBadge = selectedCategory.badges[indexPath.row];
    
    KABBadgeDetailViewController *detailViewController = [[KABBadgeDetailViewController alloc] init];
    detailViewController.badge = selectedBadge;
    detailViewController.category = selectedCategory;
    [detailViewController.view configureWithBadge:selectedBadge
                                         category:selectedCategory
                                 placeholderImage:selectedCell.photoView.image];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - Lazy Instantiation

- (NSMutableArray *)categories {
    if (!_categories) {
        _categories = [[NSMutableArray alloc] init];
    }
    return _categories;
}

@end
