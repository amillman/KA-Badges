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

static const CGFloat CELL_HEIGHT = 50.0f;
static const CGFloat IMAGE_DIAMETER = 30.0f;
static const CGFloat NAME_SIZE = 14.0f;

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
    _nameLabel.font = [UIFont systemFontOfSize:NAME_SIZE];
    [self.contentView addSubview:_nameLabel];
}

- (void)updateConstraints {
    
    [_photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@(STANDARD_MARGIN));
        make.top.equalTo(@(STANDARD_MARGIN));
        make.width.equalTo(@(IMAGE_DIAMETER));
        make.height.equalTo(@(IMAGE_DIAMETER));
    }];
    
    [_nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_photoView.mas_trailing).with.offset(STANDARD_MARGIN);
        make.trailing.equalTo(@(-STANDARD_MARGIN));
        make.centerY.equalTo(_photoView.mas_centerY);
    }];
    
    [super updateConstraints];
}

#pragma mark - Public Methods

+ (NSString *)reuseIdentifier {
    return @"CategoryCollectionViewCell";
}

+ (CGFloat)cellHeight {
    return CELL_HEIGHT;
}

+ (CGSize)sizeOfCellWithText:(NSString *)text {
    CGSize textSize = [text sizeWithAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:NAME_SIZE] }];
    CGFloat cellWidth = textSize.width + IMAGE_DIAMETER + STANDARD_MARGIN * 3 + 3.f; // Offset for some extra space
    return CGSizeMake(cellWidth, CELL_HEIGHT);
}

@end

