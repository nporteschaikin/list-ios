//
//  UserViewCoverPhotoCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserViewCoverPhotoCell.h"
#import "UIFont+List.h"
#import "Constants.h"

@interface UserViewCoverPhotoCell ()

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIView *overlayView;

@end

@implementation UserViewCoverPhotoCell

static CGFloat const UserViewCoverPhotoCellPadding = 12.f;
static CGFloat const UserViewCoverPhotoCellAvatarImageViewSize = 50.f;

- (instancetype)init {
    if (self = [super init]) {
        [self.contentView addSubview:self.overlayView];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.overlayView];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    x = UserViewCoverPhotoCellPadding;
    y = CGRectGetHeight(self.contentView.bounds) - (UserViewCoverPhotoCellAvatarImageViewSize + UserViewCoverPhotoCellPadding);
    w = UserViewCoverPhotoCellAvatarImageViewSize;
    h = UserViewCoverPhotoCellAvatarImageViewSize;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    
    w = CGRectGetWidth(self.contentView.bounds) - (UserViewCoverPhotoCellAvatarImageViewSize + (UserViewCoverPhotoCellPadding * 2));
    self.nameLabel.preferredMaxLayoutWidth = w;
    size = [self.nameLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    x = (UserViewCoverPhotoCellPadding * 2) + UserViewCoverPhotoCellAvatarImageViewSize;
    y = CGRectGetMidY(self.avatarImageView.frame) - (h / 2);
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.photoView.frame);
    y = CGRectGetMinY(self.photoView.frame);
    w = CGRectGetWidth(self.photoView.frame);
    h = CGRectGetHeight(self.photoView.frame);
    self.overlayView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont list_userViewCoverPhotoCellNameFont];
    }
    return _nameLabel;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = UserViewCoverPhotoCellAvatarImageViewSize / 2;
    }
    return _avatarImageView;
}

- (UIView *)overlayView {
    if (!_overlayView) {
        _overlayView = [[UIView alloc] init];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = CoverPhotoOverlayAlpha;
    }
    return _overlayView;
}

@end
