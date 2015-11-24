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
@property (strong, nonatomic) CALayer *progressTrack;
@property (strong, nonatomic) CALayer *progressBar;

@end

@implementation CreatePictureEditorView

static CGFloat const kCreatePictureEditorViewTextViewInset = 12.f;
static CGFloat const kCreatePictureEditorViewImageViewSize = 50.f;
static CGFloat const kCreatePictureEditorViewToolbarViewHeight = 50.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Disable scrolling by default
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
         * Create toolbar.
         */
        
        self.toolbar = [[UIToolbar alloc] init];
        self.toolbar.clipsToBounds = YES;
        self.toolbar.barTintColor = [UIColor whiteColor];
        self.toolbar.tintColor = [UIColor listBlueColorAlpha:1];
        [self.contentView addSubview:self.toolbar];
        
        /*
         * Create progress track.
         */
        
        self.progressTrack = [CALayer layer];
        self.progressTrack.backgroundColor = [UIColor listLightGrayColorAlpha:1.0f].CGColor;
        [self.contentView.layer addSublayer:self.progressTrack];
        
        /*
         * Create progress bar.
         */
        
        self.progressBar = [CALayer layer];
        self.progressBar.backgroundColor = [UIColor listBlueColorAlpha:1.0f].CGColor;
        [self.contentView.layer addSublayer:self.progressBar];
        
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
     * Layout progress view.
     */
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.formView.bounds);
    h = 3.0f;
    self.progressTrack.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout text view.
     */
    
    x = 0.0f;
    y = 3.0f;
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
     * Set progress bar frame.
     */
    
    [self updateProgressBarFrame];
    
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

- (BOOL)resignFirstResponder {
    [self.textView resignFirstResponder];
    return YES;
}

- (void)updateProgressBarFrame {
    
    /*
     * Update frame for progress
     * bar.
     */
    
    CGFloat progress = self.progress;
    CALayer *progressTrack = self.progressTrack;
    CALayer *progressBar = self.progressBar;
    CGRect frame = progressTrack.frame;
    frame.size.width = frame.size.width * progress;
    progressBar.frame = frame;
    
}

#pragma mark - Dynamic setters

- (void)setProgress:(CGFloat)progress {
    
    /*
     * Set progress.
     */
    
    _progress = progress;
    
    /*
     * Set progress bar frame.
     */
    
    [self updateProgressBarFrame];
    
}

@end
