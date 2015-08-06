//
//  PostsTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/6/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsTableViewCell.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@interface PostsTableViewCell ()

@property (strong, nonatomic) PostHeaderView *headerView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) ListLabelView *threadsCounterView;

@end

@implementation PostsTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.headerView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.threadsCounterView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headerView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.threadsCounterView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    w = CGRectGetWidth(self.contentView.bounds) - (PostsTableViewCellPadding * 2);
    size = [self.headerView sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    x = PostsTableViewCellPadding;
    y = PostsTableViewCellPadding;
    self.headerView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (PostHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[PostHeaderView alloc] init];
    }
    return _headerView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont list_postContentFont];
        _contentLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _contentLabel;
}

- (ListLabelView *)threadsCounterView {
    if (!_threadsCounterView) {
        _threadsCounterView = [[ListLabelView alloc] init];
        _threadsCounterView.icon = LIconThread;
        _threadsCounterView.color = [UIColor list_blueColorAlpha:1];
    }
    return _threadsCounterView;
}

#pragma mark - Dynamic setters

- (void)setDetailsView:(PostsTableViewCellDetailsView *)detailsView {
    if (_detailsView) [_detailsView removeFromSuperview];
    [self.contentView addSubview:detailsView];
    _detailsView = detailsView;
}

@end
