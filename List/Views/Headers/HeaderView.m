//
//  HeaderView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "HeaderView.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface HeaderView ()

@property (strong, nonatomic) LIconControl *iconControl;
@property (strong, nonatomic) UILabel *textLabel;

@end

@implementation HeaderView

static CGFloat const HeaderViewHeight = 45.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Default x margin
         */
        
        self.xMargin = 12.f;
        
        /*
         * Default icon control position.
         */
        
        self.iconControlPosition = HeaderViewIconControlPositionLeft;
        
        /*
         * Set background.
         */
        
        self.backgroundColor = [UIColor list_blueColorAlpha:1];
        
        /*
         * Add icon control subview.
         */
        
        [self addSubview:self.iconControl];
        [self addSubview:self.textLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = self.iconControlPosition == HeaderViewIconControlPositionLeft ? self.xMargin
        : (CGRectGetWidth(self.bounds) - (self.xMargin + (HeaderViewHeight * 0.6)));
    y = CGRectGetMidY(self.bounds) - ((HeaderViewHeight * 0.6) / 2);
    w = HeaderViewHeight * 0.6;
    h = w;
    self.iconControl.frame = CGRectMake(x, y, w, h);
    
    x = self.xMargin + (self.iconControlPosition == HeaderViewIconControlPositionLeft ? CGRectGetMaxX(self.iconControl.frame) : 0.0f);
    y = CGRectGetMidY(self.bounds) - (self.textLabel.font.lineHeight / 2);
    w = CGRectGetWidth(self.bounds) - x - (self.iconControlPosition == HeaderViewIconControlPositionLeft ? self.xMargin : (CGRectGetMinY(self.iconControl.frame) + self.xMargin));
    h = self.textLabel.font.lineHeight;
    self.textLabel.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (LIconControl *)iconControl {
    if (!_iconControl) {
        _iconControl = [[LIconControl alloc] init];
        _iconControl.lineColor = [UIColor whiteColor];
    }
    return _iconControl;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont list_headerViewFont];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.numberOfLines = 1;
    }
    return _textLabel;
}

@end
