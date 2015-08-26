//
//  PicturesHeaderView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/26/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesHeaderView.h"

@interface PicturesHeaderView ()

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *placemarkTitleLabel;

@end

@implementation PicturesHeaderView

static CGFloat const kPicturesHeaderViewAvatarImageViewSize = 35.0f;
static CGFloat const kPicturesHeaderViewAvatarSpacing = 6.0f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Add avatar image view.
         */
        
        self.avatarImageView = [[UIImageView alloc] init];
        self.avatarImageView.backgroundColor = [UIColor listBlackColorAlpha:0.5];
        self.avatarImageView.clipsToBounds = YES;
        self.avatarImageView.layer.cornerRadius = kPicturesHeaderViewAvatarImageViewSize / 2;
        self.avatarImageView.layer.shadowColor = [UIColor listBlackColorAlpha:1].CGColor;
        self.avatarImageView.layer.shadowRadius = 2.0f;
        self.avatarImageView.layer.shadowOpacity = 0.5f;
        self.avatarImageView.layer.shadowOffset = CGSizeZero;
        [self addSubview:self.avatarImageView];
        
        /*
         * Add user name label.
         */
        
        self.userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.layer.shadowColor = [UIColor listBlackColorAlpha:1].CGColor;
        self.userNameLabel.layer.shadowRadius = 1.0f;
        self.userNameLabel.layer.shadowOpacity = 0.5f;
        self.userNameLabel.layer.shadowOffset = CGSizeZero;
        self.userNameLabel.font = [UIFont listSemiboldFontWithSize:12.f];
        [self addSubview:self.userNameLabel];
        
        /*
         * Add placemark label.
         */
        
        self.placemarkTitleLabel = [[UILabel alloc] init];
        self.placemarkTitleLabel.layer.shadowColor = [UIColor listBlackColorAlpha:1].CGColor;
        self.placemarkTitleLabel.layer.shadowRadius = 1.0f;
        self.placemarkTitleLabel.layer.shadowOpacity = 0.5f;
        self.placemarkTitleLabel.layer.shadowOffset = CGSizeZero;
        self.placemarkTitleLabel.font = [UIFont listFontWithSize:12.f];
        [self addSubview:self.placemarkTitleLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    /*
     * Frame avatar view.
     */

    x = 0.0f;
    y = 0.0f;
    w = kPicturesHeaderViewAvatarImageViewSize;
    h = kPicturesHeaderViewAvatarImageViewSize;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    
    /*
     * Frame user name label.
     */
    
    size = [self.userNameLabel sizeThatFits:CGSizeZero];
    x = kPicturesHeaderViewAvatarImageViewSize + kPicturesHeaderViewAvatarSpacing;
    w = size.width;
    h = size.height;
    self.userNameLabel.frame = CGRectMake(x, y, w, h);
    
    /*
     * Frame placemark label.
     */
    
    size = [self.placemarkTitleLabel sizeThatFits:CGSizeZero];
    y = h;
    w = size.width;
    h = size.height;
    self.placemarkTitleLabel.frame = CGRectMake(x, y, w, h);
    
}

- (void)tintColorDidChange {
    self.userNameLabel.textColor = self.tintColor;
    self.placemarkTitleLabel.textColor = self.tintColor;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, kPicturesHeaderViewAvatarImageViewSize);
}

@end
