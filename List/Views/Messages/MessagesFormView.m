//
//  MessagesFormView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/20/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MessagesFormView.h"
#import "UIButton+List.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface MessagesFormView ()

@property (strong, nonatomic) LTextView *textView;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) CALayer *borderLayer;

@end

@implementation MessagesFormView

static CGFloat const MessagesFormViewPadding = 6.f;

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    /*
     * Set background.
     */
    
    self.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    
    /*
     * Add subviews
     */
    
    [self addSubview:self.textView];
    [self addSubview:self.saveButton];
    [self.layer addSublayer:self.borderLayer];
    
    /*
     * Add notifications
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(textViewTextDidChange:)
                          name:UITextViewTextDidChangeNotification
                        object:self.textView];
    
}

- (void)dealloc {
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = MessagesFormViewPadding;
    y = MessagesFormViewPadding;
    w = CGRectGetWidth(self.bounds) - CGRectGetWidth(self.saveButton.frame) - (MessagesFormViewPadding * 5);
    h = [self.textView sizeThatFits:CGSizeMake(w, CGFLOAT_MIN)].height;
    self.textView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.textView.frame) + (MessagesFormViewPadding * 2);
    y = CGRectGetHeight(self.bounds) - CGRectGetHeight(self.saveButton.frame) - MessagesFormViewPadding;
    w = CGRectGetWidth(self.saveButton.frame);
    h = CGRectGetHeight(self.saveButton.frame);
    self.saveButton.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.layer.bounds);
    y = CGRectGetMinY(self.layer.bounds);
    w = CGRectGetWidth(self.layer.bounds);
    h = 1.0f;
    self.borderLayer.frame = CGRectMake(x, y, w, h);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = 0.0f;
    height += MessagesFormViewPadding;
    height += CGRectGetHeight(self.textView.frame);
    height += MessagesFormViewPadding;
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[LTextView alloc] init];
        _textView.layer.borderColor = [UIColor list_grayColorAlpha:1].CGColor;
        _textView.layer.borderWidth = 1.0f;
        _textView.layer.cornerRadius = 3.0f;
        _textView.font = [UIFont list_messagesFormViewTextViewFont];
    }
    return _textView;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] init];
        _saveButton.titleLabel.font = [UIFont list_messagesFormViewSaveButtonFont];
        [_saveButton setTitleColor:[UIColor list_blueColorAlpha:1]
                          forState:UIControlStateNormal];
        [_saveButton setTitle:@"Send"
                     forState:UIControlStateNormal];
        [_saveButton sizeToFit];
    }
    return _saveButton;
}

- (CALayer *)borderLayer {
    if (!_borderLayer) {
        _borderLayer = [CALayer layer];
        _borderLayer.backgroundColor = [UIColor list_grayColorAlpha:1].CGColor;
    }
    return _borderLayer;
}

#pragma mark - Observers

- (void)textViewTextDidChange:(NSNotification *)notification {
    CGRect frame = self.textView.frame;
    CGFloat diffY = [self.textView sizeThatFits:CGSizeMake(CGRectGetWidth(self.textView.frame), CGFLOAT_MIN)].height - frame.size.height;
    
    frame.size.height += diffY;
    self.textView.frame = frame;
    
    frame = self.frame;
    frame.size.height += diffY;
    self.frame = frame;
}

@end
