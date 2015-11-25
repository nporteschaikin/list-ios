//
//  LocationPickerTableViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/25/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationPickerTableViewCell.h"

@interface LocationPickerTableViewCell ()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;

@end

@implementation LocationPickerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        UIView *contentView = self.contentView;
        
        /*
         * Create subviews.
         */
        
        UILabel *nameLabel = self.nameLabel = [[UILabel alloc] init];
        nameLabel.numberOfLines = 1;
        nameLabel.font = [UIFont listUI_semiboldFontWithSize:13.f];
        nameLabel.textColor = [UIColor listUI_blackColorAlpha:1.0f];
        [contentView addSubview:nameLabel];
        
        UILabel *descriptionLabel = self.descriptionLabel = [[UILabel alloc] init];
        descriptionLabel.numberOfLines = 1;
        descriptionLabel.font = [UIFont listUI_fontWithSize:11.f];
        descriptionLabel.textColor = [UIColor listUI_grayColorAlpha:1.0f];
        [contentView addSubview:descriptionLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGFloat totalHeight = self.nameLabel.font.lineHeight + self.descriptionLabel.font.lineHeight;
    
    x = 12.f;
    y = (CGRectGetHeight(self.contentView.bounds) - totalHeight) / 2;
    w = CGRectGetWidth(self.contentView.bounds) - 24.f;
    h = self.nameLabel.font.lineHeight;
    self.nameLabel.frame = CGRectMake(x, y, w, h);
    
    y = y + h;
    h = self.descriptionLabel.font.lineHeight;
    self.descriptionLabel.frame = CGRectMake(x, y, w, h);

}

@end
