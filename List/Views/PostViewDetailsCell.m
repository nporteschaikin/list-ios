//
//  PostViewDetailsCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostViewDetailsCell.h"
#import "UIColor+List.h"
#import "UIFont+List.h"
#import "UIImage+List.h"

@interface PostViewDetailsCell ()

@property (strong, nonatomic) UIImageView *coverPhotoView;
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) PostLocationView *postLocationView;
@property (strong, nonatomic) UIImageView *listImageView;

@end

@implementation PostViewDetailsCell

static CGFloat const PostViewDetailsCellPadding = 12.f;
static CGFloat const PostViewDetailsCellAvatarImageViewSize = 50.f;

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.postLocationView];
    [self.contentView addSubview:self.listImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    
    x = CGRectGetMinX(self.contentView.bounds);
    y = CGRectGetMinY(self.contentView.bounds);
    w = CGRectGetWidth(self.contentView.bounds);
    h = self.hasCoverPhoto ? w : w * 0.5625;
    self.coverPhotoView.frame = CGRectMake(x, y, w, h);
    
    x = PostViewDetailsCellPadding;
    y = CGRectGetMaxY(self.coverPhotoView.frame) + PostViewDetailsCellPadding;
    w = PostViewDetailsCellAvatarImageViewSize;
    h = PostViewDetailsCellAvatarImageViewSize;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    
    [self.dateLabel sizeToFit];
    w = CGRectGetWidth(self.dateLabel.frame);
    h = CGRectGetHeight(self.dateLabel.frame);
    x = CGRectGetWidth(self.contentView.bounds) - w - PostViewDetailsCellPadding;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
    
    x = PostViewDetailsCellAvatarImageViewSize + (PostViewDetailsCellPadding * 2);
    w = CGRectGetWidth(self.contentView.frame) - x - w - PostViewDetailsCellPadding;
    self.titleLabel.preferredMaxLayoutWidth = w;
    self.titleLabel.frame = CGRectMake(x, y, w, 0.0f);
    [self.titleLabel sizeToFit];
    
    y = CGRectGetMaxY(self.titleLabel.frame);
    h = self.userNameLabel.font.lineHeight;
    self.userNameLabel.frame = CGRectMake(x, y, w, h);
    
    x = PostViewDetailsCellPadding;
    y = fmaxf(CGRectGetMaxY(self.userNameLabel.frame), CGRectGetMaxY(self.avatarImageView.frame)) + PostViewDetailsCellPadding;
    w = CGRectGetWidth(self.contentView.bounds) - (PostViewDetailsCellPadding * 2);
    self.contentLabel.preferredMaxLayoutWidth = w;
    self.contentLabel.frame = CGRectMake(x, y, w, 0.0f);
    [self.contentLabel sizeToFit];
    
    x = PostViewDetailsCellPadding;
    y = CGRectGetMaxY(self.contentLabel.frame) + PostViewDetailsCellPadding;
    w = CGRectGetWidth(self.contentView.bounds) - CGRectGetWidth(self.listImageView.frame) - (PostViewDetailsCellPadding * 3);
    self.postLocationView.frame = CGRectMake(x, y, w, 0.0f);
    [self.postLocationView sizeToFit];
    
    x = CGRectGetWidth(self.contentView.bounds) - CGRectGetWidth(self.listImageView.frame) - PostViewDetailsCellPadding;
    y = CGRectGetMidY(self.postLocationView.frame) - (CGRectGetHeight(self.listImageView.frame) / 2);
    w = CGRectGetWidth(self.listImageView.frame);
    h = CGRectGetHeight(self.listImageView.frame);
    self.listImageView.frame = CGRectMake(x, y, w, h);
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = 0.0f;
    height += size.width * (self.hasCoverPhoto ? 1 : 0.5625);
    height += PostViewDetailsCellPadding;
    height += fmaxf(CGRectGetHeight(self.titleLabel.frame) + CGRectGetHeight(self.userNameLabel.frame), PostViewDetailsCellAvatarImageViewSize);
    height += PostViewDetailsCellPadding;
    height += CGRectGetHeight(self.contentLabel.frame);
    height += PostViewDetailsCellPadding;
    height += CGRectGetHeight(self.postLocationView.frame);
    height += (PostViewDetailsCellPadding * 2);
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (UIImageView *)coverPhotoView {
    if (!_coverPhotoView) {
        _coverPhotoView = [[UIImageView alloc] init];
        _coverPhotoView.contentMode = UIViewContentModeScaleAspectFill;
        _coverPhotoView.clipsToBounds = YES;
        _coverPhotoView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    }
    return _coverPhotoView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.layer.cornerRadius = PostViewDetailsCellAvatarImageViewSize / 2;
        _avatarImageView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.userInteractionEnabled = YES;
    }
    return _avatarImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont list_postViewDetailsCellTitleFont];
        _titleLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _titleLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.numberOfLines = 1;
        _userNameLabel.font = [UIFont list_postViewDetailsCellUserNameFont];
        _userNameLabel.textColor = [UIColor list_blueColorAlpha:1];
        _userNameLabel.userInteractionEnabled = YES;
    }
    return _userNameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont list_postViewDetailsCellTextFont];
        _contentLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _contentLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.numberOfLines = 1;
        _dateLabel.font = [UIFont list_postViewDetailsCellDateFont];
        _dateLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _dateLabel;
}

- (PostLocationView *)postLocationView {
    if (!_postLocationView) {
        _postLocationView = [[PostLocationView alloc] init];
    }
    return _postLocationView;
}

- (UIImageView *)listImageView {
    if (!_listImageView) {
        _listImageView = [[UIImageView alloc] initWithImage:[UIImage list_listImageColor:[UIColor list_darkGrayColorAlpha:1.0f] size:15.f]];
        _listImageView.userInteractionEnabled = YES;
        [_listImageView sizeToFit];
    }
    return _listImageView;
}

@end
