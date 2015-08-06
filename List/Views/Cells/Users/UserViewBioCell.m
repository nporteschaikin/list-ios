//
//  UserViewBioCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserViewBioCell.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@interface UserViewBioCell ()

@property (strong, nonatomic) UILabel *contentLabel;

@end

@implementation UserViewBioCell

- (instancetype)init {
    if (self = [super init]) {
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    x = UserViewBioCellPadding;
    y = UserViewBioCellPadding;
    w = CGRectGetWidth(self.contentView.bounds) - (UserViewBioCellPadding * 2);
    self.contentLabel.preferredMaxLayoutWidth = w;
    size = [self.contentLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.contentLabel.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont list_userViewBioCellFont];
        _contentLabel.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _contentLabel;
}

@end
