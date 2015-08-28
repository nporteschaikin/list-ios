//
//  PictureNavigationBar.m
//  List
//
//  Created by Noah Portes Chaikin on 8/27/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PictureNavigationBar.h"

@interface PictureNavigationBar ()

@property (strong, nonatomic) UIVisualEffectView *blurView;

@end

@implementation PictureNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        /*
         * Add blur view.
         */
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.blurView];
        
        /*
         * Remove background  and shadow images.
         */
        
        UIImage *image = [[UIImage alloc] init];
        self.shadowImage = image;
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = 0.0f;
    y = -CGRectGetMinY(self.frame);
    w = CGRectGetWidth(self.bounds);
    h = CGRectGetHeight(self.bounds) - y;
    self.blurView.frame = CGRectMake(x, y, w, h);
}

@end
