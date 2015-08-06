//
//  PostHeaderView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostHeaderView.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@interface PostHeaderView ()

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *locationLabel;

@end

@implementation PostHeaderView

- (id)init {
    if (self = [super init]) {
        [self addSubview:self.avatarImageView];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.locationLabel];
        [self addSubview:self.dateLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    x = 0.0f;
    y = 0.0f;
    w = PostHeaderViewAvatarImageViewSize;
    h = PostHeaderViewAvatarImageViewSize;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    
    size = [self.userNameLabel sizeThatFits:CGSizeZero];
    x = x + w + PostHeaderViewUserNameLabelInset;
    y = CGRectGetMidY(self.avatarImageView.frame) - size.height;
    w = size.width;
    h = size.height;
    self.userNameLabel.frame = CGRectMake(x, y, w, h);
    
    size = [self.dateLabel sizeThatFits:CGSizeZero];
    x = CGRectGetWidth(self.bounds) - size.width;
    w = size.width;
    h = size.height;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
    
    size = [self.locationLabel sizeThatFits:CGSizeZero];
    x = PostHeaderViewAvatarImageViewSize + PostHeaderViewUserNameLabelInset;
    y = CGRectGetMidY(self.avatarImageView.frame);
    w = size.width;
    h = size.height;
    self.locationLabel.frame = CGRectMake(x, y, w, h);
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = PostHeaderViewAvatarImageViewSize;
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor lightGrayColor];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = PostHeaderViewAvatarImageViewSize / 2;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.userInteractionEnabled = YES;
    }
    return _avatarImageView;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.numberOfLines = 1;
        _userNameLabel.font = [UIFont list_postHeaderViewUserNameFont];
        _userNameLabel.textColor = [UIColor list_blueColorAlpha:1];
        _userNameLabel.userInteractionEnabled = YES;
    }
    return _userNameLabel;
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textColor = [UIColor list_darkGrayColorAlpha:1];
        _locationLabel.font = [UIFont list_postHeaderViewLocationFont];
    }
    return _locationLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.numberOfLines = 1;
        _dateLabel.font = [UIFont list_postHeaderViewDateFont];
        _dateLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _dateLabel;
}

@end
