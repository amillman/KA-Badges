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
@property (strong, nonatomic) UILabel *pointsWordLabel;
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
    _scrollView.alwaysBounceVertical = YES;
    [self addSubview:_scrollView];
    
    _headerView = [[UIView alloc] init];
    _headerView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
    [_scrollView addSubview:_headerView];
    
    _iconView = [[UIImageView alloc] init];
    _iconView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerView addSubview:_iconView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:30.0];
    _nameLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _nameLabel.numberOfLines = 0; // Dynamic height
    [_headerView addSubview:_nameLabel];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.font = [UIFont systemFontOfSize:14.0];
    _categoryLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    _categoryLabel.textAlignment = NSTextAlignmentCenter;
    _categoryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _categoryLabel.numberOfLines = 0; // Dynamic height
    [_headerView addSubview:_categoryLabel];
    
    _detailsLabel = [[UILabel alloc] init];
    _detailsLabel.font = [UIFont systemFontOfSize:16.0];
    _detailsLabel.textColor = [UIColor whiteColor];
    _detailsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _detailsLabel.numberOfLines = 0; // Dynamic height
    [_scrollView addSubview:_detailsLabel];
    
    _pointValueLabel = [[UILabel alloc] init];
    _pointValueLabel.font = [UIFont boldSystemFontOfSize:20.0];
    _pointValueLabel.backgroundColor = [UIColor whiteColor];
    _pointValueLabel.textAlignment = NSTextAlignmentCenter;
    _pointValueLabel.layer.cornerRadius = LABEL_CORNER_RADIUS;
    _pointValueLabel.layer.masksToBounds = YES;
    [_scrollView addSubview:_pointValueLabel];
    
    _pointsWordLabel = [[UILabel alloc] init];
    _pointsWordLabel.text = @"pts";
    _pointsWordLabel.font = [UIFont boldSystemFontOfSize:20.0];
    _pointsWordLabel.textColor = [UIColor whiteColor];
    [_scrollView addSubview:_pointsWordLabel];
}

- (void)updateConstraints {
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(_categoryLabel.mas_bottom).with.offset(STANDARD_MARGIN);
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
    
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom);
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.trailing.equalTo(@(-STANDARD_MARGIN));
    }];
    
    [_detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom).with.offset(STANDARD_MARGIN);
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.trailing.equalTo(@(-STANDARD_MARGIN));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [_pointValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_detailsLabel.mas_bottom).with.offset(STANDARD_MARGIN * 2);
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.width.equalTo(@(90));
    }];
    
    [_pointsWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pointValueLabel);
        make.leading.equalTo(_pointValueLabel.mas_trailing).with.offset(STANDARD_MARGIN);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

- (void)configureWithBadge:(KABBadge *)badge category:(KABCategory *)category placeholderImage:(UIImage *)image {    
    UIColor *themeColor = [UIColor colorForCategory:category.categoryNumber];
    self.backgroundColor = themeColor;
    
    [_iconView setImageWithURL:badge.largeIconURL placeholderImage:image];
    _nameLabel.text = badge.name;
    _pointValueLabel.text = [badge.pointValue stringValue];
    _pointValueLabel.textColor = themeColor;
    _categoryLabel.text = category.name;
    _detailsLabel.text = badge.details;
}

@end
