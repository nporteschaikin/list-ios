//
//  PostLocationView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/20/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostLocationView.h"
#import "UIFont+List.h"
#import "UIColor+List.h"
#import "UIImage+List.h"

@interface PostLocationView ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *locationLabel;

@end

@implementation PostLocationView

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.iconView];
    [self addSubview:self.locationLabel];
}

- (void)layoutSubviews {
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.bounds);
    y = CGRectGetMinY(self.bounds);
    w = CGRectGetWidth(self.iconView.frame);
    h = CGRectGetHeight(self.iconView.frame);
    self.iconView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.iconView.frame) + 3.f;
    y = (CGRectGetMaxY(self.iconView.frame) - CGRectGetHeight(self.locationLabel.frame)) / 2;
    w = CGRectGetWidth(self.bounds) - x;
    h = self.locationLabel.font.lineHeight;
    self.locationLabel.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = CGRectGetMaxY(self.iconView.frame);
    return CGSizeMake(size.width, height);
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage list_locationIconImageColor:[UIColor list_darkGrayColorAlpha:1]
                                                                                    size:11.f]];
        [_iconView sizeToFit];
    }
    return _iconView;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = [UIFont list_postLocationViewFont];
        _locationLabel.textColor = [UIColor list_darkGrayColorAlpha:1];
        _locationLabel.numberOfLines = 1;
    }
    return _locationLabel;
}

@end
