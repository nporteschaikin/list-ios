//
//  ListGeneralCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListGeneralCell.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@implementation ListGeneralCell

static CGFloat const ListGeneralCellPadding = 12.f;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.textLabel.font = [UIFont list_listGeneralCellTextFont];
    self.detailTextLabel.font = [UIFont list_listGeneralCellTextFont];
    self.detailTextLabel.textAlignment = NSTextAlignmentRight;
    self.textLabel.textColor = [UIColor list_darkGrayColorAlpha:1];
    self.detailTextLabel.textColor = [UIColor list_blackColorAlpha:1];
    
    /*
     * Create more pleasant background view.
     */
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    self.selectedBackgroundView = view;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = ListGeneralCellPadding;
    y = ListGeneralCellPadding;
    w = CGRectGetWidth(self.textLabel.frame);
    h = CGRectGetHeight(self.textLabel.frame);
    self.textLabel.frame = CGRectMake(x, y, w, h);
    
    self.imageView.frame = CGRectMake(x, y, w, h);
}

@end

