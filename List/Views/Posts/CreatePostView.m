//
//  CreatePostView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePostView.h"
#import "CreatePostButton.h"
#import "UIColor+List.h"
#import "UIImage+List.h"

@interface CreatePostView ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) CreatePostButton *textButton;
@property (strong, nonatomic) CreatePostButton *eventButton;

@end

@implementation CreatePostView

static CGFloat const CreatePostViewMargin = 6.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Add subviews.
         */
        
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.textButton];
        [self.scrollView addSubview:self.eventButton];
        
        /*
         * Listen to all buttons.
         */
        
        [self.textButton addTarget:self action:@selector(handleButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self.eventButton addTarget:self action:@selector(handleButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        
    }
    return self;
}

- (void)displayButtons:(BOOL)display animated:(BOOL)animated completion:(void(^)(void))onComplete {
    CGAffineTransform start;
    CGAffineTransform end;
    NSArray *views = @[self.textButton, self.eventButton];
    if (display) {
        start = CGAffineTransformMakeScale(0.1, 0.1);
        end = CGAffineTransformMakeScale(1.0, 1.0);
    } else {
        start = CGAffineTransformMakeScale(1.0, 1.0);
        end = CGAffineTransformMakeScale(0.1, 0.1);
        views = [[views reverseObjectEnumerator] allObjects];
    }
    
    UIView *view;
    for (int i=0; i<views.count; i++) {
        view = views[i];
        view.transform = start;
        [UIView animateWithDuration:(0.25f * ((i+1) * 0.5)) animations:^{
            view.transform = end;
        } completion:^(BOOL finished) {
            view.transform = CGAffineTransformIdentity;
            if (onComplete) onComplete();
        }];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetHeight(self.bounds);
    h = CGRectGetHeight(self.bounds);
    self.textButton.frame = CGRectMake(x, y, w, h);
    
    x = x + w + CreatePostViewMargin;
    self.eventButton.frame = CGRectMake(x, y, w, h);
    
    w = fminf(CGRectGetWidth(self.bounds), CGRectGetMaxX(self.eventButton.frame));
    x = CGRectGetWidth(self.bounds) - w;
    h = CGRectGetHeight(self.bounds);
    self.scrollView.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat width = fminf(size.width, ((size.height * 2) + (CreatePostViewMargin * 1)));
    CGFloat height = size.height;
    return CGSizeMake(width, height);
}

#pragma mark - Button handler

- (void)handleButtonTouchDown:(CreatePostButton *)button {
    if ([self.delegate respondsToSelector:@selector(createPostView:didTouchDownButton:)]) {
        CreatePostViewButtons buttonType;
        if (button == self.eventButton) {
            buttonType = CreatePostViewButtonEvent;
        } else {
            buttonType = CreatePostViewButtonText;
        }
        [self.delegate createPostView:self didTouchDownButton:buttonType];
    }
}

#pragma mark - Dynamic getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (CreatePostButton *)textButton {
    if (!_textButton) {
        _textButton = [[CreatePostButton alloc] init];
        [_textButton setImage:[UIImage list_imageForIcon:LIconCamera size:35.f color:[UIColor whiteColor]]
                     forState:UIControlStateNormal];
    }
    return _textButton;
}

- (CreatePostButton *)eventButton {
    if (!_eventButton) {
        _eventButton = [[CreatePostButton alloc] init];
        [_eventButton setImage:[UIImage list_imageForIcon:LIconEvent size:28.f color:[UIColor whiteColor]]
                      forState:UIControlStateNormal];
    }
    return _eventButton;
}

@end
