//
//  KABBadgesView.h
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KABBadgesView : UIView
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UICollectionView *categoriesCollectionView;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end
