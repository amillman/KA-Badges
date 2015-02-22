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
    [_scrollView addSubview:_headerView];
    
    _iconView = [[UIImageView alloc] init];
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView addSubview:_iconView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont boldSystemFontOfSize:30.0];
    _nameLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _nameLabel.numberOfLines = 0; // Dynamic height
    [_headerView addSubview:_nameLabel];
    
    _pointValueLabel = [[UILabel alloc] init];
    _pointValueLabel.font = [UIFont boldSystemFontOfSize:20.0];
    [_headerView addSubview:_pointValueLabel];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.font = [UIFont boldSystemFontOfSize:24.0];
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
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NAVBAR_HEIGHT + STANDARD_MARGIN * 2));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [super updateConstraints];
}


@end
