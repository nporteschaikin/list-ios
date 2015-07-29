//
//  SettingsSliderTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 7/27/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "SettingsSliderTableViewCell.h"
#import "UIFont+List.h"

@interface SettingsSliderTableViewCell ()

@property (strong, nonatomic) UISlider *slider;
@property (strong, nonatomic) UILabel *amountLabel;

@end

@implementation SettingsSliderTableViewCell

static CGFloat const SettingsSliderTableViewCellInset = 15.f;
static CGFloat const SettingsSliderTableViewCellAmountLabelWidth = 75.f;

- (instancetype)init {
    if (self = [super init]) {
        [self setupSliderTableViewCell];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSliderTableViewCell];
    }
    return self;
}

- (void)setupSliderTableViewCell {
    [self.contentView addSubview:self.slider];
    [self.contentView addSubview:self.amountLabel];
    [self.slider addTarget:self
                    action:@selector(handleSliderValueChange:)
          forControlEvents:UIControlEventValueChanged];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self handleSliderValueChange:self.slider];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    
    x = CGRectGetMinX(self.textLabel.frame);
    y = CGRectGetMinY(self.textLabel.frame);
    w = [self.textLabel sizeThatFits:CGSizeMake(0.0f, 0.0f)].width;
    h = CGRectGetHeight(self.textLabel.frame);
    self.textLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.textLabel.frame) + SettingsSliderTableViewCellInset;
    w = CGRectGetWidth(self.contentView.bounds) - x - (SettingsSliderTableViewCellInset * 2) - SettingsSliderTableViewCellAmountLabelWidth;
    h = CGRectGetHeight(self.contentView.bounds) / 2;
    y = CGRectGetMidY(self.contentView.bounds) - (h / 2);
    self.slider.frame = CGRectMake(x, y, w, h);
    
    w = SettingsSliderTableViewCellAmountLabelWidth;
    x = CGRectGetMaxX(self.slider.frame) + SettingsSliderTableViewCellInset;
    y = 0.0f;
    h = CGRectGetHeight(self.contentView.bounds);
    self.amountLabel.frame = CGRectMake(x, y, w, h);
}

- (void)handleSliderValueChange:(UISlider *)slider {
    self.amountLabel.text = [NSString stringWithFormat:@"%.02f %@", slider.value, self.amountMetric];
}

#pragma mark - Dynamic getters

- (UISlider *)slider {
    if (!_slider) {
        _slider = [[UISlider alloc] init];
    }
    return _slider;
}

- (UILabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [[UILabel alloc] init];
        _amountLabel.font = [UIFont list_settingsTableViewCellTextFont];
    }
    return _amountLabel;
}

@end
