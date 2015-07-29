//
//  MenuViewFooterView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/23/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MenuViewFooterView.h"
#import "UIColor+List.h"
#import "UIFont+List.h"
#import "UIImage+List.h"

@interface MenuViewFooterView ()

@property (strong, nonatomic) UIImageView *locationImageView;
@property (strong, nonatomic) UILabel *locationLabel;

@end

@implementation MenuViewFooterView

static CGFloat const MenuViewFooterViewPaddingX = 12.f;
static CGFloat const MenuViewFooterViewPaddingY = 20.f;

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    /*
     * Add subviews.
     */
    
    [self addSubview:self.locationLabel];
    [self addSubview:self.locationImageView];
    
    /*
     * Set background to blue.
     */
    
    self.backgroundColor = [UIColor list_blueColorAlpha:1];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = MenuViewFooterViewPaddingX;
    y = MenuViewFooterViewPaddingY;
    w = CGRectGetWidth(self.locationImageView.frame);
    h = CGRectGetHeight(self.locationImageView.frame);
    self.locationImageView.frame = CGRectMake(x, y, w, h);
    
    x = x + w + 3.0f;
    y = CGRectGetMidY(self.locationImageView.frame) - (self.locationLabel.font.lineHeight / 2);
    w = CGRectGetWidth(self.bounds) - x -  MenuViewFooterViewPaddingX;
    h = self.locationLabel.font.lineHeight;
    self.locationLabel.frame = CGRectMake(x, y, w, h);
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = 0.0f;
    height += MenuViewFooterViewPaddingY;
    height += CGRectGetHeight(self.locationImageView.frame);
    height += MenuViewFooterViewPaddingY;
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (UIImageView *)locationImageView {
    if (!_locationImageView) {
        _locationImageView = [[UIImageView alloc] initWithImage:[UIImage list_locationIconImageColor:[UIColor whiteColor]
                                                                                             size:20.f]];
        [_locationImageView sizeToFit];
    }
    return _locationImageView;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.numberOfLines = 1.0f;
        _locationLabel.textColor = [UIColor whiteColor];
        _locationLabel.font = [UIFont list_menuViewFooterLocationFont];
    }
    return _locationLabel;
}

@end
