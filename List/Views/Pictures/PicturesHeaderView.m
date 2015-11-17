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

static CGFloat const kPicturesHeaderViewAvatarImageViewSize = 50.0f;
static CGFloat const kPicturesHeaderViewAvatarSpacing = 12.0f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Add avatar image view.
         */
        
        self.avatarImageView = [[UIImageView alloc] init];
        self.avatarImageView.backgroundColor = [UIColor listBlackColorAlpha:0.5];
        self.avatarImageView.clipsToBounds = YES;
        self.avatarImageView.layer.cornerRadius = kPicturesHeaderViewAvatarImageViewSize / 2;
        [self addSubview:self.avatarImageView];
        
        /*
         * Add user name label.
         */
        
        self.userNameLabel = [[UILabel alloc] init];
        self.userNameLabel.font = [UIFont listSemiboldFontWithSize:16.f];
        [self addSubview:self.userNameLabel];
        
        /*
         * Add placemark label.
         */
        
        self.placemarkTitleLabel = [[UILabel alloc] init];
        self.placemarkTitleLabel.font = [UIFont listFontWithSize:14.f];
        [self addSubview:self.placemarkTitleLabel];
        
    }
    return self;
}

- (void)tintColorDidChange {
    
    /*
     * Set label colors.
     */

    self.userNameLabel.textColor = self.tintColor;
    self.placemarkTitleLabel.textColor = self.tintColor;
    
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

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, kPicturesHeaderViewAvatarImageViewSize);
}

@end
