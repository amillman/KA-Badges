//
//  KABBadgesView.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "KABBadgesView.h"
#import "Masonry.h"
#import "KABConstants.h"

@implementation KABBadgesView

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
    
    _indicatorView =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_indicatorView startAnimating];
    [self addSubview:_indicatorView];
}

- (void)updateConstraints {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NAVBAR_HEIGHT + STANDARD_MARGIN * 2));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [super updateConstraints];
}

@end
