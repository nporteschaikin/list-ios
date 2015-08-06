//
//  UIColor+List.m
//  List
//
//  Created by Noah Portes Chaikin on 7/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UIColor+List.h"

@implementation UIColor (List)

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

+ (UIColor *)list_blueColorAlpha:(CGFloat)alpha {
    return UIColorFromRGBWithAlpha(0x247fcc, alpha);
}

+ (UIColor *)list_lightBlueColorAlpha:(CGFloat)alpha {
    return UIColorFromRGBWithAlpha(0x50a3e2, alpha);
}

+ (UIColor *)list_greenColorAlpha:(CGFloat)alpha {
    return UIColorFromRGBWithAlpha(0x24c6cc, alpha);
}

+ (UIColor *)list_lightGrayColorAlpha:(CGFloat)alpha {
    return UIColorFromRGBWithAlpha(0xf4f4f4, alpha);
}

+ (UIColor *)list_blackColorAlpha:(CGFloat)alpha {
    return UIColorFromRGBWithAlpha(0x555555, alpha);
}

+ (UIColor *)list_lightBlackColorAlpha:(CGFloat)alpha {
    return UIColorFromRGBWithAlpha(0x777777, alpha);
}

+ (UIColor *)list_grayColorAlpha:(CGFloat)alpha {
    return UIColorFromRGBWithAlpha(0xDDDDDD, alpha);
}

+ (UIColor *)list_darkGrayColorAlpha:(CGFloat)alpha {
    return UIColorFromRGBWithAlpha(0x999999, alpha);
}

@end
