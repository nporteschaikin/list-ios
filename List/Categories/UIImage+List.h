//
//  UIImage+List.h
//  List
//
//  Created by Noah Portes Chaikin on 7/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IonIcons+LIcon.h"

@interface UIImage (List)

+ (UIImage *)list_imageWithColor:(UIColor *)color;
+ (UIImage *)list_imageForIcon:(LIcon)icon
                          size:(CGFloat)size
                         color:(UIColor *)color;

@end
