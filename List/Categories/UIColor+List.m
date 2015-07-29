//
//  UIColor+List.m
//  List
//
//  Created by Noah Portes Chaikin on 7/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UIColor+List.h"

@implementation UIColor (List)

+ (UIColor *)list_blueColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0.141
                           green:0.498
                            blue:0.8
                           alpha:alpha];
}

+ (UIColor *)list_lightBlueColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0.314
                           green:0.639
                            blue:0.886
                           alpha:alpha];
}

+ (UIColor *)list_lightGrayColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0.945
                           green:0.945
                            blue:0.945
                           alpha:alpha];
}

+ (UIColor *)list_blackColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0.133
                           green:0.133
                            blue:0.133
                           alpha:alpha];
}

+ (UIColor *)list_grayColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0.867
                           green:0.867
                            blue:0.867
                           alpha:alpha];
}

+ (UIColor *)list_darkGrayColorAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:0.600
                           green:0.600
                            blue:0.600
                           alpha:alpha];
}

@end
