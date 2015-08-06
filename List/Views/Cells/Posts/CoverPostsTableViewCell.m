//
//  CoverPostsTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CoverPostsTableViewCell.h"
#import "UIFont+List.h"
#import "UIColor+List.h"
#import "Constants.h"

@interface CoverPostsTableViewCell ()

@property (strong, nonatomic) UIImageView *photoView;
@property (strong, nonatomic) UIView *photoOverlayView;

@end

@implementation CoverPostsTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.photoOverlayView];
        [self.contentView bringSubviewToFront:self.titleLabel];
        
        // set title font
        self.titleLabel.font = [UIFont list_coverPostsTableViewCellTitleFont];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.photoOverlayView];
        [self.contentView bringSubviewToFront:self.titleLabel];
        
        // set title font
        self.titleLabel.font = [UIFont list_coverPostsTableViewCellTitleFont];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    x = PostsTableViewCellPadding;
    y = CGRectGetMaxY(self.headerView.frame) + PostsTableViewCellPadding;
    w = CGRectGetWidth(self.contentView.bounds) - (PostsTableViewCellPadding * 2);
    h = w * CoverPhotoHeightMultiplier;
    self.photoView.frame = CGRectMake(x, y, w, h);
    self.photoOverlayView.frame = self.photoView.frame;
    
    y = y + PostsTableViewCellPadding;
    x = PostsTableViewCellPadding * 2;
    w = CGRectGetWidth(self.contentView.bounds) - (PostsTableViewCellPadding * 4);
    size = [self.titleLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
    
    if (self.detailsView) {
        size = [self.detailsView sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
        x = PostsTableViewCellPadding;
        y = CGRectGetMaxY(self.photoView.frame) - size.height;
        h = size.height;
        self.detailsView.frame = CGRectMake(x, y, w, h);
    }
    
    y = CGRectGetMaxY(self.photoView.frame) + PostsTableViewCellPadding;
    x = PostsTableViewCellPadding;
    w = CGRectGetWidth(self.bounds) - (PostsTableViewCellPadding * 2);
    self.contentLabel.preferredMaxLayoutWidth = w;
    h = [self.contentLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)].height;
    self.contentLabel.frame = CGRectMake(x, y, w, h);
    
    y = y + h + PostsTableViewCellPadding;
    size = [self.threadsCounterView sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    w = size.width;
    h = size.height;
    self.threadsCounterView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
        _photoView.backgroundColor = [UIColor list_blackColorAlpha:1];
    }
    return _photoView;
}

- (UIView *)photoOverlayView {
    if (!_photoOverlayView) {
        _photoOverlayView = [[UIView alloc] init];
        _photoOverlayView.backgroundColor = [UIColor blackColor];
        _photoOverlayView.alpha = CoverPhotoOverlayAlpha;
    }
    return _photoOverlayView;
}

@end

