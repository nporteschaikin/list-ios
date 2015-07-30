//
//  PostEditorHeaderView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostEditorHeaderView.h"
#import "UIColor+List.h"

@interface PostEditorHeaderView ()

@property (strong, nonatomic) UIImageView *avatarImageView;

@end

@implementation PostEditorHeaderView

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Add subviews.
         */
        
        [self addSubview:self.avatarImageView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = (self.xMargin * 0.75) + (self.iconControlPosition == HeaderViewIconControlPositionLeft ? CGRectGetMaxX(self.iconControl.frame) : 0.0f);
    y = CGRectGetMidY(self.bounds) - ((CGRectGetHeight(self.bounds) * 0.6) / 2);
    w = CGRectGetHeight(self.bounds) * 0.6;
    h = w;
    self.avatarImageView.frame = CGRectMake(x, y, w, h);
    self.avatarImageView.layer.cornerRadius = w / 2;
    
    CGRect frame = self.textLabel.frame;
    frame.origin.x = frame.origin.x + CGRectGetWidth(self.avatarImageView.frame) + (self.xMargin * 0.5);
    frame.size.width = frame.size.width - CGRectGetWidth(self.avatarImageView.frame) - (self.xMargin * 0.5);
    self.textLabel.frame = frame;
}

#pragma mark - Dynamic getters

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.backgroundColor = [UIColor list_lightBlueColorAlpha:1];
        _avatarImageView.clipsToBounds = YES;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImageView.layer.borderWidth = 2.0f;
        _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _avatarImageView;
}

@end
