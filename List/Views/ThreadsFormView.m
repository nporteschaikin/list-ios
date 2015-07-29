//
//  ThreadsFormView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/20/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ThreadsFormView.h"
#import "UIButton+List.h"
#import "UIImage+List.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface ThreadsFormView ()

@property (strong, nonatomic) UIButton *privacyButton;

@end

@implementation ThreadsFormView

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Add subviews.
         */
        
        [self insertSubview:self.privacyButton
               aboveSubview:self.textView];
        
        /*
         * Set insets.
         */
        
        UIEdgeInsets insets = self.textView.textContainerInset;
        insets.right = 25.f;
        self.textView.textContainerInset = insets;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMaxX(self.textView.frame) - [self.privacyButton sizeThatFits:CGSizeZero].width - 5.f;
    y = CGRectGetMidY(self.saveButton.frame) - ([self.privacyButton sizeThatFits:CGSizeZero].height / 2);
    w = CGRectGetWidth(self.privacyButton.frame);
    h = CGRectGetHeight(self.privacyButton.frame);
    self.privacyButton.frame = CGRectMake(x, y, w, h);
}

#pragma mark - Button handler

- (void)handlePrivacyButtonTouchDown:(UIButton *)privacyButton {
    self.privacyButton.selected = !self.privacyButton.selected;
}

#pragma mark - Dynamic getters

- (UIButton *)privacyButton {
    if (!_privacyButton) {
        _privacyButton = [[UIButton alloc] init];
        _privacyButton.titleLabel.font = [UIFont list_threadsFormViewPrivacyButtonFont];
        _privacyButton.selected = NO;
        [_privacyButton setImage:[UIImage list_peopleIconImageColor:[UIColor list_blueColorAlpha:1]
                                                                 size:25.f]
                        forState:UIControlStateNormal];
        [_privacyButton setImage:[UIImage list_personIconImageColor:[UIColor list_blueColorAlpha:1]
                                                                 size:25.f]
                        forState:UIControlStateSelected];
        [_privacyButton addTarget:self
                           action:@selector(handlePrivacyButtonTouchDown:)
                 forControlEvents:UIControlEventTouchDown];
        [_privacyButton sizeToFit];
    }
    return _privacyButton;
}

@end
