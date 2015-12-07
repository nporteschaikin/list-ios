//
//  EventsCollectionViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/19/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventsCollectionViewCell.h"

@interface EventsCollectionViewCell ()

@property (strong, nonatomic) UIImageView *assetView;
@property (strong, nonatomic) UIView *assetOverlay;
@property (strong, nonatomic) CAGradientLayer *assetGradient;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *detailsLabel;
@property (strong, nonatomic) EventDateView *dateView;

@end

@implementation EventsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.layer.shadowColor = [UIColor listUI_blackColorAlpha:1.0f].CGColor;
        self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        self.layer.shadowOpacity = 0.05f;
        self.layer.shadowRadius = 0.0f;
        
        UIView *contentView = self.contentView;
        contentView.clipsToBounds = YES;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.borderWidth = 1.0f;
        contentView.layer.borderColor = [UIColor listUI_grayColorAlpha:0.5f].CGColor;
        contentView.layer.cornerRadius = 3.0f;
        contentView.layer.masksToBounds = YES;
        
        UIImageView *assetView = self.assetView = [[UIImageView alloc] init];
        assetView.contentMode = UIViewContentModeScaleAspectFill;
        assetView.clipsToBounds = YES;
        assetView.layer.masksToBounds = YES;
        [contentView addSubview:assetView];
        
        UIView *assetOverlay = self.assetOverlay = [[UIView alloc] init];
        [contentView addSubview:assetOverlay];
        
        CAGradientLayer *assetGradient = self.assetGradient = [[CAGradientLayer alloc] init];
        assetGradient.colors = @[ (id)[UIColor clearColor].CGColor, (id)[UIColor listUI_blackColorAlpha:1.0f].CGColor ];
        [assetOverlay.layer insertSublayer:assetGradient atIndex:0];
        
        UILabel *titleLabel = self.titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont listUI_semiboldFontWithSize:19.f];
        titleLabel.textColor = [UIColor whiteColor];
        [assetOverlay addSubview:titleLabel];
        
        UILabel *timeLabel = self.timeLabel = [[UILabel alloc] init];
        timeLabel.numberOfLines = 1;
        timeLabel.font = [UIFont listUI_fontWithSize:11.f];
        timeLabel.textColor = [UIColor whiteColor];
        [assetOverlay addSubview:timeLabel];
        
        UILabel *descriptionLabel = self.descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.font = [UIFont listUI_fontWithSize:12.f];
        descriptionLabel.textColor = [UIColor listUI_blackColorAlpha:1];
        [contentView addSubview:descriptionLabel];
        
        UIImageView *avatarView = self.avatarView = [[UIImageView alloc] init];
        avatarView.clipsToBounds = YES;
        avatarView.layer.cornerRadius = kEventsCollectionViewCellAvatarViewSize / 2;
        avatarView.layer.masksToBounds = YES;
        avatarView.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:avatarView];
        
        EventDateView *dateView = self.dateView = [[EventDateView alloc] init];
        dateView.tintColor = [UIColor colorWithWhite:1.0f alpha:0.85f];
        dateView.layer.shadowColor = [UIColor listUI_blackColorAlpha:1.0f].CGColor;
        dateView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        dateView.layer.shadowOpacity = 1.0f;
        dateView.layer.shadowRadius = 2.0f;
        [contentView addSubview:dateView];
        
        UILabel *userNameLabel = self.userNameLabel = [[UILabel alloc] init];
        userNameLabel.font = [UIFont listUI_fontWithSize:9.f];
        userNameLabel.numberOfLines = 0;
        userNameLabel.textColor = [UIColor listUI_blueColorAlpha:1];
        [contentView addSubview:userNameLabel];
        
        UILabel *detailsLabel = self.detailsLabel = [[UILabel alloc] init];
        detailsLabel.font = [UIFont listUI_fontWithSize:9.f];
        detailsLabel.textColor = [UIColor listUI_colorWithHex:0x999999 alpha:1.0f];
        [contentView addSubview:detailsLabel];
        
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
    h = w * 0.5625f;
    self.assetOverlay.frame = CGRectMake(x, y, w, h);
    self.assetGradient.frame = CGRectMake(x, y, w, h);
    
    h = CGRectGetHeight(self.assetOverlay.bounds);
    self.assetView.frame = CGRectMake(x, y, w, h);
    
    x = kEventsCollectionViewCellMargin;
    y = kEventsCollectionViewCellMargin;
    size = [self.dateView sizeThatFits:CGSizeZero];
    w = size.width;
    h = size.height;
    self.dateView.frame = CGRectMake(x, y, w, h);
    
    w = CGRectGetWidth(self.contentView.bounds) - (kEventsCollectionViewCellMargin * 2);
    size = [self.titleLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    y = CGRectGetHeight(self.assetOverlay.bounds) - (size.height + kEventsCollectionViewCellMargin);
    h = size.height;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
    
    x = kEventsCollectionViewCellMargin;
    y = CGRectGetMaxY(self.assetOverlay.frame) + kEventsCollectionViewCellMargin;
    w = CGRectGetWidth(self.contentView.bounds) - (kEventsCollectionViewCellMargin * 2);
    size = [self.descriptionLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.descriptionLabel.frame = CGRectMake(x, y, w, h);
    
    y += h + kEventsCollectionViewCellMargin;
    w = kEventsCollectionViewCellAvatarViewSize;
    h = kEventsCollectionViewCellAvatarViewSize;
    self.avatarView.frame = CGRectMake(x, y, w, h);
    
    x += w + 7.0f;
    y = y + 2.0f;
    w = CGRectGetWidth(self.contentView.bounds) - (x + kEventsCollectionViewCellMargin);
    size = [self.userNameLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.userNameLabel.frame = CGRectMake(x, y, w, h);
    
    y = y + h;
    size = [self.detailsLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.detailsLabel.frame = CGRectMake(x, y, w, h);
    
}

@end
