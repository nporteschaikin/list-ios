//
//  WhiteNavigationBar.m
//  List
//
//  Created by Noah Portes Chaikin on 12/1/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "WhiteNavigationBar.h"

@implementation WhiteNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        /*
         * Create empty black image.
         */
        
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        /*
         * Set as background image.
         */
        
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
    }
    return self;
}

@end
