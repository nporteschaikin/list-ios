//
//  LoginView.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LoginView.h"
#import "UIImageView+WebCache.h"

@interface LoginView ()

@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIButton *facebookButton;
@property (strong, nonatomic) NSArray *labels;
@property (strong, nonatomic) NSArray *imageViews;
@property (strong, nonatomic) NSArray *dots;

@end

@implementation LoginView

static CGFloat const kLoginViewLogoImageViewSize = 50.f;
static CGFloat const kLoginViewDotSize = 7.f;
static CGFloat const kLoginViewDotDefaultAlpha = 0.5f;
static CGFloat const kLoginViewMargin = 24.f;

- (instancetype)init {
    if (self = [super init]) {
        
        CGRect frame = self.bounds;
        
        /*
         * Create overlay view.
         */
        
        self.overlayView = [[UIView alloc] initWithFrame:frame];
        self.overlayView.backgroundColor = [UIColor blackColor];
        self.overlayView.alpha = 0.45;
        self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.overlayView];
        
        /*
         * Create logo view.
         */
        
        UIImage *image = [UIImage listLogoImageSize:kLoginViewLogoImageViewSize];
        self.logoImageView = [[UIImageView alloc] initWithImage:image];
        self.logoImageView.frame = CGRectMake(kLoginViewMargin, (kLoginViewMargin * 2), kLoginViewLogoImageViewSize, kLoginViewLogoImageViewSize);
        [self addSubview:self.logoImageView];
        
        /*
         * Create scroll view.
         */
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.delegate = self;
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        /*
         * Set button defaults.
         */
        
        UIEdgeInsets buttonInsets = UIEdgeInsetsMake(12, 24, 12, 24);
        CGFloat buttonBorderWidth = 2.f;
        CGFloat buttonCornerRadius = 3.f;
        
        /*
         * Create Facebook button.
         */
        
        self.facebookButton = [[UIButton alloc] init];
        self.facebookButton.layer.cornerRadius = buttonCornerRadius;
        self.facebookButton.layer.borderWidth = buttonBorderWidth;
        self.facebookButton.contentEdgeInsets = buttonInsets;
        self.facebookButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.facebookButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.facebookButton.titleLabel.font = [UIFont listFontWithSize:15.f];
        [self.facebookButton setTitle:@"Sign in with Facebook" forState:UIControlStateNormal];
        [self.facebookButton addTarget:self action:@selector(handleButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:self.facebookButton];
        
        /*
         * Set defaults.
         */
        
        self.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}

- (void)reloadView {
    
    /*
     * Remove all subviews from scroll view.
     */
    
    UIScrollView *scrollView = self.scrollView;
    NSArray *labels = self.labels;
    NSArray *imageViews = self.imageViews;
    NSArray *dots = self.dots;
    for (UILabel *label in labels) {
        [label removeFromSuperview];
    }
    for (UIImageView *imageView in imageViews) {
        [imageView removeFromSuperview];
    }
    for (UIView *dot in dots) {
        [dot removeFromSuperview];
    }
    
    /*
     * Create views for each page.
     */
    
    id<LoginViewDataSource> dataSource = self.dataSource;
    UIView *overlayView = self.overlayView;
    NSInteger numberOfPages = [dataSource numberOfPagesInLoginView:self];
    NSMutableArray *newLabels = [NSMutableArray array];
    NSMutableArray *newImageViews = [NSMutableArray array];
    NSMutableArray *newDots = [NSMutableArray array];
    UILabel *label;
    NSString *text;
    UIImageView *imageView;
    NSURL *URL;
    UIView *dot;
    for (NSInteger i=0; i<numberOfPages; i++) {
        
        /*
         * Create label.
         */
        
        label = [[UILabel alloc] init];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.frame = scrollView.bounds;
        label.font = [UIFont listLightFontWithSize:20.f];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        text = [dataSource loginView:self textForPageAtIndex:i];
        label.text = text;
        [scrollView addSubview:label];
        [newLabels addObject:label];
        
        /*
         * Create dots.
         */
        
        dot = [[UIView alloc] init];
        dot.layer.cornerRadius = (kLoginViewDotSize / 2);
        dot.backgroundColor = [UIColor whiteColor];
        [self addSubview:dot];
        [newDots addObject:dot];
        dot.alpha = i == 0 ? 1 : kLoginViewDotDefaultAlpha;
        
        /*
         * Add image view.
         */
        
        URL = [dataSource loginView:self imageURLForPageAtIndex:i];
        imageView = [[UIImageView alloc] init];
        imageView.alpha = 0.0f;
        [imageView sd_setImageWithURL:URL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (i==0) {
                [UIView animateWithDuration:0.25f animations:^{
                    imageView.alpha = 1.0f;
                }];
            }
        }];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.frame = scrollView.bounds;
        [self insertSubview:imageView belowSubview:overlayView];
        [newImageViews addObject:imageView];
        
    }
    
    /*
     * Persist generated views.
     */
    
    self.labels = [NSArray arrayWithArray:newLabels];
    self.imageViews = [NSArray arrayWithArray:newImageViews];
    self.dots = [NSArray arrayWithArray:newDots];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size;
    CGRect frame;
    CGFloat x, y, w, h;
    
    /*
     * Set label frames.
     */
    
    UIScrollView *scrollView = self.scrollView;
    frame = scrollView.frame;
    w = CGRectGetWidth(scrollView.bounds);
    NSArray *labels = self.labels;
    CGFloat centerX = w / 2;
    CGFloat centerY = CGRectGetHeight(scrollView.bounds) / 2;
    CGFloat maxY = 0;
    x = 0;
    for (UIView *label in labels) {
        size = [label sizeThatFits:CGSizeMake(w - (kLoginViewMargin * 2), CGFLOAT_MAX)];
        label.frame = CGRectMake(0, 0, w - (kLoginViewMargin * 2), size.height);
        label.center = CGPointMake(x + centerX, centerY);
        x += w;
        if (CGRectGetMaxY(label.frame) > maxY) maxY = CGRectGetMaxY(label.frame);
    }
    
    /*
     * Set dot frames.
     */
    
    NSArray *dots = self.dots;
    x = kLoginViewMargin;
    for (UIView *dot in dots) {
        frame = CGRectMake(x, maxY + (kLoginViewMargin / 2), kLoginViewDotSize, kLoginViewDotSize);
        dot.frame = frame;
        x += kLoginViewDotSize + (kLoginViewMargin / 4);
    }
    
    /*
     * Set content size.
     */
    
    frame = scrollView.frame;
    id<LoginViewDataSource> dataSource = self.dataSource;
    NSInteger numberOfPages = [dataSource numberOfPagesInLoginView:self];
    scrollView.contentSize = CGSizeMake(numberOfPages * CGRectGetWidth(frame), CGRectGetHeight(frame));
    
    /*
     * Layout buttons.
     */
    
    w = CGRectGetWidth(frame) - (kLoginViewMargin * 2);
    size = [self.facebookButton sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    x = kLoginViewMargin;
    y = CGRectGetHeight(scrollView.frame) - (kLoginViewMargin + size.height);
    h = size.height;
    frame = CGRectMake(x, y, w, h);
    self.facebookButton.frame = frame;
    
}

#pragma mark - Button handler

- (void)handleButtonTouchDown:(UIButton *)button {
    
    /*
     * Send delegate message.
     */
    
    if ([self.delegate respondsToSelector:@selector(loginView:buttonTapped:)]) {
        LoginViewButton identifier;
        if (button == self.facebookButton) identifier = LoginViewButtonFacebook;
        [self.delegate loginView:self buttonTapped:identifier];
    }
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    /*
     * Manipulate image view opacity.
     */
    
    CGFloat x = scrollView.contentOffset.x;
    CGFloat w = CGRectGetWidth(scrollView.bounds);
    CGFloat page = x / w;
    NSArray *imageViews = self.imageViews;
    UIImageView *imageView;
    for (int i=0; i<imageViews.count; i++) {
        imageView = imageViews[i];
        if ((int)ceil(page) == i && i) imageView.alpha = (page + 1) - i;
    }
    
    /*
     * Manipulate dot opacity.
     */
    
    NSArray *dots = self.dots;
    UIView *dot;
    for (int i=0; i<dots.count; i++) {
        dot = dots[i];
        dot.alpha = i == (int)floor(page) ? 1 : kLoginViewDotDefaultAlpha;
    }
    
}

#pragma mark - Dynamic setters

- (void)setDataSource:(id<LoginViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadView];
}

@end
