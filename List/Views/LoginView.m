//
//  LoginView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/5/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LoginView.h"
#import "UIColor+List.h"
#import "UIButton+List.h"
#import "UIFont+List.h"
#import "LogoView.h"

@interface LoginView () <UIScrollViewDelegate>

@property (strong, nonatomic) UILabel *firstLabel;
@property (strong, nonatomic) UILabel *secondLabel;
@property (strong, nonatomic) UILabel *thirdLabel;
@property (strong, nonatomic) UIImageView *firstImageView;
@property (strong, nonatomic) UIImageView *secondImageView;
@property (strong, nonatomic) UIImageView *thirdImageView;
@property (strong, nonatomic) UIView *dotsView;
@property (strong, nonatomic) UIView *firstDotView;
@property (strong, nonatomic) UIView *secondDotView;
@property (strong, nonatomic) UIView *thirdDotView;
@property (strong, nonatomic) UIView *overlayView;
@property (strong, nonatomic) UIButton *loginWithFacebookButton;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) LogoView *logoView;

@end

@implementation LoginView

static NSString * const LoginViewFirstLabelText = @"List helps you create connections with the people around you.";
static NSString * const LoginViewSecondLabelText = @"Share events, post items for sale, discuss places of interest, and more.";
static NSString * const LoginViewThirdLabelText = @"Interact with people in your area publicly or privately.";
static NSString * const LoginViewFirstImageViewImageFilename = @"loginView1";
static NSString * const LoginViewSecondImageViewImageFilename = @"loginView2";
static NSString * const LoginViewThirdImageViewImageFilename = @"loginView3";
static NSString * const LoginViewImageViewsImagesExtension = @"jpg";
static CGFloat const LoginViewDotViewSize = 10.f;
static CGFloat const LoginViewPadding = 20.f;
static CGFloat const LoginViewLogoViewSize = 50.f;

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    /*
     * Set background color to blue.
     */
    
    self.backgroundColor = [UIColor blackColor];
    
    /*
     * Add subviews.
     */
    
    [self addSubview:self.thirdImageView];
    [self insertSubview:self.secondImageView
           aboveSubview:self.thirdImageView];
    [self insertSubview:self.firstImageView
           aboveSubview:self.secondImageView];
    [self insertSubview:self.overlayView
           aboveSubview:self.firstImageView];
    [self insertSubview:self.scrollView
           aboveSubview:self.overlayView];
    [self insertSubview:self.loginWithFacebookButton
           aboveSubview:self.scrollView];
    [self insertSubview:self.logoView
           aboveSubview:self.scrollView];
    [self insertSubview:self.dotsView
           aboveSubview:self.scrollView];
    [self.dotsView addSubview:self.firstDotView];
    [self.dotsView addSubview:self.secondDotView];
    [self.dotsView addSubview:self.thirdDotView];
    [self.scrollView addSubview:self.firstLabel];
    [self.scrollView addSubview:self.secondLabel];
    [self.scrollView addSubview:self.thirdLabel];
    
}

- (void)loadImagesAnimated:(BOOL)animated
                onComplete:(void(^)(void))onComplete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *firstImageData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:LoginViewFirstImageViewImageFilename withExtension:LoginViewImageViewsImagesExtension]];
        NSData *secondImageData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:LoginViewSecondImageViewImageFilename withExtension:LoginViewImageViewsImagesExtension]];
        NSData *thirdImageData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:LoginViewThirdImageViewImageFilename withExtension:LoginViewImageViewsImagesExtension]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.firstImageView.image = [UIImage imageWithData:firstImageData];
            self.secondImageView.image = [UIImage imageWithData:secondImageData];
            self.thirdImageView.image = [UIImage imageWithData:thirdImageData];
            void (^animationBlock)(void) = ^void(void) {
                [self scrollViewDidScroll:self.scrollView];
            };
            void (^completionBlock)(BOOL) = ^void(BOOL finished) {
                if (onComplete) onComplete();
            };
            if (animated) {
                [UIView animateWithDuration:0.25f
                                 animations:animationBlock
                                 completion:completionBlock];
            } else {
                animationBlock();
                completionBlock(YES);
            }
        });
    });
}

- (void)showForegroundViews:(BOOL)show
                   animated:(BOOL)animated {
    void (^animationBlock)(void) = ^void(void) {
        self.scrollView.alpha = show ? 1.0f : 0.0f;
        self.loginWithFacebookButton.alpha = show ? 1.0f : 0.0f;
        self.logoView.alpha = show ? 1.0f : 0.0f;
        self.dotsView.alpha = show ? 1.0f : 0.0f;
    };
    if (animated) {
        [UIView animateWithDuration:0.25f
                         animations:animationBlock
                         completion:nil];
    } else {
        animationBlock();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = LoginViewPadding;
    y = CGRectGetMinY([UIScreen mainScreen].applicationFrame) + LoginViewPadding;
    w = LoginViewLogoViewSize;
    h = LoginViewLogoViewSize;
    self.logoView.frame = CGRectMake(x, y, w, h);
    
    [self.loginWithFacebookButton sizeToFit];
    x = LoginViewPadding;
    y = CGRectGetHeight(self.bounds) - ( LoginViewPadding + CGRectGetHeight(self.loginWithFacebookButton.frame));
    w = CGRectGetWidth(self.bounds) - (LoginViewPadding * 2);
    h = CGRectGetHeight(self.loginWithFacebookButton.frame);
    self.loginWithFacebookButton.frame = CGRectMake(x, y, w, h);
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.bounds);
    h = CGRectGetHeight(self.bounds);
    self.scrollView.frame = CGRectMake(x, y, w, h);
    self.firstImageView.frame = CGRectMake(x, y, w, h);
    self.secondImageView.frame = CGRectMake(x, y, w, h);
    self.thirdImageView.frame = CGRectMake(x, y, w, h);
    self.overlayView.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout scroll view.
     */
    
    x = LoginViewPadding;
    w = CGRectGetWidth(self.scrollView.bounds) - (LoginViewPadding * 2);
    self.firstLabel.preferredMaxLayoutWidth = w;
    [self.firstLabel sizeToFit];
    h = CGRectGetHeight(self.firstLabel.frame);
    y = CGRectGetHeight(self.scrollView.bounds) / 2;
    self.firstLabel.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetWidth(self.scrollView.bounds) + LoginViewPadding;
    self.secondLabel.preferredMaxLayoutWidth = w;
    [self.secondLabel sizeToFit];
    h = CGRectGetHeight(self.secondLabel.frame);
    self.secondLabel.frame = CGRectMake(x, y, w, h);
    
    x = (CGRectGetWidth(self.scrollView.bounds) * 2) + LoginViewPadding;
    self.thirdLabel.preferredMaxLayoutWidth = w;
    [self.thirdLabel sizeToFit];
    h = CGRectGetHeight(self.thirdLabel.frame);
    self.thirdLabel.frame = CGRectMake(x, y, w, h);
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * 3, CGRectGetHeight(self.scrollView.bounds));
    
    /*
     * Layout dots
     */
    
    x = 0.0f;
    y = 0.0f;
    w = LoginViewDotViewSize;
    h = LoginViewDotViewSize;
    self.firstDotView.frame = CGRectMake(x, y, w, h);
    
    x = x + w + (LoginViewPadding / 4);
    self.secondDotView.frame = CGRectMake(x, y, w, h);
    
    x = x + w + (LoginViewPadding / 4);
    self.thirdDotView.frame = CGRectMake(x, y, w, h);
    
    x = LoginViewPadding;
    y = fmaxf(fmaxf(CGRectGetMaxY(self.firstLabel.frame), CGRectGetMaxY(self.secondLabel.frame)), CGRectGetMaxY(self.thirdLabel.frame)) + LoginViewPadding;;
    w = (LoginViewDotViewSize * 3) + (LoginViewPadding * 2);
    self.dotsView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Dynamic getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.numberOfLines = 0;
        _firstLabel.textColor = [UIColor whiteColor];
        _firstLabel.font = [UIFont list_loginViewLabelFont];
        _firstLabel.text = LoginViewFirstLabelText;
    }
    return _firstLabel;
    
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.numberOfLines = 0;
        _secondLabel.textColor = [UIColor whiteColor];
        _secondLabel.font = [UIFont list_loginViewLabelFont];
        _secondLabel.text = LoginViewSecondLabelText;
    }
    return _secondLabel;
}

- (UILabel *)thirdLabel {
    if (!_thirdLabel) {
        _thirdLabel = [[UILabel alloc] init];
        _thirdLabel.numberOfLines = 0;
        _thirdLabel.textColor = [UIColor whiteColor];
        _thirdLabel.font = [UIFont list_loginViewLabelFont];
        _thirdLabel.text = LoginViewThirdLabelText;
    }
    return _thirdLabel;
}

- (UIImageView *)firstImageView {
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc] init];
        _firstImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _firstImageView;
}

- (UIImageView *)secondImageView {
    if (!_secondImageView) {
        _secondImageView = [[UIImageView alloc] init];
        _secondImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _secondImageView;
}

- (UIImageView *)thirdImageView {
    if (!_thirdImageView) {
        _thirdImageView = [[UIImageView alloc] init];
        _thirdImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _thirdImageView;
}

- (UIView *)dotsView {
    if (!_dotsView) {
        _dotsView = [[UIView alloc] init];
        _dotsView.backgroundColor = [UIColor clearColor];
    }
    return _dotsView;
}

- (UIView *)firstDotView {
    if (!_firstDotView) {
        _firstDotView = [[UIView alloc] init];
        _firstDotView.backgroundColor = [UIColor whiteColor];
        _firstDotView.layer.cornerRadius = LoginViewDotViewSize / 2;
    }
    return _firstDotView;
}

- (UIView *)secondDotView {
    if (!_secondDotView) {
        _secondDotView = [[UIView alloc] init];
        _secondDotView.backgroundColor = [UIColor whiteColor];
        _secondDotView.layer.cornerRadius = LoginViewDotViewSize / 2;
    }
    return _secondDotView;
}

- (UIView *)thirdDotView {
    if (!_thirdDotView) {
        _thirdDotView = [[UIView alloc] init];
        _thirdDotView.backgroundColor = [UIColor whiteColor];
        _thirdDotView.layer.cornerRadius = LoginViewDotViewSize / 2;
    }
    return _thirdDotView;
}

- (LogoView *)logoView {
    if (!_logoView) {
        _logoView = [[LogoView alloc] init];
        _logoView.lineColor = [UIColor whiteColor];
    }
    return _logoView;
}

- (UIView *)overlayView {
    if (!_overlayView) {
        _overlayView = [[UIView alloc] init];
        _overlayView.backgroundColor = [UIColor blackColor];
        _overlayView.alpha = 0.5f;
    }
    return _overlayView;
}

- (UIButton *)loginWithFacebookButton {
    if (!_loginWithFacebookButton) {
        _loginWithFacebookButton = [UIButton list_buttonWithSize:UIButtonListSizeLarge
                                                             style:UIButtonListStyleWhite];
        [_loginWithFacebookButton setTitle:@"Sign in with Facebook"
                                  forState:UIControlStateNormal];
    }
    return _loginWithFacebookButton;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    CGFloat w = CGRectGetWidth(self.scrollView.bounds);
    CGFloat page = x / w;
    if (page < 1) {
        self.firstImageView.alpha = 1 - page;
        self.firstDotView.alpha = 1.0f;
        self.secondDotView.alpha = 0.5f;
        self.thirdDotView.alpha = 0.5f;
    } else if (page < 2) {
        self.secondImageView.alpha = 2 - page;
        self.firstDotView.alpha = 0.5f;
        self.secondDotView.alpha = 1.0f;
        self.thirdDotView.alpha = 0.5f;
    } else {
        self.firstDotView.alpha = 0.5f;
        self.secondDotView.alpha = 0.5f;
        self.thirdDotView.alpha = 1.0f;
    }
}

@end
