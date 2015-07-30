//
//  PostsSearchBar.m
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsSearchBar.h"
#import "UIImage+List.h"
#import "UIColor+List.h"
#import "UIFont+List.h"

@interface PostsSearchBar ()

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIImageView *searchImageView;
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
    
    [self addSubview:self.searchImageView];
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
    y = CGRectGetMidY(self.bounds) - (CGRectGetHeight(self.searchImageView.frame) / 2);
    w = CGRectGetWidth(self.searchImageView.frame);
    h = CGRectGetHeight(self.searchImageView.frame);
    self.searchImageView.frame = CGRectMake(x, y, w, h);
    
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
- (UIImageView *)searchImageView {
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] initWithImage:[UIImage list_searchIconImageColor:[UIColor list_grayColorAlpha:1.0f]
                                                                                              size:16.0f]];
        [_searchImageView sizeToFit];
    }
    return _searchImageView;
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
