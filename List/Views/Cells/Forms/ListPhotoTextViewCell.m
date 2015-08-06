//
//  ListPhotoTextViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListPhotoTextViewCell.h"
#import "UIColor+List.h"
#import "UIButton+List.h"

@interface ListPhotoTextViewCell ()

@property (strong, nonatomic) UIImageView *photoView;
@property (strong, nonatomic) UIButton *photoButton;

@end

@implementation ListPhotoTextViewCell

static CGFloat const ListPhotoTextViewCellPadding = 12.f;
static CGFloat const ListPhotoTextViewCellPhotoViewSize = 75.f;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.photoButton];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.photoView];
        [self.contentView addSubview:self.photoButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = ListPhotoTextViewCellPadding;
    y = ListPhotoTextViewCellPadding;
    w = ListPhotoTextViewCellPhotoViewSize;
    h = ListPhotoTextViewCellPhotoViewSize;
    self.photoView.frame = CGRectMake(x, y, w, h);
    self.textView.textContainerInset = UIEdgeInsetsMake(ListPhotoTextViewCellPadding, y + w + (ListPhotoTextViewCellPadding / 2), ListPhotoTextViewCellPadding, ListPhotoTextViewCellPadding);
    
    w = CGRectGetWidth(self.photoButton.frame);
    h = CGRectGetHeight(self.photoButton.frame);
    x = CGRectGetMidX(self.photoView.frame) - (w / 2);
    y = CGRectGetMidY(self.photoView.frame) - (h / 2);
    self.photoButton.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
        _photoView.layer.cornerRadius = 3.0f;
    }
    return _photoView;
}

- (UIButton *)photoButton {
    if (!_photoButton) {
        _photoButton = [UIButton list_cameraIconButtonWithSize:50.f color:[UIColor list_blueColorAlpha:1]];
        [_photoButton sizeToFit];
    }
    return _photoButton;
}

@end
