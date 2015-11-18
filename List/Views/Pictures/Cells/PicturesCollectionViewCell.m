//
//  PicturesCollectionViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/18/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesCollectionViewCell.h"
#import "ListConstants.h"

@interface PicturesCollectionViewCellBadge ()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *label;

@end

@implementation PicturesCollectionViewCellBadge
- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Create subviews.
         */
        
        UIImage *icon = [[UIImage listIcon:ListUIIconLocation size:7.f] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *iconView = self.iconView = [[UIImageView alloc] initWithImage:icon];
        [self addSubview:iconView];
        
        UILabel *label = self.label = [[UILabel alloc] init];
        label.numberOfLines = 1;
        label.font = [UIFont listFontWithSize:9.f];
        [self addSubview:label];
        
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    UIEdgeInsets insets = self.edgeInsets;
    CGSize labelSize = [self.label sizeThatFits:CGSizeZero];
    CGSize iconSize = [self.iconView sizeThatFits:CGSizeZero];
    CGFloat width = 0.0f;
    CGFloat height = 0.0f;
    height += insets.top;
    height += fmaxf(labelSize.height, iconSize.height);
    height += insets.bottom;
    width += insets.left;
    width += iconSize.width;
    width += 3.0f;
    width += labelSize.width;
    width += insets.right;
    return CGSizeMake(width, height);
}

- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
    [self setNeedsLayout];
}

- (void)tintColorDidChange {
    self.label.textColor = self.tintColor;
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    UIEdgeInsets insets = self.edgeInsets;
    CGSize iconSize = [self.iconView sizeThatFits:CGSizeZero];
    CGSize labelSize = [self.label sizeThatFits:CGSizeZero];
    CGFloat x, y, w, h;
    
    x = insets.left;
    y = CGRectGetMidY(self.bounds) - (iconSize.height / 2);
    w = iconSize.width;
    h = iconSize.height;
    self.iconView.frame = CGRectMake(x, y, w, h);
    
    x = x + w + 2.0f;
    y = CGRectGetMidY(self.bounds) - (labelSize.height / 2);
    w = labelSize.width;
    h = labelSize.height;
    self.label.frame = CGRectMake(x, y, w, h);
}

@end

@interface PicturesCollectionViewCell ()

@property (strong, nonatomic) UIImageView *assetView;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) CALayer *spacerLayer;
@property (strong, nonatomic) PicturesCollectionViewCellBadge *badge;

@end

@implementation PicturesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        /*
         * Create subviews.
         */
        
        UIView *contentView = self.contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 2.0f;
        contentView.layer.masksToBounds = YES;
        
        UIImageView *assetView = self.assetView = [[UIImageView alloc] init];
        assetView.clipsToBounds = YES;
        assetView.layer.masksToBounds = YES;
        assetView.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:assetView];
        
        PicturesCollectionViewCellBadge *badge = self.badge = [[PicturesCollectionViewCellBadge alloc] init];
        badge.tintColor = [UIColor whiteColor];
        badge.backgroundColor = [UIColor listBlackColorAlpha:0.75f];
        badge.layer.cornerRadius = 2.0f;
        badge.edgeInsets = UIEdgeInsetsMake(3, 6, 3, 6);
        [contentView addSubview:badge];
        
        UILabel *descriptionLabel = self.descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.font = [UIFont listFontWithSize:11.f];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.textColor = [UIColor listBlackColorAlpha:1];
        [contentView addSubview:descriptionLabel];
        
        UILabel *userNameLabel = self.userNameLabel = [[UILabel alloc] init];
        userNameLabel.font = [UIFont listFontWithSize:9.f];
        userNameLabel.numberOfLines = 0;
        userNameLabel.textColor = [UIColor listBlueColorAlpha:1];
        [contentView addSubview:userNameLabel];
        
        UILabel *dateLabel = self.dateLabel = [[UILabel alloc] init];
        dateLabel.font = [UIFont listFontWithSize:9.f];
        dateLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1.0f];
        [contentView addSubview:dateLabel];
        
        UIImageView *avatarView = self.avatarView = [[UIImageView alloc] init];
        avatarView.clipsToBounds = YES;
        avatarView.layer.cornerRadius = kPicturesCollectionViewCellAvatarViewSize / 2;
        avatarView.layer.masksToBounds = YES;
        avatarView.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:avatarView];
        
        CALayer *spacerLayer = self.spacerLayer = [[CALayer alloc] init];
        spacerLayer.backgroundColor = [UIColor colorWithHex:0xF1F1F1 alpha:1.0f].CGColor;
        [contentView.layer addSublayer:spacerLayer];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.contentView.bounds);
    h = w * 1.77777f;
    self.assetView.frame = CGRectMake(x, y, w, h);
    
    size = [self.badge sizeThatFits:CGSizeZero];
    x = CGRectGetWidth(self.contentView.bounds) - (size.width + kPicturesCollectionViewCellMargin);
    y = (y + h) - (size.height + kPicturesCollectionViewCellMargin);
    w = size.width;
    h = size.height;
    self.badge.frame = CGRectMake(x, y, w, h);
    
    x = kPicturesCollectionViewCellMargin;
    y = CGRectGetMaxY(self.assetView.frame) + kPicturesCollectionViewCellMargin;
    w = CGRectGetWidth(self.contentView.bounds) - (kPicturesCollectionViewCellMargin * 2);
    size = [self.descriptionLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.descriptionLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0.0f;
    y = y + h + kPicturesCollectionViewCellMargin;
    w = CGRectGetWidth(self.contentView.bounds);
    h = 1.0f;
    self.spacerLayer.frame = CGRectMake(x, y, w, h);
    
    x = kPicturesCollectionViewCellMargin;
    y = y + h + kPicturesCollectionViewCellMargin;
    w = kPicturesCollectionViewCellAvatarViewSize;
    h = kPicturesCollectionViewCellAvatarViewSize;
    self.avatarView.frame = CGRectMake(x, y, w, h);
    
    x = x + w + kPicturesCollectionViewCellMargin;
    y = y + 2.0f;
    w = CGRectGetWidth(self.contentView.bounds) - (x + kPicturesCollectionViewCellMargin);
    size = [self.userNameLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.userNameLabel.frame = CGRectMake(x, y, w, h);
    
    y = y + h;
    size = [self.dateLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
}

@end
