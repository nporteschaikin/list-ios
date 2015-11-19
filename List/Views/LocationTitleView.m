//
//  LocationTitleView.m
//  List
//
//  Created by Noah Portes Chaikin on 11/18/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationTitleView.h"

@interface LocationTitleView ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation LocationTitleView

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Add subviews.
         */
        
        UIImageView *iconView = self.iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        
        UILabel *titleLabel = self.titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 1;
        titleLabel.font = [UIFont listSemiboldFontWithSize:15.f];
        [self addSubview:titleLabel];
        
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat width = 0.0f;
    CGFloat height = 0.0f;
    CGSize iconSize = [self.iconView sizeThatFits:CGSizeZero];
    CGSize labelSize = [self.titleLabel sizeThatFits:CGSizeZero];
    width += iconSize.width;
    width += 6.0f;
    width += labelSize.width;
    height += fmaxf(iconSize.height, labelSize.height);
    return CGSizeMake(width, height);
}

- (void)tintColorDidChange {
    self.titleLabel.textColor = self.tintColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    size = [self.iconView sizeThatFits:CGSizeZero];
    x = 0.0f;
    y = CGRectGetMidY(self.bounds) - (size.height / 2);
    w = size.width;
    h = size.height;
    self.iconView.frame = CGRectMake(x, y, w, h);
    
    size = [self.titleLabel sizeThatFits:CGSizeZero];
    x = x + w + 6.0f;
    y = CGRectGetMidY(self.bounds) - (size.height / 2);
    w = size.width;
    h = size.height;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.iconView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
