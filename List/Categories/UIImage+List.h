//
//  UIImage+List.h
//  List
//
//  Created by Noah Portes Chaikin on 7/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (List)

/*
 * Utils
 */

+ (UIImage *)list_imageWithColor:(UIColor *)color;

/*
 * Icons
 */

+ (UIImage *)list_threadsIconImageColor:(UIColor *)color
                                     size:(CGFloat)size;
+ (UIImage *)list_locationIconImageColor:(UIColor *)color
                                 size:(CGFloat)size;
+ (UIImage *)list_replyIconImageColor:(UIColor *)color
                                   size:(CGFloat)size;
+ (UIImage *)list_searchIconImageColor:(UIColor *)color
                                    size:(CGFloat)size;
+ (UIImage *)list_menuIconImageColor:(UIColor *)color
                                  size:(CGFloat)size;
+ (UIImage *)list_peopleIconImageColor:(UIColor *)color
                                    size:(CGFloat)size;
+ (UIImage *)list_personIconImageColor:(UIColor *)color
                                    size:(CGFloat)size;

@end
