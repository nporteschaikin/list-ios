//
//  ThreadsTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ThreadsTableViewCell.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface ThreadsTableViewCell ()

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) RepliesCounterView *repliesCounterView;

@end

@implementation ThreadsTableViewCell

static CGFloat const ThreadsTableViewCellPadding = 12.f;
static CGFloat const ThreadsTableViewCellAvatarImageViewSize = 30.f;

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
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.repliesCounterView];
}

- (void)updateContentLabel {
    NSString *str = [NSString stringWithFormat:@"%@ %@", self.userNameString, self.contentString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    UIFont *userNameFont = [UIFont list_threadsTableViewCellUserNameFont];
    UIFont *contentFont = [UIFont list_threadsTableViewCellContentFont];
    UIColor *blueColor = [UIColor list_blueColorAlpha:1.f];
    UIColor *blackColor = [UIColor list_blackColorAlpha:1];
    
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:blueColor
                             range:NSMakeRange(0, self.userNameString.length)];
    [attributedString addAttribute:NSFontAttributeName
                             value:userNameFont
                             range:NSMakeRange(0, self.userNameString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:blackColor
                             range:NSMakeRange(self.userNameString.length, self.contentString.length + 1)];
    [attributedString addAttribute:NSFontAttributeName
                             value:contentFont
                             range:NSMakeRange(self.userNameString.length, self.contentString.length + 1)];
    
    self.contentLabel.attributedText = attributedString;
    [self.contentLabel sizeToFit];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = ThreadsTableViewCellPadding;
    y = ThreadsTableViewCellPadding;
    w = ThreadsTableViewCellAvatarImageViewSize;
    h = ThreadsTableViewCellAvatarImageViewSize;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    x = CGRectGetMaxX(self.avatarImageView.frame) + (ThreadsTableViewCellPadding * .75);
    w = CGRectGetWidth(self.contentView.bounds) - x - ThreadsTableViewCellPadding;
    self.contentLabel.preferredMaxLayoutWidth = w;
    self.contentLabel.frame = CGRectMake(x, y, w, 0.0f);
    [self.contentLabel sizeToFit];
    
    y = CGRectGetMaxY(self.contentLabel.frame) + 2.0f;
    [self.dateLabel sizeToFit];
    w = CGRectGetWidth(self.dateLabel.frame);
    h = self.dateLabel.font.lineHeight;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
    
    x = x + w + ThreadsTableViewCellPadding;
    [self.repliesCounterView sizeToFit];
    y = CGRectGetMidY(self.dateLabel.frame) - (CGRectGetHeight(self.repliesCounterView.frame) / 2);
    w = CGRectGetWidth(self.contentView.bounds) - (x + ThreadsTableViewCellPadding);
    h = [self.repliesCounterView sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), 0.0f)].height;
    self.repliesCounterView.frame = CGRectMake(x, y, w, h);
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = 0.0f;
    height += ThreadsTableViewCellPadding;
    height += fmaxf(CGRectGetMaxY(self.dateLabel.frame), CGRectGetMaxY(self.avatarImageView.frame)) - ThreadsTableViewCellPadding;
    height += ThreadsTableViewCellPadding;
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = ThreadsTableViewCellAvatarImageViewSize / 2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.numberOfLines = 1;
        _dateLabel.font = [UIFont list_threadsTableViewCellDateFont];
        _dateLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _dateLabel;
}

- (RepliesCounterView *)repliesCounterView {
   if (!_repliesCounterView) {
       _repliesCounterView = [[RepliesCounterView alloc] init];
   }
   return _repliesCounterView;
}

#pragma mark - Dynamic setters

- (void)setUserNameString:(NSString *)userNameString {
    _userNameString = userNameString;
    [self updateContentLabel];
}

- (void)setContentString:(NSString *)contentString {
    _contentString = contentString;
    [self updateContentLabel];
}

@end