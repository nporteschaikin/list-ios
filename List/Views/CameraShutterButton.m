//
//  CameraShutterButton.m
//  List
//
//  Created by Noah Portes Chaikin on 8/18/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CameraShutterButton.h"

@implementation CameraShutterButton

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, size.width);
}

- (void)drawRect:(CGRect)rect {
    UIColor *color = self.color ?: [UIColor whiteColor];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat circleSize = rect.size.width * .75;
    CGFloat strokeSize = 5.f;
    CGRect circleRect = CGRectMake((rect.size.width - circleSize) / 2, (rect.size.height - circleSize) / 2, circleSize, circleSize);
    CGRect innerCircleRect = CGRectInset(circleRect, strokeSize, strokeSize);

    CGContextClearRect(context, rect);

    CGContextAddEllipseInRect(context, rect);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);

    CGContextAddEllipseInRect(context, circleRect);
    CGContextClip(context);
    CGContextClearRect(context, circleRect);

    CGContextAddEllipseInRect(context, innerCircleRect);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextClip(context);
    CGContextFillRect(context, innerCircleRect);
}

@end