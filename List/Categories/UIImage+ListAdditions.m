//
//  UIImage+ListAdditions.m
//  List
//
//  Created by Noah Portes Chaikin on 8/17/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UIImage+ListAdditions.h"

@implementation UIImage (ListAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    /*
     * Draws an image from a color.
     */
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

@end
