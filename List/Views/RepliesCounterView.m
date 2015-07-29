//
//  RepliesCounterView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/20/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "RepliesCounterView.h"
#import "UIFont+List.h"
#import "UIColor+List.h"
#import "UIImage+List.h"

@interface RepliesCounterView ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *numberLabel;

@end

@implementation RepliesCounterView

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
    
    [self.numberLabel sizeToFit];
    x = CGRectGetMaxX(self.iconView.frame) + 3.f;
    y = (CGRectGetMaxY(self.iconView.frame) - CGRectGetHeight(self.numberLabel.frame)) / 2;
    [self.numberLabel sizeToFit];
    w = CGRectGetWidth(self.bounds) - x;
    h = CGRectGetHeight(self.numberLabel.frame);
    self.numberLabel.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat width = CGRectGetMaxX(self.numberLabel.frame);
    CGFloat height = CGRectGetMaxY(self.iconView.frame);
    return CGSizeMake(width, height);
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage list_replyIconImageColor:[UIColor list_blueColorAlpha:1]
                                                                                      size:11.f]];
        [_iconView sizeToFit];
    }
    return _iconView;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont list_repliesCounterViewFont];
        _numberLabel.textColor = [UIColor list_blueColorAlpha:1];
        _numberLabel.numberOfLines = 1;
        _numberLabel.highlightedTextColor = [UIColor list_blackColorAlpha:1];
    }
    return _numberLabel;
}

@end
