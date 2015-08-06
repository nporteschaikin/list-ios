//
//  PostViewHeaderCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostViewHeaderCell.h"

@interface PostViewHeaderCell ()

@property (strong, nonatomic) PostHeaderView *headerView;

@end

@implementation PostViewHeaderCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.headerView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.headerView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    w = CGRectGetWidth(self.contentView.bounds) - (PostViewHeaderCellPadding * 2);
    size = [self.headerView sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    x = PostViewHeaderCellPadding;
    y = PostViewHeaderCellPadding;
    self.headerView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (PostHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[PostHeaderView alloc] init];
    }
    return _headerView;
}

@end
