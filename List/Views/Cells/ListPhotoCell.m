//
//  ListPhotoCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListPhotoCell.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface ListPhotoCell ()

@property (strong, nonatomic) UIImageView *photoView;
@property (strong, nonatomic) UILabel *label;

@end

@implementation ListPhotoCell

static CGFloat const ListPhotoCellPadding = 12.f;

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
    [self.contentView addSubview:self.photoView];
    [self.contentView addSubview:self.label];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = ListPhotoCellPadding;
    y = ListPhotoCellPadding;
    h = CGRectGetHeight(self.contentView.bounds) - (ListPhotoCellPadding * 2);
    w = h;
    self.photoView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.photoView.frame) + (ListPhotoCellPadding / 2);
    y = 0.0f;
    w = CGRectGetWidth(self.contentView.bounds) - (x + ListPhotoCellPadding);
    h = CGRectGetHeight(self.contentView.bounds);
    self.label.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.layer.cornerRadius = 5.0f;
        _photoView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _photoView.clipsToBounds = YES;
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _photoView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 1;
        _label.font = [UIFont list_listPhotoCellLabelFont];
        _label.textColor = [UIColor list_blackColorAlpha:1];
    }
    return _label;
}

@end
