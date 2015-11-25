//
//  NavigationBarRoundedButton.m
//  List
//
//  Created by Noah Portes Chaikin on 11/25/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NavigationBarRoundedButton.h"

@interface NavigationBarRoundedButton ()

@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation NavigationBarRoundedButton

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
        self.layer.cornerRadius = 2.0f;
        self.titleLabel.font = [UIFont listUI_fontWithSize:13.f];
        
        /*
         * Add gradient.
         */
        
        CAGradientLayer *gradient = self.gradientLayer = [[CAGradientLayer alloc] init];
        gradient.masksToBounds = YES;
        gradient.cornerRadius = 2.0f;
        [self.layer insertSublayer:gradient atIndex:0];
        
        /*
         * Set default color.
         */
        
        self.color = NavigationBarRoundedButtonBlueColor;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     * Frame gradient layer.
     */
    
    CGFloat x, y, w, h;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.layer.bounds);
    h = CGRectGetHeight(self.layer.bounds);
    self.gradientLayer.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Dynamic setters

- (void)setColor:(NavigationBarRoundedButtonColor)color {
    
    /*
     * Store.
     */
    
    _color = color;
    
    /*
     * Determine scheme.
     */
    
    UIColor *firstColor;
    UIColor *secondColor;
    UIColor *fontColor;
    switch (color) {
        case NavigationBarRoundedButtonBlueColor: {
            firstColor = [UIColor listUI_lightBlueColorAlpha:1.0f];
            secondColor = [UIColor listUI_blueColorAlpha:1.0f];
            fontColor = [UIColor whiteColor];
            break;
        }
    }
    
    /*
     * Set items.
     */
    
    CAGradientLayer *gradientLayer = self.gradientLayer;
    gradientLayer.colors = @[ (id)firstColor.CGColor, (id)secondColor.CGColor ];
    UILabel *titleLabel = self.titleLabel;
    titleLabel.textColor = fontColor;
    
}

@end
