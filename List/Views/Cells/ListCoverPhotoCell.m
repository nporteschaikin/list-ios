//
//  ListCoverPhotoCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListCoverPhotoCell.h"
#import "UIColor+List.h"

@interface ListCoverPhotoCell ()

@property (strong, nonatomic) UIImageView *photoView;

@end

@implementation ListCoverPhotoCell

- (instancetype)init {
    if (self = [super init]) {
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
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.contentView.bounds);
    h = CGRectGetHeight(self.contentView.bounds);
    self.photoView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (UIImageView *)photoView {
    if (!_photoView) {
        _photoView = [[UIImageView alloc] init];
        _photoView.clipsToBounds = YES;
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.backgroundColor = [UIColor list_blackColorAlpha:1];
    }
    return _photoView;
}

@end
