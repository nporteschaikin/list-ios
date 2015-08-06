//
//  NotificationsTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NotificationsTableViewCell.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface NotificationsTableViewCell ()

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *dateLabel;

@end

@implementation NotificationsTableViewCell

static CGFloat const NotificationsTableViewCellPadding = 12.f;
static CGFloat const NotificationsTableViewCellAvatarImageViewSize = 50.f;

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
    
    /*
     * Add subviews.
     */
    
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.dateLabel];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.contentView.bounds) + NotificationsTableViewCellPadding;
    y = CGRectGetMinY(self.contentView.bounds) + NotificationsTableViewCellPadding;
    w = NotificationsTableViewCellAvatarImageViewSize;
    h = NotificationsTableViewCellAvatarImageViewSize;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    
    x = x + w + NotificationsTableViewCellPadding;
    y = NotificationsTableViewCellPadding;
    w = CGRectGetWidth(self.contentView.bounds) - x - NotificationsTableViewCellPadding;
    self.contentLabel.preferredMaxLayoutWidth = w;
    h = [self.contentLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)].height;
    self.contentLabel.frame = CGRectMake(x, y, w, h);
    
    y = CGRectGetMaxY(self.contentLabel.frame);
    h = self.dateLabel.font.lineHeight;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = NotificationsTableViewCellAvatarImageViewSize / 2;
        _avatarImageView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont list_notificationsTableViewCellContentFont];
    }
    return _contentLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.numberOfLines = 1;
        _dateLabel.font = [UIFont list_notificationsTableViewCellDateFont];
    }
    return _dateLabel;
}

@end
