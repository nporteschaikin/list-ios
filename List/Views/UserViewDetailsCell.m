//
//  UserViewDetailsCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserViewDetailsCell.h"
#import "UIColor+List.h"
#import "UIFont+List.h"
#import "UIButton+List.h"

@interface UserViewDetailsCell ()

@property (strong, nonatomic) UIImageView *coverPhotoView;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *bioLabel;
@property (strong, nonatomic) UIButton *button;

@end

@implementation UserViewDetailsCell

static CGFloat const UserViewDetailsCellMargin = 12.f;
static CGFloat const UserViewDetailsCellAvatarImageViewSize = 100.f;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self.contentView addSubview:self.coverPhotoView];
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.bioLabel];
    [self.contentView addSubview:self.button];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.contentView.bounds);
    y = CGRectGetMinY(self.contentView.bounds);
    w = CGRectGetWidth(self.contentView.bounds);
    h = w * 0.5625;
    self.coverPhotoView.frame = CGRectMake(x, y, w, h);
    
    x = UserViewDetailsCellMargin;
    y = CGRectGetMaxY(self.coverPhotoView.frame) - (UserViewDetailsCellAvatarImageViewSize - UserViewDetailsCellMargin);
    w = UserViewDetailsCellAvatarImageViewSize;
    h = UserViewDetailsCellAvatarImageViewSize;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    
    [self.button sizeToFit];
    
    x = UserViewDetailsCellMargin;
    y = CGRectGetMaxY(self.avatarImageView.frame) + (UserViewDetailsCellMargin / 2);
    w = CGRectGetWidth(self.contentView.bounds) - (UserViewDetailsCellMargin * 2) - CGRectGetWidth(self.button.frame);
    self.nameLabel.preferredMaxLayoutWidth = w;
    h = [self.nameLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MIN)].height;
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    
    y = y + h;
    self.bioLabel.preferredMaxLayoutWidth = w;
    h = [self.bioLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MIN)].height;
    self.bioLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetWidth(self.contentView.bounds) - CGRectGetWidth(self.button.frame) - UserViewDetailsCellMargin;
    y = CGRectGetMidY(self.nameLabel.frame) - (CGRectGetHeight(self.button.frame) / 2);
    w = CGRectGetWidth(self.button.frame);
    h = CGRectGetHeight(self.button.frame);
    self.button.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = 0.0f;
    height += CGRectGetMaxY(self.bioLabel.frame) + (UserViewDetailsCellMargin * 2);
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (UIImageView *)coverPhotoView {
    if (!_coverPhotoView) {
        _coverPhotoView = [[UIImageView alloc] init];
        _coverPhotoView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _coverPhotoView.contentMode = UIViewContentModeScaleAspectFill;
        _coverPhotoView.clipsToBounds = YES;
    }
    return _coverPhotoView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _avatarImageView.layer.borderWidth = 3.0f;
        _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _avatarImageView.layer.cornerRadius = UserViewDetailsCellAvatarImageViewSize / 2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font = [UIFont list_userViewDetailsCellNameFont];
        _nameLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _nameLabel;
}

- (UILabel *)bioLabel {
    if (!_bioLabel) {
        _bioLabel = [[UILabel alloc] init];
        _bioLabel.numberOfLines = 0;
        _bioLabel.font = [UIFont list_userViewDetailsCellBioFont];
        _bioLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _bioLabel;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton list_buttonWithSize:UIButtonListSizeSmall
                                            style:UIButtonListStyleBlue];
    }
    return _button;
}

@end
