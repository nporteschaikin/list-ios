//
//  ListLabelView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListLabelView.h"
#import "UIFont+List.h"

@interface ListLabelView ()

@property (strong, nonatomic) LIconView *iconView;
@property (strong, nonatomic) UILabel *counterLabel;

@end

@implementation ListLabelView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.iconView];
        [self addSubview:self.counterLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    size = [self.iconView sizeThatFits:CGSizeZero];
    x = 0.0f;
    y = 0.0f;
    w = size.width;
    h = size.height;
    self.iconView.frame = CGRectMake(x, y, w, h);
    
    size = [self.counterLabel sizeThatFits:CGSizeZero];
    x = w + 3.f;
    w = size.width;
    h = size.height;
    self.counterLabel.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize labelSize = [self.counterLabel sizeThatFits:CGSizeZero];
    CGSize iconSize = [self.iconView sizeThatFits:CGSizeZero];
    return CGSizeMake(labelSize.width + iconSize.width + 3.f, fmaxf(labelSize.height, iconSize.height));
}

#pragma mark - Dynamic getters

- (LIconView *)iconView {
    if (!_iconView) {
        _iconView = [[LIconView alloc] init];
        _iconView.iconSize = self.counterLabel.font.lineHeight;
    }
    return _iconView;
}

- (UILabel *)counterLabel {
    if (!_counterLabel) {
        _counterLabel = [[UILabel alloc] init];
        _counterLabel.numberOfLines = 0;
        _counterLabel.font = [UIFont list_listLabelViewDefaultFont];
    }
    return _counterLabel;
}

#pragma mark - Dynamic setters

- (void)setText:(NSString *)text {
    _text = text;
    self.counterLabel.text = text;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.counterLabel.textColor = color;
    self.iconView.iconColor = color;
}

- (void)setIcon:(LIcon)icon {
    _icon = icon;
    self.iconView.icon = icon;
}

@end
