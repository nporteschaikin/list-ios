//
//  ListUIPhotosViewCell.m
//  List
//
//  Created by Noah Portes Chaikin on 8/25/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIPhotosViewCell.h"
#import "UIColor+ListUI.h"

@interface ListUIPhotosViewCell ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ListUIPhotosViewCell

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.layer.masksToBounds = YES;
        self.tintColor = [UIColor whiteColor];
        
        /*
         * Add image view.
         */
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.imageView.backgroundColor = [UIColor listBlackColorAlpha:1];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
    }
    return self;
}

@end
