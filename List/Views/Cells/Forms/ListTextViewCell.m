//
//  ListTextViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTextViewCell.h"

@interface ListTextViewCell ()

@property (strong, nonatomic) LTextView *textView;

@end

@implementation ListTextViewCell

static CGFloat const ListTextViewCellPadding = 12.f;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.textView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textView];
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
    self.textView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (LTextView *)textView {
    if (!_textView) {
        _textView = [[LTextView alloc] init];
        _textView.textContainerInset = UIEdgeInsetsMake(ListTextViewCellPadding, ListTextViewCellPadding, ListTextViewCellPadding, ListTextViewCellPadding);
    }
    return _textView;
}

@end
