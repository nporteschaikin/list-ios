//
//  UIButton+List.m
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UIButton+List.h"
#import "UIColor+List.h"
#import "UIFont+List.h"
#import "IonIcons.h"

@implementation UIButton (List)

+ (UIButton *)list_buttonWithSize:(UIButtonListSize)size
                              style:(UIButtonListStyle)style {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderWidth = 2.0f;
    button.layer.cornerRadius = 3.0f;
    button.titleLabel.font = [UIFont list_buttonFont];
    
    switch (size) {
        case UIButtonListSizeSmall: {
            button.contentEdgeInsets = UIEdgeInsetsMake(7.5, 15, 7.5, 15);
            break;
        }
        case UIButtonListSizeMedium: {
            button.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
            break;
        }
        default:
            button.contentEdgeInsets = UIEdgeInsetsMake(15, 25, 15, 25);
            break;
    }
    
    switch (style) {
        case UIButtonListStyleBlue: {
            button.backgroundColor = [UIColor clearColor];
            button.layer.borderColor = [UIColor list_blueColorAlpha:1].CGColor;
            [button setTitleColor:[UIColor list_blueColorAlpha:1]
                         forState:UIControlStateNormal];
            break;
        }
        default: {
            button.backgroundColor = [UIColor clearColor];
            button.layer.borderColor = [UIColor whiteColor].CGColor;
            [button setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
            break;
        }
    }
    
    return button;
}

+ (UIButton *)list_threadsIconButtonWithSize:(CGFloat)size
                                         color:(UIColor *)color {
    return [self list_iconButtonWithIcon:ion_ios_chatbubble_outline
                                      size:size
                                     color:color];
}

+ (UIButton *)list_cameraIconButtonWithSize:(CGFloat)size
                                        color:(UIColor *)color {
    return [self list_iconButtonWithIcon:ion_ios_camera_outline
                                      size:size
                                     color:color];
}

+ (UIButton *)list_iconButtonWithIcon:(NSString *)icon
                                   size:(CGFloat)size
                                  color:(UIColor *)color {
    UIImage *image = [IonIcons imageWithIcon:icon
                                        size:size
                                       color:color];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image
            forState:UIControlStateNormal];
    [button sizeToFit];
    return button;
}

@end
