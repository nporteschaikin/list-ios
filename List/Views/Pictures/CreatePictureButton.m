//
//  CreatePictureButton.m
//  List
//
//  Created by Noah Portes Chaikin on 8/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePictureButton.h"

@interface CreatePictureButton ()

@property (strong, nonatomic) CAShapeLayer *circleLayer;

@end

@implementation CreatePictureButton

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.iconWidth = 60.f;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(self.iconWidth, self.iconWidth * .66);
}

- (void)drawRect:(CGRect)rect {
    UIColor *color = self.iconColor;
    
    CGFloat x, y, w, h;
    w = self.iconWidth;
    h = self.iconWidth * .66;
    x = (CGRectGetWidth(rect) - w) / 2;
    y = (CGRectGetHeight(rect) - h) / 2;
    CGRect outerRect = CGRectMake(x, y, w, h);
    UIBezierPath *outerRectPath = [UIBezierPath bezierPathWithRoundedRect:outerRect cornerRadius:3.0f];
    
    w = self.iconWidth * .33;
    h = w;
    x = (CGRectGetWidth(rect) - w) / 2;
    y = (CGRectGetHeight(rect) - h) / 2;
    CGRect circleRect = CGRectMake(x, y, w, h);
    CGRect innerCircleRect = CGRectInset(circleRect, 3.0f, 3.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(context, outerRectPath.CGPath);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    
    CGContextAddEllipseInRect(context, circleRect);
    CGContextClip(context);
    CGContextClearRect(context, circleRect);
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, circleRect);
    
    CGContextAddEllipseInRect(context, innerCircleRect);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextClip(context);
    CGContextFillRect(context, innerCircleRect);
}

- (void)setIconWidth:(CGFloat)iconWidth {
    
    /*
     * Set variable.
     */
    
    _iconWidth = iconWidth;
    
    /*
     * Set needs display.
     */
    
    [self setNeedsDisplay];
    
}

- (void)setIconColor:(UIColor *)iconColor {
    
    /*
     * Set variable.
     */
    
    _iconColor = iconColor;
    
    /*
     * Set needs display.
     */
    
    [self setNeedsDisplay];
    
}

@end
