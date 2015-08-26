//
//  UIColor+List.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UIColor+ListUI.h"

@implementation UIColor (ListUI)

/*
 * Method which takes hexadecimal color
 * values and turns them into valid
 * UIColor objects.
 */

+ (UIColor *)colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

/*
 * List colors.
 */

+ (UIColor *)listBlackColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithHex:0x222222 alpha:alpha];
}

+ (UIColor *)listBlueColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithHex:0x247fcc alpha:alpha];
}

+ (UIColor *)listGrayColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithHex:0x999999 alpha:alpha];
}

+ (UIColor *)listLightBlueColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithHex:0x50a3e2 alpha:alpha];
}

+ (UIColor *)listLightGrayColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithHex:0xE4E4E6 alpha:alpha];
}

@end
