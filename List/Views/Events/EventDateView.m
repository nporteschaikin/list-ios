//
//  EventDateView.m
//  List
//
//  Created by Noah Portes Chaikin on 12/3/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventDateView.h"

@interface EventDateView ()

@property (strong, nonatomic) UILabel *monthLabel;
@property (strong, nonatomic) UILabel *dayLabel;

@end

@implementation EventDateView

static CGFloat const kEventDateViewMonthLabelHeight = 11.f;
static CGFloat const kEventDateViewMonthLabelFontSize = 12.f;
static CGFloat const kEventDateViewDayLabelHeight = 20.f;
static CGFloat const kEventDateViewDayLabelFontSize = 20.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Add subviews.
         */
        
        UILabel *monthLabel = self.monthLabel = [[UILabel alloc] init];
        monthLabel.font = [UIFont listUI_semiboldFontWithSize:kEventDateViewMonthLabelFontSize];
        monthLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:monthLabel];
        
        UILabel *dayLabel = self.dayLabel = [[UILabel alloc] init];
        dayLabel.font = [UIFont listUI_semiboldFontWithSize:kEventDateViewDayLabelFontSize];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:dayLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = 0.0f;
    y = (CGRectGetHeight(self.bounds) - (kEventDateViewMonthLabelHeight + kEventDateViewDayLabelHeight)) / 2;
    w = CGRectGetWidth(self.bounds);
    h = kEventDateViewMonthLabelHeight;
    self.monthLabel.frame = CGRectMake(x, y, w, h);
    
    y += h;
    h = kEventDateViewDayLabelHeight;
    self.dayLabel.frame = CGRectMake(x, y, w, h);
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize monthSize = [self.monthLabel sizeThatFits:CGSizeZero];
    CGSize daySize = [self.dayLabel sizeThatFits:CGSizeZero];
    CGFloat minWidth = fmaxf(monthSize.width, daySize.width);
    CGFloat minHeight = kEventDateViewMonthLabelHeight + kEventDateViewDayLabelHeight;
    return CGSizeMake(fmaxf(minWidth, size.width), fmaxf(minHeight, size.height));
}

- (void)tintColorDidChange {
    
    /*
     * Set tint color.
     */
    
    UIColor *color = self.tintColor;
    self.monthLabel.textColor = color;
    self.dayLabel.textColor = color;
    
}

#pragma mark - Dynamic setters

- (void)setDate:(NSDate *)date {
    
    /*
     * Set variable.
     */
    
    _date = date;
    
    /*
     * Set month label text.
     */
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM"];
    self.monthLabel.text = [[dateFormatter stringFromDate:date] uppercaseString];
    
    /*
     * Set day label text.
     */
    
    [dateFormatter setDateFormat:@"dd"];
    self.dayLabel.text = [dateFormatter stringFromDate:date];
    
}

@end
