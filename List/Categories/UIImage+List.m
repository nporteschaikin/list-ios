//
//  UIImage+List.m
//  List
//
//  Created by Noah Portes Chaikin on 7/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UIImage+List.h"
#import "IonIcons.h"

@implementation UIImage (List)

+ (UIImage *)list_imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)list_imageForIcon:(LIcon)icon
                          size:(CGFloat)size
                         color:(UIColor *)color {
    NSString *string = [IonIcons list_stringForIcon:icon];
    return [IonIcons imageWithIcon:string size:size color:color];
}

@end
