//
//  PostsSearchBar.m
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsSearchBar.h"
#import "UIColor+List.h"
#import "UIFont+List.h"
#import "LIconView.h"

@interface PostsSearchBar ()

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) LIconView *searchIconView;
@property (strong, nonatomic) CALayer *borderLayer;

@end

@implementation PostsSearchBar

static CGFloat const PostsSearchBarXInset = 12.f;

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    /*
     * Set defaults.
     */
    
    self.backgroundColor = [UIColor colorWithWhite:1.0f
                                             alpha:0.95f];
    
    /*
     * Add subviews.
     */
    
    [self addSubview:self.searchIconView];
    [self addSubview:self.textField];
    [self.layer addSublayer:self.borderLayer];
    
    /*
     * Add notification for change
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(textFieldDidChange:)
                          name:UITextFieldTextDidChangeNotification
                        object:self.textField];
    
}

- (void)layoutSubviews {
    CGFloat x, y, w, h;
    x = PostsSearchBarXInset;
    y = CGRectGetMidY(self.bounds) - (CGRectGetHeight(self.searchIconView.frame) / 2);
    w = CGRectGetWidth(self.searchIconView.frame);
    h = CGRectGetHeight(self.searchIconView.frame);
    self.searchIconView.frame = CGRectMake(x, y, w, h);
    
    x = x + w + (PostsSearchBarXInset / 2);
    y = CGRectGetMinY(self.bounds);
    w = CGRectGetWidth(self.bounds) - x;
    h = CGRectGetHeight(self.bounds);
    self.textField.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.layer.bounds);
    y = CGRectGetMaxY(self.layer.bounds) - 1.0f;
    w = CGRectGetWidth(self.layer.bounds);
    h = 1.0f;
    self.borderLayer.frame = CGRectMake(x, y, w, h);
}
- (LIconView *)searchIconView {
    if (!_searchIconView) {
        _searchIconView = [[LIconView alloc] init];
        _searchIconView.icon = LIconSearch;
        _searchIconView.iconColor = [UIColor list_grayColorAlpha:1];
        _searchIconView.iconSize = 20.f;
        [_searchIconView sizeToFit];
    }
    return _searchIconView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.font = [UIFont list_postsSearchBarFont];
        _textField.textColor = [UIColor list_blackColorAlpha:1];
        _textField.placeholder = @"Search";
    }
    return _textField;
}

- (CALayer *)borderLayer {
    if (!_borderLayer) {
        _borderLayer = [CALayer layer];
        _borderLayer.backgroundColor = [UIColor list_lightGrayColorAlpha:1].CGColor;
    }
    return _borderLayer;
}

- (NSString *)text {
    return self.textField.text;
}

- (void)textFieldDidChange:(NSNotification *)notification {
    SEL action = @selector(debouncedTextFieldDidChange:);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:action object:nil];
    [self performSelector:@selector(debouncedTextFieldDidChange:) withObject:nil afterDelay:1.0f];
    
}

- (void)debouncedTextFieldDidChange:(NSNotification *)notification {
    if ([self.delegate respondsToSelector:@selector(postsSearchBarDidChange:)]) {
        [self.delegate postsSearchBarDidChange:self];
    }
}

- (BOOL)becomeFirstResponder {
    return [self.textField becomeFirstResponder];
}

- (BOOL)isFirstResponder {
    return self.textField.isFirstResponder;
}

@end
