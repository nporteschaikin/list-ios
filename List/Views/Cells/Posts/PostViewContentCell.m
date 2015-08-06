//
//  PostViewContentCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostViewContentCell.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@interface PostViewContentCell ()

@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation PostViewContentCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    w = CGRectGetWidth(self.contentView.bounds) - (PostViewContentCellPadding * 2);
    size = [self.contentLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    x = PostViewContentCellPadding;
    y = PostViewContentCellPadding;
    self.contentLabel.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Dynamic getters

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor list_blackColorAlpha:1];
        _contentLabel.font = [UIFont list_postContentFont];
    }
    return _contentLabel;
}

@end
