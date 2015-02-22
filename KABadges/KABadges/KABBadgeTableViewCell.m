//
//  KABBadgeTableViewCell.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABBadgeTableViewCell.h"

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
    [self addSubview:_nameLabel];
    
    _categoryLabel = [[UILabel alloc] init];
    _categoryLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_categoryLabel];
    
    _pointValueLabel = [[UILabel alloc] init];
    _pointValueLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:_pointValueLabel];
}

@end
