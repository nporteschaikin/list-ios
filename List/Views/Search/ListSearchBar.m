//
//  ListSearchBar.m
//  List
//
//  Created by Noah Portes Chaikin on 11/25/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListSearchBar.h"

@interface ListSearchBar () <UITextFieldDelegate>

@property (strong, nonatomic) ListUITextField *textField;

@end

@implementation ListSearchBar

static CGFloat const kListSearchBarCornerRadius = 3.0f;
static CGFloat const kListSearchBarTextFieldYMargin = 12.0f;
static CGFloat const kListSearchBarTextFieldXMargin = 12.0f;
static CGFloat const kListSearchBarTextFieldYPadding = 6.0f;
static CGFloat const kListSearchBarTextFieldXPadding = 12.0f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Create text field.
         */
        
        self.textField = [[ListUITextField alloc] init];
        self.textField.delegate = self;
        self.textField.textInsets = UIEdgeInsetsMake(kListSearchBarTextFieldYPadding, kListSearchBarTextFieldXPadding, kListSearchBarTextFieldYPadding, kListSearchBarTextFieldXPadding);
        self.textField.layer.cornerRadius = kListSearchBarCornerRadius;
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.font = [UIFont listUI_fontWithSize:12.f];
        [self addSubview:self.textField];
        
        /*
         * Add listener to text field.
         */
        
        [self.textField addTarget:self action:@selector(handleTextFieldEditingChange:) forControlEvents:UIControlEventEditingChanged];
        
        /*
         * Set default placeholder.
         */
        
        self.placeholder = @"Search";
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = kListSearchBarTextFieldXMargin;
    y = kListSearchBarTextFieldYMargin;
    w = CGRectGetWidth(self.bounds) - (kListSearchBarTextFieldXMargin * 2);
    h = CGRectGetHeight(self.bounds) - (kListSearchBarTextFieldYMargin * 2);
    self.textField.frame = CGRectMake(x, y, w, h);
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat height = 0.0f;
    height += kListSearchBarTextFieldYMargin;
    height += [self.textField sizeThatFits:CGSizeMake(size.width, CGFLOAT_MAX)].height;
    height += kListSearchBarTextFieldYMargin;
    return CGSizeMake(size.width, height);
}

#pragma mark - Dynamic getters

- (NSString *)text {
    
    /*
     * Set text field.
     */
    
    ListUITextField *textField = self.textField;
    return textField.text;
}

#pragma mark - Dynamic setters

- (void)setPlaceholder:(NSString *)placeholder {
    
    /*
     * Store locally.
     */
    
    _placeholder = placeholder;
    
    /*
     * Set text field.
     */
    
    self.textField.placeholder = placeholder;
    
}

#pragma mark - Notification listener

- (void)handleTextFieldEditingChange:(ListUITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        ListUITextField *textField = self.textField;
        NSString *text = textField.text;
        return [self.delegate searchBar:self textDidChange:text];
    }
}

#pragma mark - UITextFieldDelegate

/*
 * Essentially just proxies to ListSearchBarDelegate
 */

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField; {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        return [self.delegate searchBarShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField; {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        return [self.delegate searchBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([self.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]) {
        return [self.delegate searchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    return YES;
}

@end
