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
@property (strong, nonatomic) UILabel *detailsLabel;

@end

@implementation PicturesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        /*
         * Create subviews.
         */
        
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
        
        UIView *assetContainer = self.assetContainer = [[UIView alloc] init];
        assetContainer.backgroundColor = [UIColor listUI_colorWithHex:0xf1f1f1 alpha:1.0f];
        [contentView addSubview:assetContainer];
        
        UIImageView *assetView = self.assetView = [[UIImageView alloc] init];
        assetView.clipsToBounds = YES;
        assetView.layer.masksToBounds = YES;
        assetView.contentMode = UIViewContentModeScaleAspectFill;
        [assetContainer addSubview:assetView];
        
        UILabel *descriptionLabel = self.descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.font = [UIFont listUI_fontWithSize:11.f];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.textColor = [UIColor listUI_blackColorAlpha:1];
        [contentView addSubview:descriptionLabel];
        
        UILabel *userNameLabel = self.userNameLabel = [[UILabel alloc] init];
        userNameLabel.font = [UIFont listUI_fontWithSize:9.f];
        userNameLabel.numberOfLines = 0;
        userNameLabel.textColor = [UIColor listUI_blueColorAlpha:1];
        [contentView addSubview:userNameLabel];
        
        UILabel *detailsLabel = self.detailsLabel = [[UILabel alloc] init];
        detailsLabel.font = [UIFont listUI_fontWithSize:9.f];
        detailsLabel.textColor = [UIColor listUI_colorWithHex:0x999999 alpha:1.0f];
        [contentView addSubview:detailsLabel];
        
        UIImageView *avatarView = self.avatarView = [[UIImageView alloc] init];
        avatarView.clipsToBounds = YES;
        avatarView.layer.cornerRadius = kPicturesCollectionViewCellAvatarViewSize / 2;
        avatarView.layer.masksToBounds = YES;
        avatarView.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:avatarView];
        
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
    
    x = kPicturesCollectionViewCellMargin;
    y = y + h + (kPicturesCollectionViewCellMargin * 2);
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
    size = [self.detailsLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.detailsLabel.frame = CGRectMake(x, y, w, h);
}

@end
