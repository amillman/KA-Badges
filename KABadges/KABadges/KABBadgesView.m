//
//  KABBadgesView.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABBadgesView.h"
#import "KABCategoryCollectionViewCell.h"
#import "Masonry.h"
#import "KABConstants.h"

@implementation KABBadgesView

const static float COLLECTION_VIEW_HEIGHT = 50.0f;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self _createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)_createSubviews {
    
    _tableView = [[UITableView alloc] init];
    _tableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:_tableView];
    
    _categoriesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self _createCategoriesCollectionViewLayout]];
    _categoriesCollectionView.backgroundColor = [UIColor whiteColor];
    [_categoriesCollectionView registerClass:KABCategoryCollectionViewCell.class forCellWithReuseIdentifier:@"Cell"];
    [self addSubview:_categoriesCollectionView];
    
    _indicatorView =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_indicatorView startAnimating];
    [self addSubview:_indicatorView];
}

- (void)updateConstraints {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(_categoriesCollectionView.mas_top);
    }];
    
    [_categoriesCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(COLLECTION_VIEW_HEIGHT));
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NAVBAR_HEIGHT + STANDARD_MARGIN * 2));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [super updateConstraints];
}

#pragma mark - Private Helper Methods

- (UICollectionViewLayout *)_createCategoriesCollectionViewLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setItemSize:CGSizeMake(100, COLLECTION_VIEW_HEIGHT)];
    [flowLayout setMinimumInteritemSpacing:0.f];
    [flowLayout setMinimumLineSpacing:0.f];
    [flowLayout setSectionInset:UIEdgeInsetsZero];
    
    return flowLayout;
}

@end
