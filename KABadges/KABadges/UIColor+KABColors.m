//
//  UIColor+KABColors.m
//  KABadges
//
//  Created by Andrew on 2/21/15.
//  Copyright (c) 2015 Andrew Millman. All rights reserved.
//

#import "UIColor+KABColors.h"

@implementation UIColor (KABColors)

+ (UIColor *)kab_mainColor {
    return [UIColor colorWithRed:105/255.0 green:156/255.0 blue:82/255.0 alpha:1];
}

+ (UIColor *)kab_meteoriteBadgeColor {
    return [UIColor colorWithRed:191/255.0 green:64/255.0 blue:40/255.0 alpha:1];
}

+ (UIColor *)kab_moonBadgeColor {
    return [UIColor colorWithRed:19/255.0 green:106/255.0 blue:115/255.0 alpha:1];
}

+ (UIColor *)kab_earthBadgeColor {
    return [UIColor colorWithRed:71/255.0 green:179/255.0 blue:101/255.0 alpha:1];
}

+ (UIColor *)kab_sunBadgeColor {
    return [UIColor colorWithRed:249/255.0 green:161/255.0 blue:27/255.0 alpha:1];
}

+ (UIColor *)kab_blackholeBadgeColor {
    return [UIColor colorWithRed:191/255.0 green:32/255.0 blue:124/255.0 alpha:1];
}

+ (UIColor *)kab_challengeBadgeColor {
    return [UIColor colorWithRed:61/255.0 green:168/255.0 blue:193/255.0 alpha:1];
}

+ (UIColor *)colorForCategory:(NSNumber *)category {
    switch ([category intValue]) {
        case 0:
            return [UIColor kab_meteoriteBadgeColor];
            break;
        case 1:
            return [UIColor kab_moonBadgeColor];
            break;
        case 2:
            return [UIColor kab_earthBadgeColor];
            break;
        case 3:
            return [UIColor kab_sunBadgeColor];
            break;
        case 4:
            return [UIColor kab_blackholeBadgeColor];
            break;
        case 5:
            return [UIColor kab_challengeBadgeColor];
            break;
        default:
            return [UIColor grayColor];
            break;
    }
}


@end
