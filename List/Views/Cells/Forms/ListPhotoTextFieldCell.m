//
//  ListPhotoTextFieldCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListPhotoTextFieldCell.h"
#import "UIColor+List.h"

@interface ListPhotoTextFieldCell ()

@property (strong, nonatomic) UIImageView *photoView;

@end

@implementation ListPhotoTextFieldCell

static CGFloat const ListPhotoTextFieldCellPadding = 12.f;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.photoView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.photoView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = ListPhotoTextFieldCellPadding;
    y = ListPhotoTextFieldCellPadding;
    h = CGRectGetHeight(self.contentView.bounds) - (ListPhotoTextFieldCellPadding * 2);
    w = h;
    self.photoView.frame = CGRectMake(x, y, w, h);
    self.textField.textInsets = UIEdgeInsetsMake(ListPhotoTextFieldCellPadding, y + w + (ListPhotoTextFieldCellPadding / 2), ListPhotoTextFieldCellPadding, ListPhotoTextFieldCellPadding);
    
}

#pragma mark - Dynamic getters

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _photoView.layer.cornerRadius = 3.0f;
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
    }
    return _photoView;
}

@end
