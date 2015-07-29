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

/*
 * Utils
 */

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

/*
 * Icons
 */

+ (UIImage *)list_threadsIconImageColor:(UIColor *)color
                                     size:(CGFloat)size {
    return [IonIcons imageWithIcon:ion_ios_chatbubble
                              size:size
                             color:color];
}

+ (UIImage *)list_locationIconImageColor:(UIColor *)color
                                 size:(CGFloat)size {
    return [IonIcons imageWithIcon:ion_ios_paperplane
                              size:size
                             color:color];
}

+ (UIImage *)list_replyIconImageColor:(UIColor *)color
                                   size:(CGFloat)size {
    return [IonIcons imageWithIcon:ion_ios_redo
                              size:size
                             color:color];
}

+ (UIImage *)list_searchIconImageColor:(UIColor *)color
                                    size:(CGFloat)size {
    return [IonIcons imageWithIcon:ion_ios_search_strong
                              size:size
                             color:color];
}


+ (UIImage *)list_menuIconImageColor:(UIColor *)color
                                  size:(CGFloat)size {
    return [IonIcons imageWithIcon:ion_ios_list
                              size:size
                             color:color];
}

+ (UIImage *)list_peopleIconImageColor:(UIColor *)color
                                    size:(CGFloat)size {
    return [IonIcons imageWithIcon:ion_ios_people
                              size:size
                             color:color];
}

+ (UIImage *)list_personIconImageColor:(UIColor *)color
                                    size:(CGFloat)size {
    return [IonIcons imageWithIcon:ion_ios_person
                              size:size
                             color:color];
}

@end
