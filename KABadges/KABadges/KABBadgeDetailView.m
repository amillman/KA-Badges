//
//  KABBadgeDetailView.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABBadgeDetailView.h"
#import "Masonry.h"
#import "KABConstants.h"
#import "UIImageView+AFNetworking.h"
#import "UIColor+KABColors.h"

@interface KABBadgeDetailView ()
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *headerView;
@end

@implementation KABBadgeDetailView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)createSubviews {
    
    _scrollView = [[UIScrollView alloc] init];
    [self addSubview:_scrollView];
    
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    [_scrollView addSubview:_headerView];
    
    _iconView = [[UIImageView alloc] init];
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView addSubview:_iconView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont boldSystemFontOfSize:30.0];
    _nameLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _nameLabel.numberOfLines = 0; // Dynamic height
    [_headerView addSubview:_nameLabel];
    
    _pointValueLabel = [[UILabel alloc] init];
    _pointValueLabel.font = [UIFont boldSystemFontOfSize:20.0];
    [_headerView addSubview:_pointValueLabel];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.font = [UIFont boldSystemFontOfSize:24.0];
    _categoryLabel.textAlignment = NSTextAlignmentCenter;
    _categoryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _categoryLabel.numberOfLines = 0; // Dynamic height
    [_scrollView addSubview:_categoryLabel];
    
    _detailsLabel = [[UILabel alloc] init];
    _detailsLabel.font = [UIFont systemFontOfSize:16.0];
    _detailsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _detailsLabel.numberOfLines = 0; // Dynamic height
    [_scrollView addSubview:_detailsLabel];
    
    _indicatorView =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_indicatorView startAnimating];
    [self addSubview:_indicatorView];
}

- (void)updateConstraints {
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(STANDARD_MARGIN));
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(_nameLabel.mas_bottom).with.offset(STANDARD_MARGIN);
    }];
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(STANDARD_MARGIN));
        make.centerX.equalTo(_headerView.mas_centerX);
        make.height.equalTo(@200);
        make.width.equalTo(@200);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_bottom).with.offset(STANDARD_MARGIN * 2);
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.trailing.equalTo(@(-STANDARD_MARGIN));
    }];
    
    [_pointValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_nameLabel.mas_bottom);
        make.trailing.equalTo(@(-STANDARD_MARGIN));
    }];
    
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom).with.offset(STANDARD_MARGIN);
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.trailing.equalTo(@(-STANDARD_MARGIN));
    }];
    
    [_detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_categoryLabel.mas_bottom).with.offset(STANDARD_MARGIN);
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.trailing.equalTo(@(-STANDARD_MARGIN));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)configureWithBadge:(KABBadge *)badge category:(KABCategory *)category placeholderImage:(UIImage *)image {    
    self.backgroundColor = [UIColor colorForCategory:category.categoryNumber];
    
    [_iconView setImageWithURL:badge.largeIconURL placeholderImage:image];
    _nameLabel.text = badge.name;
    _pointValueLabel.text = [badge.pointValue stringValue];
    _categoryLabel.text = category.name;
    _detailsLabel.text = badge.details;
}

@end
