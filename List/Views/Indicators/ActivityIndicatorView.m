//
//  ActivityIndicatorView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ActivityIndicatorView.h"
#import "UIColor+List.h"

@interface ActivityIndicatorView ()

@property (nonatomic) ActivityIndicatorViewStyle style;
@property (nonatomic) BOOL isAnimating;

@end

@implementation ActivityIndicatorView

static CGFloat const ActivityIndicatorViewLineWidth = 1.0f;

- (id)initWithStyle:(ActivityIndicatorViewStyle)style {
    if (self = [super init]) {
        self.style = style;
        
        /*
         * By default, background should be
         * clear, not black.
         */
        
        self.backgroundColor = [UIColor clearColor];
        
        /*
         * Hide by default.
         */
        
        self.hidden = YES;
        
        /*
         * Should be clear by default.
         */
        
        self.alpha = 0.0f;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    CGContextAddEllipseInRect(context, CGRectMake(rect.origin.x + ActivityIndicatorViewLineWidth,
                                                  rect.origin.y + ActivityIndicatorViewLineWidth,
                                                  rect.size.width - (ActivityIndicatorViewLineWidth * 2),
                                                  rect.size.height - (ActivityIndicatorViewLineWidth * 2)));
    UIColor *color;
    switch (self.style) {
        case ActivityIndicatorViewStyleBlue: {
            color = [UIColor list_blueColorAlpha:1];
            break;
        }
        default: {
            color = [UIColor colorWithRed:255.0f
                                    green:255.0f
                                     blue:255.0f
                                    alpha:1.0f];
            break;
        }
    }
    
    CGContextSetFillColor(context, CGColorGetComponents(color.CGColor));
    CGContextEOFillPath(context);
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (hidden) {
        [self.layer removeAllAnimations];
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.alpha = 0.0f;
                         } completion:nil];
    } else {
        [UIView animateKeyframesWithDuration:1.0f
                                       delay:0.0f
                                     options:UIViewKeyframeAnimationOptionRepeat
                                  animations:^{
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0
                                                              relativeDuration:0.5
                                                                    animations:^{
                                                                        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0);
                                                                        self.alpha = 1.0f;
                                                                    }];
                                      [UIView addKeyframeWithRelativeStartTime:0.5
                                                              relativeDuration:0.5
                                                                    animations:^{
                                                                        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                                                        self.alpha = 0.0f;
                                                                    }];
                                      
                                  } completion:nil];
    }
}

@end
