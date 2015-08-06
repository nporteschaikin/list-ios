//
//  UIButton+List.h
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIButtonListSize) {
    UIButtonListSizeSmall,
    UIButtonListSizeMedium,
    UIButtonListSizeLarge
};

typedef NS_ENUM(NSUInteger, UIButtonListStyle) {
    UIButtonListStyleBlue,
    UIButtonListStyleWhite
};

@interface UIButton (List)

+ (UIButton *)list_buttonWithSize:(UIButtonListSize)size
                              style:(UIButtonListStyle)style;

+ (UIButton *)list_threadsIconButtonWithSize:(CGFloat)size
                                         color:(UIColor *)color;
+ (UIButton *)list_cameraIconButtonWithSize:(CGFloat)size
                                        color:(UIColor *)color;

@end
