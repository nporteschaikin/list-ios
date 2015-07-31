//
//  MessagesTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MessagesTableViewCell.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface MessagesTableViewCell ()

@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UILabel *dateLabel;

@end

@implementation MessagesTableViewCell

static CGFloat const MessagesTableViewCellPadding = 12.f;
static CGFloat const MessagesTableViewCellAvatarImageViewSize = 30.f;

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
     * Add background color.
     */
    
    self.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    
    /*
     * Add subviews.
     */
    
    [self.contentView addSubview:self.avatarImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.dateLabel];
    
}

- (void)updateContentLabel {
    NSString *str = [NSString stringWithFormat:@"%@ %@", self.userNameString, self.contentString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    
    UIFont *userNameFont = [UIFont list_messagesTableViewCellUserNameFont];
    UIFont *contentFont = [UIFont list_messagesTableViewCellContentFont];
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
    x = MessagesTableViewCellPadding;
    y = MessagesTableViewCellPadding;
    w = MessagesTableViewCellAvatarImageViewSize;
    h = MessagesTableViewCellAvatarImageViewSize;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    x = CGRectGetMaxX(self.avatarImageView.frame) + (MessagesTableViewCellPadding * .75);
    w = CGRectGetWidth(self.contentView.bounds) - x - MessagesTableViewCellPadding;
    self.contentLabel.preferredMaxLayoutWidth = w;
    h = [self.contentLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)].height;;
    self.contentLabel.frame = CGRectMake(x, y, w, h);
    
    y = CGRectGetMaxY(self.contentLabel.frame) + 2.0f;
    [self.dateLabel sizeToFit];
    w = CGRectGetWidth(self.dateLabel.frame);
    h = self.dateLabel.font.lineHeight;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = 0.0f;
    height += MessagesTableViewCellPadding;
    height += fmaxf((CGRectGetHeight(self.dateLabel.frame) + CGRectGetHeight(self.contentLabel.frame)), CGRectGetHeight(self.avatarImageView.frame));
    height += MessagesTableViewCellPadding;
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = MessagesTableViewCellAvatarImageViewSize / 2;
        _avatarImageView.layer.masksToBounds = YES;
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.userInteractionEnabled = NO;
    }
    return _avatarImageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.userInteractionEnabled = YES;
    }
    return _contentLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.numberOfLines = 1;
        _dateLabel.font = [UIFont list_messagesTableViewCellDateFont];
        _dateLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _dateLabel;
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
