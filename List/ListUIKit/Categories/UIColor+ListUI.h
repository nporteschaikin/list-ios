//
//  UIColor+List.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ListUI)

+ (UIColor *)colorWithHex:(uint32_t)hex alpha:(CGFloat)alpha;

+ (UIColor *)listBlackColorAlpha:(CGFloat)alpha;
+ (UIColor *)listBlueColorAlpha:(CGFloat)alpha;
+ (UIColor *)listGrayColorAlpha:(CGFloat)alpha;
+ (UIColor *)listLightBlueColorAlpha:(CGFloat)alpha;
+ (UIColor *)listLightGrayColorAlpha:(CGFloat)alpha;

@end
