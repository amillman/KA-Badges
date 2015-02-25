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
#import "KABCategoryCollectionViewCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "KABCategory.h"
#import "KABBadge.h"
#import "KABConstants.h"

@interface KABBadgesViewController () <
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout,
    UICollectionViewDataSource
>
@property (strong, nonatomic) KABBadgesView *view;
@property (strong, nonatomic) NSMutableArray *categories;
@end

@implementation KABBadgesViewController

static NSString *CATEGORIES_ENDPOINT = @"/badges/categories";
static NSString *BADGES_ENDPOINT = @"/badges";
static NSString *BADGE_CELL_IDENTIFIER = @"BadgeCell";

#pragma mark - ViewController Life Cycle

- (void)loadView {
    self.view = [[KABBadgesView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"TitleImage"]];
    
    self.view.tableView.delegate = self;
    self.view.tableView.dataSource = self;
    self.view.categoriesCollectionView.delegate = self;
    self.view.categoriesCollectionView.dataSource = self;
    
    [self _getAllData];
}

#pragma mark - Networking

- (void)_getAllData {
    [self _getAllCategoriesAndBadges];
}

- (void)_getAllCategoriesAndBadges {
    NSString *categoriesURL = [BASE_URL stringByAppendingString:CATEGORIES_ENDPOINT];
    
    __weak __typeof(self)weakSelf = self;
    [[AFHTTPRequestOperationManager manager] GET:categoriesURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        NSArray *responseCategories = responseObject;
        for(NSDictionary *categoryJSON in responseCategories) {
            KABCategory *category = [[KABCategory alloc] init];
            category.name = categoryJSON[@"type_label"];
            category.details = categoryJSON[@"translated_description"];
            category.categoryNumber = categoryJSON[@"category"];
            category.smallIconURL = [NSURL URLWithString:categoryJSON[@"compact_icon_src"]];
            category.largeIconURL = [NSURL URLWithString:categoryJSON[@"large_icon_src"]];
            
            [strongSelf.categories addObject:category];
        }
        [strongSelf.view.categoriesCollectionView reloadData];
        [strongSelf _getAllBadges];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf _alertError:@"Could not load categories."];
    }];
}

- (void)_getAllBadges {
    NSString *badgesURL = [BASE_URL stringByAppendingString:BADGES_ENDPOINT];
    
    __weak __typeof(self)weakSelf = self;
    [[AFHTTPRequestOperationManager manager] GET:badgesURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
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
            
            KABCategory *correspondingCategory = strongSelf.categories[[badge.badgeCategory intValue]];
            [correspondingCategory.badges addObject:badge];
        }
        [strongSelf.view.tableView reloadData];
        [strongSelf.view.indicatorView stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf _alertError:@"Could not load badges."];
    }];
    
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
        
    cellView = [tableView dequeueReusableCellWithIdentifier:BADGE_CELL_IDENTIFIER];
    [cellView.photoView cancelImageRequestOperation];
    cellView.photoView.image = nil;
    
    if (!cellView) {
        cellView = [[KABBadgeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:BADGE_CELL_IDENTIFIER];
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
    return 90;
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

#pragma mark - Collection Delegate/FlowLayout/DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.categories count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KABCategoryCollectionViewCell *cellView = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cellView.photoView cancelImageRequestOperation];
    cellView.photoView.image = nil;
    
    KABCategory *category = self.categories[indexPath.row];
    [cellView.photoView setImageWithURL:category.smallIconURL];
    cellView.nameLabel.text = category.name;
    return cellView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark - Private Methods

- (void)_alertError:(NSString *)message {
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorView show];
}

#pragma mark - Lazy Instantiation

- (NSMutableArray *)categories {
    if (!_categories) {
        _categories = [[NSMutableArray alloc] init];
    }
    return _categories;
}

@end
