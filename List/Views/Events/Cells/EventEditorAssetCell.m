//
//  EventEditorAssetCell.m
//  List
//
//  Created by Noah Portes Chaikin on 11/23/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventEditorAssetCell.h"

@interface EventEditorAssetCell ()

@property (strong, nonatomic) UIImageView *assetView;
@property (strong, nonatomic) UIImageView *addImageView;
@property (strong, nonatomic) UILabel *addLabel;

@end

@implementation EventEditorAssetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        /*
         * Set defaults.
         */
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        /*
         * Create subviews.
         */
        
        UIImageView *assetView = self.assetView = [[UIImageView alloc] init];
        assetView.backgroundColor = [UIColor listBlackColorAlpha:1.0f];
        assetView.contentMode = UIViewContentModeScaleAspectFill;
        assetView.clipsToBounds = YES;
        [self.contentView addSubview:assetView];
        
        UIImage *addImage = [[UIImage listIcon:ListUIIconPictures size:30.f] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *addImageView = self.addImageView = [[UIImageView alloc] initWithImage:addImage];
        addImageView.tintColor = [UIColor whiteColor];
        [self.contentView addSubview:addImageView];
        
        UILabel *addLabel = self.addLabel = [[UILabel alloc] init];
        addLabel.text = @"Add a photo";
        addLabel.textAlignment = NSTextAlignmentCenter;
        addLabel.font = [UIFont listFontWithSize:12.f];
        addLabel.textColor = [UIColor whiteColor];
        addLabel.numberOfLines = 1;
        [self.contentView addSubview:addLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.contentView.bounds);
    h = CGRectGetHeight(self.contentView.bounds);
    self.assetView.frame = CGRectMake(x, y, w, h);
    
    size = [self.addImageView sizeThatFits:CGSizeZero];
    x = (CGRectGetWidth(self.contentView.bounds) - size.width) / 2;
    y = (CGRectGetHeight(self.contentView.bounds) - (size.height + 6.0f + self.addLabel.font.lineHeight)) / 2;
    w = size.width;
    h = size.height;
    self.addImageView.frame = CGRectMake(x, y, w, h);
    
    x = 0.0f;
    y = y + h + 6.0f;
    w = CGRectGetWidth(self.contentView.bounds);
    h = self.addLabel.font.lineHeight;
    self.addLabel.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Dynamic setters

- (void)setHelperViewsVisible:(BOOL)helperViewsVisible {
    
    /*
     * Set property.
     */
    
    _helperViewsVisible = helperViewsVisible;
    
    /*
     * Set view visibility.
     */
    
    self.addImageView.hidden = !helperViewsVisible;
    self.addLabel.hidden = !helperViewsVisible;
    
}

@end
