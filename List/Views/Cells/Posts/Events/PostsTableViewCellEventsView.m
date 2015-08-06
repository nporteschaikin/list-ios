//
//  PostsTableViewCellEventsView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsTableViewCellEventsView.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@interface PostsTableViewCellEventsView ()

@property (strong, nonatomic) UILabel *startTimeLabel;
@property (strong, nonatomic) UILabel *placeLabel;

@end

@implementation PostsTableViewCellEventsView

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.startTimeLabel];
        [self addSubview:self.placeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    x = PostsTableViewCellDetailsViewPadding;
    y = PostsTableViewCellDetailsViewPadding;
    w = CGRectGetWidth(self.bounds) - PostsTableViewCellDetailsViewPadding;
    self.startTimeLabel.preferredMaxLayoutWidth = w;
    size = [self.startTimeLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.startTimeLabel.frame = CGRectMake(x, y, w, h);
    
    y = y + h;
    self.placeLabel.preferredMaxLayoutWidth = w;
    size = [self.placeLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.placeLabel.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat w = size.width - (PostsTableViewCellDetailsViewPadding * 2);
    CGFloat height = PostsTableViewCellDetailsViewPadding;
    CGSize s;
    s = [self.startTimeLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    height += s.height;
    s = [self.placeLabel sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    height += s.height;
    height += PostsTableViewCellDetailsViewPadding;
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (UILabel *)startTimeLabel {
    if (!_startTimeLabel) {
        _startTimeLabel = [[UILabel alloc] init];
        _startTimeLabel.numberOfLines = 0;
        _startTimeLabel.font = [UIFont list_postsTableViewCellEventsViewTimeFont];
        _startTimeLabel.textColor = [UIColor whiteColor];
    }
    return _startTimeLabel;
}

- (UILabel *)placeLabel {
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] init];
        _placeLabel.numberOfLines = 0;
        _placeLabel.font = [UIFont list_postsTableViewCellEventsViewPlaceFont];
        _placeLabel.textColor = [UIColor whiteColor];
    }
    return _placeLabel;
}

@end
