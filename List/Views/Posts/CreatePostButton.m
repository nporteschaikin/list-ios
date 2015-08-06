//
//  CreatePostButton.m
//  List
//
//  Created by Noah Portes Chaikin on 8/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePostButton.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@implementation CreatePostButton

- (instancetype)init {
    if (self = [super init]) {
        self.titleLabel.font = [UIFont list_createPostButtonFont];
        self.backgroundColor = [UIColor list_blueColorAlpha:1];
        [self setTitleColor:[UIColor whiteColor]
                   forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = [self.imageView sizeThatFits:CGSizeZero];
    CGFloat x, y, w, h;
    x = CGRectGetMidX(self.bounds) - (size.width / 2);
    y = CGRectGetMidY(self.bounds) - (size.height / 2);
    w = size.width;
    h = size.height;
    self.imageView.frame = CGRectMake(x, y, w, h);
    
    self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
}

@end
