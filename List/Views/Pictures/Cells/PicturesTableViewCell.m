//
//  PicturesTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/17/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesTableViewCell.h"
#import "ListConstants.h"

@interface PicturesTableViewCell ()

@property (strong, nonatomic) UIImageView *assetView;
@property (strong, nonatomic) UIImageView *avatarView;
@property (strong, nonatomic) UILabel *userNameLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;

@end

@implementation PicturesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *contentView = self.contentView;
        
        /*
         * Create subviews and layers.
         */
        
        UIImageView *assetView = self.assetView = [[UIImageView alloc] init];
        assetView.clipsToBounds = YES;
        assetView.layer.masksToBounds = YES;
        assetView.backgroundColor = [UIColor colorWithHex:0xf1f1f1 alpha:1.0f];
        assetView.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:assetView];
        
        UIImageView *avatarView = self.avatarView = [[UIImageView alloc] init];
        avatarView.clipsToBounds = YES;
        avatarView.layer.masksToBounds = YES;
        avatarView.layer.cornerRadius = kPicturesTableViewCellAvatarViewSize / 2;
        avatarView.backgroundColor = [UIColor whiteColor];
        avatarView.contentMode = UIViewContentModeScaleAspectFill;
        [contentView addSubview:avatarView];
        
        UILabel *userNameLabel = self.userNameLabel = [[UILabel alloc] init];
        userNameLabel.numberOfLines = 1;
        userNameLabel.font = [UIFont listSemiboldFontWithSize:12.f];
        userNameLabel.textColor = [UIColor listBlueColorAlpha:1.0f];
        [contentView addSubview:userNameLabel];
        
        UILabel *dateLabel = self.dateLabel = [[UILabel alloc] init];
        dateLabel.numberOfLines = 0;
        dateLabel.font = [UIFont listFontWithSize:12.f];
        dateLabel.textColor = [UIColor colorWithHex:0x999999 alpha:1.0f];
        [contentView addSubview:dateLabel];
        
        UILabel *descriptionLabel = self.descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.font = [UIFont listFontWithSize:12.f];
        descriptionLabel.textColor = [UIColor colorWithHex:0x444444 alpha:1.0f];
        [contentView addSubview:descriptionLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // do nothing
}

- (void)layoutSubviews {
    
    CGFloat x, y, w, h;
    CGSize size;
    
    x = kPicturesTableViewCellSpacing;
    y = kPicturesTableViewCellSpacing;
    w = kPicturesTableViewCellAvatarViewSize;
    h = w;
    self.avatarView.frame = CGRectMake(x, y, w, h);
    
    size = [self.userNameLabel sizeThatFits:CGSizeZero];
    x = x + w + (kPicturesTableViewCellSpacing / 2);
    y = CGRectGetMidY(self.avatarView.frame) - (size.height / 2);
    w = size.width;
    h = size.height;
    self.userNameLabel.frame = CGRectMake(x, y, w, h);
    
    size = [self.dateLabel sizeThatFits:CGSizeZero];
    x = CGRectGetMaxX(self.contentView.frame) - (size.width + kPicturesTableViewCellSpacing);
    y = CGRectGetMidY(self.avatarView.frame) - (size.height / 2);
    w = size.width;
    h = size.height;
    self.dateLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0.0f;
    y = CGRectGetMaxY(self.avatarView.frame) + kPicturesTableViewCellSpacing;
    w = CGRectGetWidth(self.contentView.bounds);
    h = w;
    self.assetView.frame = CGRectMake(x, y, w, h);
    
    x = kPicturesTableViewCellSpacing;
    y = y + h + kPicturesTableViewCellSpacing;
    w = CGRectGetWidth(self.contentView.bounds) - (x + kPicturesTableViewCellSpacing);
    size = [self.descriptionLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.descriptionLabel.frame = CGRectMake(x, y, w, h);
    
    /*
     * Leave space at bottom of content view.
     */
    
    h = y + h + kPicturesTableViewCellSpacing;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.bounds);
    self.contentView.frame = CGRectMake(x, y, w, h);
    
    
}

@end
