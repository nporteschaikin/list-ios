//
//  ListLoadingView.m
//  List
//
//  Created by Noah Portes Chaikin on 12/7/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListLoadingView.h"

@implementation ListLoadingView

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.backgroundColor = [UIColor clearColor];
        self.lineWidth = 2.0f;
        self.lineColor = [UIColor listUI_blueColorAlpha:1.0f];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    /*
     * Draw circle.
     */
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    CGContextAddEllipseInRect(context, CGRectMake(rect.origin.x + self.lineWidth, rect.origin.y + self.lineWidth, rect.size.width - (self.lineWidth * 2), rect.size.height - (self.lineWidth * 2)));
    CGContextSetFillColor(context, CGColorGetComponents(self.lineColor.CGColor));
    CGContextEOFillPath(context);
    
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (hidden) {
        
        /*
         * Fade out.
         */
        
        [self.layer removeAllAnimations];
        [UIView animateWithDuration:0.25f animations:^{
            self.alpha = 0.0f;
        } completion:nil];
        return;
    }
    
    /*
     * Fade in and pulse.
     */
    
    [UIView animateKeyframesWithDuration:1.0f delay:0.0f options:UIViewKeyframeAnimationOptionRepeat animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0);
            self.alpha = 1.0f;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
            self.alpha = 0.0f;
        }];
    } completion:nil];
    
}

#pragma mark - Dynamic setters

- (void)setLineColor:(UIColor *)lineColor {
    
    /*
     * Set variable.
     */
    
    _lineColor = lineColor;
    
    /*
     * Set needs display.
     */
    
    [self setNeedsDisplay];
    
}

- (void)setLineWidth:(CGFloat)lineWidth {
    
    /*
     * Set variable.
     */
    
    _lineWidth = lineWidth;
    
    /*
     * Set needs display.
     */
    
    [self setNeedsDisplay];
    
}

@end
