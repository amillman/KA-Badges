//
//  KABCategoryCollectionViewCell.m
//  KABadges
//
//  Created by Andrew on 2/24/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABCategoryCollectionViewCell.h"
#import "Masonry.h"
#import "KABConstants.h"
#import "UIImageView+AFNetworking.h"

@implementation KABCategoryCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
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
    _nameLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nameLabel];
}

- (void)updateConstraints {
    
    [_photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.top.equalTo(@(STANDARD_MARGIN));
        make.width.equalTo(@(30.0f));
        make.height.equalTo(@(30.0f));
    }];
    
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_photoView.mas_trailing).with.offset(STANDARD_MARGIN);
        make.trailing.equalTo(@(-STANDARD_MARGIN));
        make.centerY.equalTo(_photoView.mas_centerY);
    }];
    
    [super updateConstraints];
}

@end

