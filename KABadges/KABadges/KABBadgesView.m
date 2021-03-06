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

@interface KABBadgesView ()
@property (strong, nonatomic) UIView *collectionViewBorder;
@end

@implementation KABBadgesView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)_createSubviews {
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    _tableView.scrollsToTop = YES;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:_tableView];
    
    _indicatorView =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_indicatorView startAnimating];
    [_tableView addSubview:_indicatorView];
    
    _categoriesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self _createCategoriesCollectionViewLayout]];
    _categoriesCollectionView.scrollsToTop = NO;
    _categoriesCollectionView.backgroundColor = [UIColor whiteColor];
    [_categoriesCollectionView registerClass:KABCategoryCollectionViewCell.class
                  forCellWithReuseIdentifier:[KABCategoryCollectionViewCell reuseIdentifier]];
    [self addSubview:_categoriesCollectionView];
    
    _collectionViewBorder = [[UIView alloc] init];
    _collectionViewBorder.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
    [self addSubview:_collectionViewBorder];
}

- (void)updateConstraints {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(_categoriesCollectionView.mas_top);
    }];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(STANDARD_MARGIN * 2));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [_categoriesCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@([KABCategoryCollectionViewCell cellHeight]));
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [_collectionViewBorder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(_categoriesCollectionView.mas_top);
    }];
    
    [super updateConstraints];
}

#pragma mark - Private Helper Methods

- (UICollectionViewLayout *)_createCategoriesCollectionViewLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.f];
    [flowLayout setMinimumLineSpacing:0.f];
    [flowLayout setSectionInset:UIEdgeInsetsZero];
    
    return flowLayout;
}

@end
