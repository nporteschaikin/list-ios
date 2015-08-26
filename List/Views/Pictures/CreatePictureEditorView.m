//
//  CreatePictureEditorView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePictureEditorView.h"

@interface CreatePictureEditorView ()

@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *formView;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) ListUITextView *textView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation CreatePictureEditorView

static CGFloat const kCreatePictureEditorViewTextViewInset = 12.f;
static CGFloat const kCreatePictureEditorViewImageViewSize = 50.f;
static CGFloat const kCreatePictureEditorViewToolbarViewHeight = 50.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.scrollEnabled = NO;
        
        /*
         * Add blur effect.
         */
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:effectView];
        
        /*
         * Create content view.
         */
        
        self.contentView = [[UIView alloc] init];
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.shadowColor = [UIColor listBlackColorAlpha:1].CGColor;
        self.contentView.layer.shadowRadius = 6.0f;
        self.contentView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
        self.contentView.layer.shadowOpacity = 1.0f;
        self.contentView.layer.cornerRadius = 3.0f;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentView];
        
        /*
         * Create form view.
         */
        
        self.formView = [[UIView alloc] init];
        [self.contentView addSubview:self.formView];
        
        /*
         * Create text view.
         */
        
        self.textView = [[ListUITextView alloc] init];
        self.textView.textContainerInset = UIEdgeInsetsMake(kCreatePictureEditorViewTextViewInset, (kCreatePictureEditorViewTextViewInset * 1.25) + kCreatePictureEditorViewImageViewSize, kCreatePictureEditorViewTextViewInset, kCreatePictureEditorViewTextViewInset);
        [self.formView addSubview:self.textView];
        
        /*
         * Create image view.
         */
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor listBlackColorAlpha:1];
        self.imageView.clipsToBounds = YES;
        self.imageView.layer.cornerRadius = 3.0f;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.formView addSubview:self.imageView];
        
        /*
         * Create toolbar view.
         */
        
        self.toolbar = [[UIToolbar alloc] init];
        self.toolbar.clipsToBounds = YES;
        self.toolbar.barTintColor = [UIColor whiteColor];
        self.toolbar.tintColor = [UIColor listBlueColorAlpha:1];
        [self.contentView addSubview:self.toolbar];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    /*
     * Layout content view.
     */
    
    size = CGSizeMake(CGRectGetWidth(self.bounds), kCreatePictureEditorViewImageViewSize + (kCreatePictureEditorViewTextViewInset * 2) + kCreatePictureEditorViewToolbarViewHeight);
    x = 12.f;
    y = CGRectGetHeight(self.bounds) - (size.height + 12.f);
    w = size.width - 24.f;
    h = size.height;
    self.contentView.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout form view.
     */
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.contentView.bounds);
    h = CGRectGetHeight(self.contentView.bounds) - kCreatePictureEditorViewToolbarViewHeight;
    self.formView.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout text view.
     */
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.formView.bounds);
    h = CGRectGetHeight(self.formView.bounds);
    self.textView.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout image view.
     */
    
    x = kCreatePictureEditorViewTextViewInset;
    y = kCreatePictureEditorViewTextViewInset;
    w = kCreatePictureEditorViewImageViewSize;
    h = kCreatePictureEditorViewImageViewSize;
    self.imageView.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout toolbar view.
     */
    
    x = 0.0f;
    w = CGRectGetWidth(self.contentView.bounds);
    y = CGRectGetHeight(self.contentView.bounds) - kCreatePictureEditorViewToolbarViewHeight;
    h = kCreatePictureEditorViewToolbarViewHeight;
    self.toolbar.frame = CGRectMake(x, y, w, h);
    
    /*
     * Set content size.
     */
    
    w = CGRectGetWidth(self.bounds);
    h = CGRectGetHeight(self.bounds);
    self.contentSize = CGSizeMake(w, h);
    
}

- (BOOL)becomeFirstResponder {
    [self.textView becomeFirstResponder];
    return YES;
}

#pragma mark - Dynamic getters

- (NSString *)text {
    
    /*
     * Get text view text.
     */
    
    return self.textView.text;
    
}

- (NSArray *)toolbarItems {
    
    /*
     * Return toolbar items.
     */
    
    return self.toolbar.items;
    
}

#pragma mark - Dynamic setters

- (void)setText:(NSString *)text {
    
    /*
     * Set text view text.
     */
    
    self.textView.text = text;
    
}

- (void)setImage:(UIImage *)image {
    
    /*
     * Set image.
     */
    
    _image = image;
    
    /*
     * Set image view image.
     */
    
    self.imageView.image = image;
    
}

- (void)setToolbarItems:(NSArray *)toolbarItems {
    
    /*
     * Set toolbar items without animation.
     */
    
    [self setToolbarItems:toolbarItems animated:NO];
    
}

- (void)setToolbarItems:(NSArray *)items animated:(BOOL)animated {
    
    /*
     * Set toolbar items with or without animation.
     */
    
    [self.toolbar setItems:items animated:animated];
    
}

@end
