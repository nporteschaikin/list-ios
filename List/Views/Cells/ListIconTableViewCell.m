//
//  ListIconTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListIconTableViewCell.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@interface ListIconTableViewCell ()

@property (strong, nonatomic) LIconView *iconView;
@property (strong, nonatomic) UILabel *label;

@end

@implementation ListIconTableViewCell

- (instancetype)init {
    if (self = [super init]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    x = ListIconTableViewCellPaddingX;
    y = CGRectGetMidY(self.contentView.bounds) - (ListIconTableViewIconViewSize / 2);
    w = ListIconTableViewIconViewSize;
    h = ListIconTableViewIconViewSize;
    self.iconView.frame = CGRectMake(x, y, w, h);
    
    x = ListIconTableViewIconViewSize + (ListIconTableViewCellPaddingX * 1.5);
    w = CGRectGetWidth(self.contentView.bounds) - (x + ListIconTableViewCellPaddingX);
    size = [self.label sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    y = CGRectGetMidY(self.contentView.bounds) - (size.height / 2);
    h = size.height;
    self.label.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Dynamic getters

- (LIconView *)iconView {
    if (!_iconView) {
        _iconView = [[LIconView alloc] init];
        _iconView.iconSize = ListIconTableViewIconViewSize;
        _iconView.iconColor = [UIColor list_darkGrayColorAlpha:1];
    }
    return _iconView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = [UIColor list_darkGrayColorAlpha:1];
        _label.font = [UIFont list_listIconTableViewCellFont];
    }
    return _label;
}

@end
