//
//  ThreadsCounterView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ThreadsCounterView.h"
#import "UIFont+List.h"
#import "UIColor+List.h"
#import "UIImage+List.h"

@interface ThreadsCounterView ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *numberLabel;

@end

@implementation ThreadsCounterView

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.iconView];
    [self addSubview:self.numberLabel];
}

- (void)layoutSubviews {
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.bounds);
    y = CGRectGetMinY(self.bounds);
    w = CGRectGetWidth(self.iconView.frame);
    h = CGRectGetHeight(self.iconView.frame);
    self.iconView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconView.frame) + 3.f;
    y = (CGRectGetMaxY(self.iconView.frame) - CGRectGetHeight(self.numberLabel.frame)) / 2;
    [self.numberLabel sizeToFit];
    w = CGRectGetWidth(self.bounds) - x;
    h = CGRectGetHeight(self.numberLabel.frame);
    self.numberLabel.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat width = CGRectGetWidth(self.iconView.frame) + 3.0f + CGRectGetWidth(self.numberLabel.frame);
    CGFloat height = CGRectGetHeight(self.iconView.frame);
    return CGSizeMake(width, height);
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage list_threadsIconImageColor:[UIColor list_blueColorAlpha:1]
                                                                                       size:11.f]];
        [_iconView sizeToFit];
    }
    return _iconView;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont list_threadsCounterViewFont];
        _numberLabel.textColor = [UIColor list_blueColorAlpha:1];
        _numberLabel.numberOfLines = 1;
        _numberLabel.highlightedTextColor = [UIColor list_blackColorAlpha:1];
    }
    return _numberLabel;
}

@end
