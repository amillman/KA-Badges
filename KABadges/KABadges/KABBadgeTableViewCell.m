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

@implementation KABBadgeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setClipsToBounds:YES];
        [self createSubviews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)createSubviews {
    
    _photoView = [[UIImageView alloc] init];
    _photoView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_photoView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:18.0];
    _nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _nameLabel.numberOfLines = 0; // Dynamic Label sizes
    [self addSubview:_nameLabel];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.font = [UIFont systemFontOfSize:14.0];
    _categoryLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _categoryLabel.numberOfLines = 0; // Dynamic Label sizes
    [self addSubview:_categoryLabel];
    
    _pointValueLabel = [[UILabel alloc] init];
    _pointValueLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_pointValueLabel];
}

- (void)updateConstraints {
    
    [_photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.top.equalTo(@(STANDARD_MARGIN));
        make.width.equalTo(@(30.0f));
        make.height.equalTo(@(30.0f));
    }];
    
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_trailing).with.offset(STANDARD_MARGIN);
        make.top.equalTo(_nameLabel.mas_top);
    }];
    
    [_categoryLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_nameLabel.mas_leading);
        make.top.equalTo(_nameLabel.mas_bottom).with.offset(STANDARD_MARGIN)    ;
    }];
    
    [_pointValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@(STANDARD_MARGIN));
        make.top.equalTo(@(STANDARD_MARGIN));
    }];
    
    [super updateConstraints];
}

@end
