//
//  LIconControl.h
//  List
//
//  Created by Noah Portes Chaikin on 7/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LIconControlStyle) {
    LIconControlStyleAdd,
    LIconControlStyleRemove,
    LIconControlStyleMenu
};

@interface LIconControl : UIControl

@property (nonatomic) LIconControlStyle style;
@property (strong, nonatomic) UIColor *lineColor;

- (instancetype)initWithStyle:(LIconControlStyle)style;

@end
