//
//  SettingsSliderTableViewCell.h
//  List
//
//  Created by Noah Portes Chaikin on 7/27/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "SettingsTableViewCell.h"

@interface SettingsSliderTableViewCell : SettingsTableViewCell

@property (strong, nonatomic, readonly) UISlider *slider;
@property (strong, nonatomic, readonly) UILabel *amountLabel;
@property (copy, nonatomic) NSString *amountMetric;

@end
