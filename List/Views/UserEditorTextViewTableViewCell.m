//
//  UserEditorTextViewTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserEditorTextViewTableViewCell.h"

@interface UserEditorTextViewTableViewCell ()

@property (strong, nonatomic) LTextView *textView;

@end

@implementation UserEditorTextViewTableViewCell

static CGFloat const UserEditorTextViewTableViewCellPadding = 12.f;

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
    [self.contentView addSubview:self.textView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.contentView.bounds);
    y = CGRectGetMinY(self.contentView.bounds);
    w = CGRectGetWidth(self.contentView.bounds);
    h = CGRectGetHeight(self.contentView.bounds);
    self.textView.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (LTextView *)textView {
    if (!_textView) {
        _textView = [[LTextView alloc] init];
        _textView.textContainerInset = UIEdgeInsetsMake(UserEditorTextViewTableViewCellPadding,
                                                        UserEditorTextViewTableViewCellPadding,
                                                        UserEditorTextViewTableViewCellPadding,
                                                        UserEditorTextViewTableViewCellPadding);
    }
    return _textView;
}

@end
