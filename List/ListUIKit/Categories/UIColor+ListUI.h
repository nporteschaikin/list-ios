//
//  UIColor+List.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ListUI)

+ (UIColor *)listUI_colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

+ (UIColor *)listUI_blackColorAlpha:(CGFloat)alpha;
+ (UIColor *)listUI_blueColorAlpha:(CGFloat)alpha;
+ (UIColor *)listUI_grayColorAlpha:(CGFloat)alpha;
+ (UIColor *)listUI_lightBlueColorAlpha:(CGFloat)alpha;
+ (UIColor *)listUI_lightGrayColorAlpha:(CGFloat)alpha;

@end
