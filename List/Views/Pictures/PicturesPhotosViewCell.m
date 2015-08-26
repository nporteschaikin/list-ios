//
//  PicturesPhotosViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/25/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PicturesPhotosViewCell.h"

@interface PicturesPhotosViewCell ()

@property (strong, nonatomic) PicturesHeaderView *headerView;

@end

@implementation PicturesPhotosViewCell

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Add subviews.
         */
        
        self.headerView = [[PicturesHeaderView alloc] init];
        [self addSubview:self.headerView];
        
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
    y = CGRectGetMaxY(self.bounds) - size.height - 12.f;
    h = size.height;
    self.headerView.frame = CGRectMake(x, y, w, h);
    
}

@end
