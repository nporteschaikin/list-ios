//
//  EventsCollectionViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/19/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventsCollectionViewCell.h"

@interface EventsCollectionViewCell ()

@property (strong, nonatomic) UIView *assetContainer;
@property (strong, nonatomic) UIImageView *assetView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;

@end

@implementation EventsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIView *contentView = self.contentView;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.layer.cornerRadius = 2.0f;
        contentView.layer.masksToBounds = YES;
        contentView.layer.borderWidth = 1.0f;
        contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        UIView *assetContainer = self.assetContainer = [[UIView alloc] init];
        assetContainer.backgroundColor = [UIColor listUI_lightGrayColorAlpha:1];
        [contentView addSubview:assetContainer];
        
        UIImageView *assetView = self.assetView = [[UIImageView alloc] init];
        assetView.contentMode = UIViewContentModeScaleAspectFill;
        assetView.clipsToBounds = YES;
        assetView.layer.masksToBounds = YES;
        [assetContainer addSubview:assetView];
        
        UILabel *titleLabel = self.titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.font = [UIFont listUI_semiboldFontWithSize:13.f];
        titleLabel.textColor = [UIColor listUI_blackColorAlpha:1];
        [assetContainer addSubview:titleLabel];
        
        UILabel *timeLabel = self.timeLabel = [[UILabel alloc] init];
        timeLabel.numberOfLines = 1;
        timeLabel.font = [UIFont listUI_fontWithSize:11.f];
        timeLabel.textColor = [UIColor listUI_blackColorAlpha:1];
        [assetContainer addSubview:timeLabel];
        
        UILabel *descriptionLabel = self.descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.font = [UIFont listUI_fontWithSize:12.f];
        descriptionLabel.textColor = [UIColor listUI_blackColorAlpha:1];
        [contentView addSubview:descriptionLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.contentView.bounds);
    h = w * 0.5625f;
    self.assetContainer.frame = CGRectMake(x, y, w, h);
    
    h = CGRectGetHeight(self.assetContainer.bounds);
    self.assetView.frame = CGRectMake(x, y, w, h);
    
    x = kEventsCollectionViewCellMargin;
    y = CGRectGetHeight(self.assetContainer.bounds) - (self.timeLabel.font.lineHeight + kEventsCollectionViewCellMargin);
    w = CGRectGetWidth(self.assetContainer.bounds) - (kEventsCollectionViewCellMargin * 2);
    h = self.timeLabel.font.lineHeight;
    self.timeLabel.frame = CGRectMake(x, y, w, h);
    
    size = [self.titleLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    y = y - size.height;
    h = size.height;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
    
    x = kEventsCollectionViewCellMargin;
    y = CGRectGetMaxY(self.assetContainer.frame) + kEventsCollectionViewCellMargin;
    w = CGRectGetWidth(self.contentView.bounds) - (kEventsCollectionViewCellMargin * 2);
    size = [self.descriptionLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.descriptionLabel.frame = CGRectMake(x, y, w, h);
    
}

@end
