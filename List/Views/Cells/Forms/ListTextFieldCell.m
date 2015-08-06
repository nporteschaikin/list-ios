//
//  ListTextFieldCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListTextFieldCell.h"

@interface ListTextFieldCell ()

@property (strong, nonatomic) LTextField *textField;

@end

@implementation ListTextFieldCell

static CGFloat const ListTextFieldCellPadding = 12.f;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textField];
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
    self.textField.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Dynamic getters

- (LTextField *)textField {
    if (!_textField) {
        _textField = [[LTextField alloc] init];
        _textField.textInsets = UIEdgeInsetsMake(ListTextFieldCellPadding, ListTextFieldCellPadding, ListTextFieldCellPadding, ListTextFieldCellPadding);
    }
    return _textField;
}

@end
