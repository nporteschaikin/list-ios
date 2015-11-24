//
//  BlurNavigationBar.m
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "BlurNavigationBar.h"

@interface BlurNavigationBar ()

@property (strong, nonatomic) UIVisualEffectView *blurView;

@end

@implementation BlurNavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        /*
         * Add blur view.
         */
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.blurView];
        
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