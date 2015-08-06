//
//  ActivityIndicatorOverlay.m
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ActivityIndicatorOverlay.h"
#import "ActivityIndicatorView.h"
#import "Constants.h"

@interface ActivityIndicatorOverlay ()

@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;

@end

@implementation ActivityIndicatorOverlay

- (instancetype)init {
    if (self = [super init]) {
        self.alpha = 0.0f;
        [self addSubview:self.activityIndicatorView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMidX(self.bounds) - (ActivityIndicatorViewDefaultSize / 2);
    y = CGRectGetMidY(self.bounds) - (ActivityIndicatorViewDefaultSize / 2);
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
}

- (void)display:(BOOL)display completion:(void(^)(void))onComplete {
    if (display) {
        self.activityIndicatorView.hidden = NO;
    }
    self.alpha = display ? 0.0f : 1.0f;
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = display ? 1.0f : 0.0f;
    } completion:^(BOOL finished) {
        if (!display) {
            self.activityIndicatorView.hidden = YES;
        }
        if (onComplete) onComplete();
    }];
}

- (void)setHidden:(BOOL)hidden {
    if (hidden) {
        [self display:NO completion:^{
           [super setHidden:hidden];
        }];
    } else {
        [super setHidden:hidden];
        [self display:YES completion:nil];
    }
}

#pragma mark - Dynamic getters

- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleBlue];
        _activityIndicatorView.hidden = YES;
    }
    return _activityIndicatorView;
}

@end
