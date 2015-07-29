//
//  PostsTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsTableViewCell.h"
#import "UIFont+List.h"
#import "UIColor+List.h"
#import "UIButton+List.h"

@interface PostsTableViewCell ()

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UIImageView *coverPhotoImageView;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) PostLocationView *postLocationView;
@property (strong, nonatomic) ThreadsCounterView *threadsCounterView;

@end

@implementation PostsTableViewCell

static CGFloat const PostsTableViewCellPadding = 12.f;
static CGFloat const PostsTableViewCellAvatarSize = 40.f;

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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = PostsTableViewCellPadding;
    y = PostsTableViewCellPadding;
    self.avatarImageView.frame = CGRectMake(x, y, PostsTableViewCellAvatarSize, PostsTableViewCellAvatarSize);
    
    [self.dateLabel sizeToFit];
    w = CGRectGetWidth(self.dateLabel.frame);
    h = CGRectGetHeight(self.dateLabel.frame);
    x = CGRectGetMinX(self.bounds) + (CGRectGetWidth(self.bounds) - PostsTableViewCellPadding - w);
    y = CGRectGetMinY(self.avatarImageView.frame);
    self.dateLabel.frame = CGRectMake(x, y, w, h);
    
    x = (PostsTableViewCellPadding * 1.75) + CGRectGetWidth(self.avatarImageView.frame);
    y = CGRectGetMinY(self.avatarImageView.frame);
    w = CGRectGetWidth(self.bounds) - (x + PostsTableViewCellPadding) - (CGRectGetWidth(self.dateLabel.frame) + PostsTableViewCellPadding);
    self.titleLabel.preferredMaxLayoutWidth = w;
    self.titleLabel.frame = CGRectMake(x, y, w, 0);
    [self.titleLabel sizeToFit];
    
    y = CGRectGetMaxY(self.titleLabel.frame);
    self.userNameLabel.preferredMaxLayoutWidth = w;
    self.userNameLabel.frame = CGRectMake(x, y, w, 0);
    [self.userNameLabel sizeToFit];
    
    y = fmaxf(CGRectGetMaxY(self.userNameLabel.frame), CGRectGetMaxY(self.avatarImageView.frame)) + PostsTableViewCellPadding;
    if (!self.coverPhotoImageView.isHidden) {
        x = 0.0f;
        w = CGRectGetWidth(self.contentView.bounds);
        h = w;
        self.coverPhotoImageView.frame = CGRectMake(x, y, w, h);
        y = CGRectGetMaxY(self.coverPhotoImageView.frame) + PostsTableViewCellPadding;
    }

    x = PostsTableViewCellPadding;
    w = CGRectGetWidth(self.bounds) - (PostsTableViewCellPadding * 2);
    self.contentLabel.preferredMaxLayoutWidth = w;
    self.contentLabel.frame = CGRectMake(x, y, w, 0);
    [self.contentLabel sizeToFit];
    
    x = PostsTableViewCellPadding;
    y = CGRectGetMaxY(self.contentLabel.frame) + PostsTableViewCellPadding;
    w = CGRectGetWidth(self.bounds) - (PostsTableViewCellPadding * 2);
    h = [self.postLocationView sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), 0.0f)].height;
    self.postLocationView.frame = CGRectMake(x, y, w, h);
    
    x = PostsTableViewCellPadding;
    y = CGRectGetMaxY(self.postLocationView.frame) + 8.f;
    h = [self.threadsCounterView sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), 0.0f)].height;
    self.threadsCounterView.frame = CGRectMake(x, y, w, h);
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = 0.0f;
    height += CGRectGetMaxY(self.threadsCounterView.frame);
    height += PostsTableViewCellPadding * 2;
    return CGSizeMake(size.width, height);
}

- (void)setupView {
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.coverPhotoImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.postLocationView];
    [self.contentView addSubview:self.threadsCounterView];
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor lightGrayColor];
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.layer.cornerRadius = PostsTableViewCellAvatarSize / 2;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.font = [UIFont list_postsTableViewCellTitleFont];
        _titleLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _titleLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.numberOfLines = 1;
        _userNameLabel.font = [UIFont list_postsTableViewCellUserNameFont];
        _userNameLabel.textColor = [UIColor list_blueColorAlpha:1];
    }
    return _userNameLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.numberOfLines = 1;
        _dateLabel.font = [UIFont list_postsTableViewCellDateFont];
        _dateLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _dateLabel;
}

- (UIImageView *)coverPhotoImageView {
    if (!_coverPhotoImageView) {
        _coverPhotoImageView = [[UIImageView alloc] init];
        _coverPhotoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _coverPhotoImageView.clipsToBounds = YES;
        _coverPhotoImageView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    }
    return _coverPhotoImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.font = [UIFont list_postsTableViewCellTextFont];
        _contentLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _contentLabel;
}

- (PostLocationView *)postLocationView {
    if (!_postLocationView) {
        _postLocationView = [[PostLocationView alloc] init];
    }
    return _postLocationView;
}

- (ThreadsCounterView *)threadsCounterView {
    if (!_threadsCounterView) {
        _threadsCounterView = [[ThreadsCounterView alloc] init];
    }
    return _threadsCounterView;
}

@end
