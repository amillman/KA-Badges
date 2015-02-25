//
//  KABBadgeTableViewCell.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABBadgeTableViewCell.h"
#import "Masonry.h"
#import "KABConstants.h"
#import "UIImageView+AFNetworking.h"

@implementation KABBadgeTableViewCell

static const CGFloat CELL_HEIGHT = 90.0f;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setClipsToBounds:YES];
        [self _createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)dealloc {
    [self.photoView cancelImageRequestOperation];
}

- (void)_createSubviews {
    
    _photoView = [[UIImageView alloc] init];
    _photoView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_photoView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:18.0];
    [self.contentView addSubview:_nameLabel];
    
    _detailsLabel = [[UILabel alloc] init];
    _detailsLabel.font = [UIFont systemFontOfSize:14.0];
    _detailsLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    [self.contentView addSubview:_detailsLabel];
    
    _pointValueLabel = [[UILabel alloc] init];
    _pointValueLabel.font = [UIFont systemFontOfSize:14.0];
    _pointValueLabel.textColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    [self.contentView addSubview:_pointValueLabel];
}

- (void)updateConstraints {
    
    [_photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.top.equalTo(@(STANDARD_MARGIN));
        make.width.equalTo(@(40.0f));
        make.height.equalTo(@(40.0f));
    }];
    
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_photoView.mas_trailing).with.offset(STANDARD_MARGIN);
        make.trailing.equalTo(@(-STANDARD_MARGIN));
        make.centerY.equalTo(_photoView.mas_centerY);
    }];
    
    [_detailsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_leading);
        make.trailing.equalTo(@(-STANDARD_MARGIN));
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(STANDARD_MARGIN / 2);
    }];
    
    [_pointValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_detailsLabel.mas_bottom);
    }];
    
    
    [super updateConstraints];
}

#pragma mark - Public Methods

+ (NSString *)reuseIdentifier {
    return @"BadgeCell";
}

+ (CGFloat)cellHeight {
    return CELL_HEIGHT;
}

@end
