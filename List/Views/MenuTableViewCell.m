//
//  MenuTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface MenuTableViewCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation MenuTableViewCell

static CGFloat const MenuTableViewCellPaddingX = 12.f;
static CGFloat const MenuTableViewCellPaddingY = 3.f;

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
    
    /*
     * Add subviews.
     */
    
    [self.contentView addSubview:self.titleLabel];
    
    /*
     * Add background color.
     */
    
    self.backgroundColor = [UIColor list_blueColorAlpha:1];
    
    /*
     * Add background color to selected view.
     */
    
    UIView *backgroundColorView = [[UIView alloc] init];
    backgroundColorView.backgroundColor = [UIColor list_lightBlueColorAlpha:1];
    self.selectedBackgroundView = backgroundColorView;
    
}

- (void)layoutSubviews {
    CGFloat x, y, w, h;
    x = MenuTableViewCellPaddingX;
    y = MenuTableViewCellPaddingY;
    w = CGRectGetWidth(self.contentView.bounds) - (MenuTableViewCellPaddingX * 2);
    h = self.titleLabel.font.lineHeight;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = 0.0f;
    height += MenuTableViewCellPaddingY;
    height += self.titleLabel.font.lineHeight;
    height += MenuTableViewCellPaddingY;
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont list_menuTableViewCellTitleFont];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
