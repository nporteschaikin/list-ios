//
//  CreatePictureEditorView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePictureEditorView.h"

@interface CreatePictureEditorView ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *formView;
@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) ListUITextView *textView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) CALayer *progressTrack;
@property (strong, nonatomic) CALayer *progressBar;
@property (strong, nonatomic) UIButton *returnButton;
@property (strong, nonatomic) UIButton *closeButton;

@end

@implementation CreatePictureEditorView

static CGFloat const kCreatePictureEditorViewTextViewInset = 12.f;
static CGFloat const kCreatePictureEditorViewImageViewSize = 50.f;
static CGFloat const kCreatePictureEditorViewToolbarViewHeight = 50.f;

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Add blur effect.
         */
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:effectView];
        
        /*
         * Create scroll view.
         */
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.scrollEnabled = NO;
        [self addSubview:self.scrollView];
        
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
        [self.scrollView addSubview:self.contentView];
        
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
        
        /*
         * Set button params.
         */
        
        UIColor *color = [UIColor whiteColor];
        CGSize shadowOffset = CGSizeZero;
        CGFloat shadowRadius = 3.0f;
        CGFloat shadowOpacity = 0.5f;
        CGColorRef shadowColor = [UIColor listBlackColorAlpha:1].CGColor;
        
        /*
         * Create flip button.
         */
        
        UIImage *returnImage = [UIImage listIcon:ListUIIconReturn size:30.f color:color];
        self.returnButton = [[UIButton alloc] init];
        self.returnButton.layer.shadowOffset = shadowOffset;
        self.returnButton.layer.shadowRadius = shadowRadius;
        self.returnButton.layer.shadowOpacity = shadowOpacity;
        self.returnButton.layer.shadowColor = shadowColor;
        [self.returnButton setImage:returnImage forState:UIControlStateNormal];
        [self addSubview:self.returnButton];
        
        /*
         * Create close button.
         */
        
        UIImage *closeImage = [UIImage listIcon:ListUIIconCross size:30.f color:color];
        self.closeButton = [[UIButton alloc] init];
        self.closeButton.layer.shadowOffset = shadowOffset;
        self.closeButton.layer.shadowRadius = shadowRadius;
        self.closeButton.layer.shadowOpacity = shadowOpacity;
        self.closeButton.layer.shadowColor = shadowColor;
        [self.closeButton setImage:closeImage forState:UIControlStateNormal];
        [self addSubview:self.closeButton];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    /*
     * Layout return button.
     */
    
    size = [self.returnButton sizeThatFits:CGSizeZero];
    x = 25.f;
    y = 25.f;
    w = size.width;
    h = size.height;
    self.returnButton.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout close button.
     */
    
    size = [self.closeButton sizeThatFits:CGSizeZero];
    x = CGRectGetWidth(self.bounds) - (size.width + 25.f);
    w = size.width;
    h = size.height;
    self.closeButton.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout scroll view.
     */
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.bounds);
    h = CGRectGetHeight(self.bounds);
    self.scrollView.frame = CGRectMake(x, y, w, h);
    
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
    self.scrollView.contentSize = CGSizeMake(w, h);
    
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
