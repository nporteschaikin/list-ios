//
//  PicturesCollectionViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 9/9/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesCollectionViewCell.h"

@interface PicturesCollectionViewCell ()

@property (strong, nonatomic) UIImageView *assetView;
@property (strong, nonatomic) PicturesHeaderView *headerView;

@end

@implementation PicturesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        /*
         * Add asset view.
         */
        
        UIImageView *assetView = self.assetView = [[UIImageView alloc] init];
        assetView.contentMode = UIViewContentModeScaleAspectFill;
        assetView.clipsToBounds = YES;
        [self addSubview:assetView];
        
        /*
         * Add header view.
         */
        
        PicturesHeaderView *headerView = self.headerView = [[PicturesHeaderView alloc] init];
        headerView.tintColor = [UIColor whiteColor];
        [self addSubview:headerView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    /*
     * Lay out header view.
     */
    
    x = 12.f;
    w = CGRectGetWidth(self.bounds) - 24.f;
    size = [self.headerView sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    y = 12.f;
    self.headerView.frame = CGRectMake(x, y, w, h);
    
    /*
     * Lay out asset view.
     */
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.bounds);
    h = CGRectGetHeight(self.bounds);
    self.assetView.frame = CGRectMake(x, y, w, h);
    
}

@end
