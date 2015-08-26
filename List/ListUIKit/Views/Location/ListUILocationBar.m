//
//  ListUILocationBar.m
//  List
//
//  Created by Noah Portes Chaikin on 8/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUILocationBar.h"
#import "UIColor+ListUI.h"
#import "UIFont+ListUI.h"

@interface ListUILocationBar ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ListUILocationBar

static CGFloat const kListListUILocationBarPadding = 12.f;
static CGFloat const kListListUILocationBarDefaultHeight = 49.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Create image view.
         */
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
        [self addSubview:self.imageView];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    /*
     * Set item.
     */
    
    ListUILocationBarItem *item = self.item;
    self.backgroundColor = item.barTintColor;
    self.tintColor = item.tintColor;
    self.imageView.image = [item.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    /*
     * Layout image view.
     */
    
    size = [self.imageView sizeThatFits:CGSizeZero];
    x = kListListUILocationBarPadding;
    y = (CGRectGetHeight(self.bounds) - size.height) / 2;
    w = size.width;
    h = size.height;
    self.imageView.frame = CGRectMake(x, y, w, h);
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, kListListUILocationBarDefaultHeight);
}

@end
