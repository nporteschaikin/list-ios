//
//  PicturesCollectionViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/18/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesCollectionViewCell.h"
#import "ListConstants.h"

@interface PicturesCollectionViewCell ()

@property (strong, nonatomic) UIView *assetContainer;
@property (strong, nonatomic) UIImageView *assetView;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) CALayer *spacerLayer;

@end

@implementation PicturesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        /*
         * Create subviews.
         */
        
        self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
        self.layer.shadowOpacity = 1.0f;
        self.layer.shadowColor = [UIColor listBlackColorAlpha:0.5f].CGColor;
        self.layer.shadowRadius = 0.0f;
        
        UIView *contentView = self.contentView;
        contentView.clipsToBounds = YES;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 2.0f;
        
        UIView *assetContainer = self.assetContainer = [[UIView alloc] init];
        assetContainer.backgroundColor = [UIColor colorWithHex:0xf1f1f1 alpha:1.0f];
        [contentView addSubview:assetContainer];
        
        UIImageView *assetView = self.assetView = [[UIImageView alloc] init];
        assetView.clipsToBounds = YES;
        assetView.layer.masksToBounds = YES;
        assetView.contentMode = UIViewContentModeScaleAspectFill;
        [assetContainer addSubview:assetView];
        
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
    h = w * 1.777777777f;
    self.assetContainer.frame = CGRectMake(x, y, w, h);
    
    w = CGRectGetWidth(self.assetContainer.bounds);
    h = CGRectGetHeight(self.assetContainer.bounds);
    self.assetView.frame = CGRectMake(x, y, w, h);
    
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
