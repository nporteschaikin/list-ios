//
//  LocationHeaderView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/30/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationHeaderView.h"
#import "UIColor+List.h"
#import "UIFont+List.h"
#import "UIImage+List.h"

@interface LocationHeaderView ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *controls;
@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) UIView *titleRadarView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *titleImageView;
@property (nonatomic) BOOL titleViewIsAnimating;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation LocationHeaderView

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set selected index to zero.
         */
        
        self.selectedIndex = 0;
        
        /*
         * Load data for the first time.
         */
        
        [self reloadData];
        
        /*
         * Create controls array.
         */
        
        self.controls = [NSMutableArray array];
        
        /*
         * Add scroll view.
         */
        
        [self addSubview:self.scrollView];
        [self.titleView addSubview:self.titleLabel];
        [self.titleView addSubview:self.titleRadarView];
        [self.titleView insertSubview:self.titleImageView
                         aboveSubview:self.titleRadarView];
        [self.scrollView addSubview:self.titleView];
        [self.layer addSublayer:self.gradientLayer];
        
    }
    return self;
}

- (void)reloadData {
    
    /*
     * Reload title, then controls.
     */
    
    [self reloadTitle];
    [self reloadControls];
    
}

- (void)reloadTitle {
    
    /*
     * Set title label
     */
    
    self.titleLabel.text = [self.dataSource locationHeaderViewTitle:self];
    
    /*
     * Layout
     */
    
    [self layoutTitleView];
    [self layoutScrollView];
    
}

- (void)reloadControls {
    
    /*
     * Remove all existing controls from view.
     */
    
    for (UIButton *button in self.controls) {
        [button removeFromSuperview];
    }
    [self.controls removeAllObjects];
    
    /*
     * Create new views for each control specified in data source.
     */
    
    NSInteger count = [self.dataSource numberOfControlsInLocationHeaderView:self];
    NSString *title;
    UIButton *button;
    for (NSInteger i=0; i<count; i++) {
        
        /*
         * Create button
         */
        
        title = [self.dataSource locationHeaderView:self controlTitleAtIndex:i];
        button = [[UIButton alloc] init];
        button.titleLabel.font = [UIFont list_headerViewFont];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor list_lightBlueColorAlpha:0.75] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handleButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [button sizeToFit];
        
        /*
         * Select if first index.
         */
        
        if (i == 0) {
            button.selected = YES;
        }
        
        /*
         * Add to scroll view.
         */
        
        [self.scrollView addSubview:button];
        
        /*
         * Add to buttons array.
         */
        
        [self.controls addObject:button];
        
    }
    
    [self layoutScrollView];
    
}

- (void)layoutTitleView {
    [self.titleLabel sizeToFit];
    
    CGFloat x, y, w, h;
    x = CGRectGetMaxX(self.titleRadarView.frame) + (self.titleLabel.text ? 3.0f : 0.0f);
    y = 0.0f;
    w = self.titleLabel.text ? CGRectGetWidth(self.titleLabel.frame) : 0.0f;
    h = self.titleLabel.font.lineHeight;
    self.titleLabel.frame = CGRectMake(x, y, w, h);
    
    x = 0.0f;
    y = CGRectGetMidY(self.titleLabel.frame) - (CGRectGetHeight(self.titleRadarView.frame) / 2);
    w = CGRectGetWidth(self.titleRadarView.frame);
    h = CGRectGetHeight(self.titleRadarView.frame);
    self.titleRadarView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMidX(self.titleRadarView.frame) - (CGRectGetWidth(self.titleImageView.frame) / 2);
    y = CGRectGetMidY(self.titleRadarView.frame) - (CGRectGetHeight(self.titleImageView.frame) / 2);
    w = CGRectGetWidth(self.titleImageView.frame);
    h = CGRectGetHeight(self.titleImageView.frame);
    self.titleImageView.frame = CGRectMake(x, y, w, h);
    
    x = self.xMargin;
    y = CGRectGetMidY(self.bounds) - (self.titleLabel.font.lineHeight / 2);
    w = CGRectGetMaxX(self.titleLabel.frame);
    h = CGRectGetHeight(self.titleLabel.frame);
    self.titleView.frame = CGRectMake(x, y, w, h);
}

- (void)layoutScrollView {
    CGFloat x, y, w, h;
    UIButton *control;
    x = CGRectGetMaxX(self.titleView.frame) + self.xMargin;
    y = 0.0f;
    w = 0.0f;
    h = 0.0f;
    for (NSInteger i=0; i<self.controls.count; i++) {
        control = self.controls[i];
        w = CGRectGetWidth(control.frame);
        h = CGRectGetHeight(control.frame);
        y = CGRectGetMidY(self.bounds) - (CGRectGetHeight(control.frame) / 2);
        control.frame = CGRectMake(x, y, w, h);
        x += w + self.xMargin;
    }
    self.scrollView.contentSize = CGSizeMake(x, CGRectGetHeight(self.bounds));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     * Frame scroll view.
     */
    
    CGFloat x, y, w, h;
    x = self.iconControlPosition == HeaderViewIconControlPositionLeft ? CGRectGetMaxX(self.iconControl.frame)
        : 0.0f;
    w = CGRectGetWidth(self.bounds) - CGRectGetWidth(self.iconControl.frame) - self.xMargin;
    y = 0.0f;
    h = CGRectGetHeight(self.bounds);
    self.scrollView.frame = CGRectMake(x, y, w, h);
    
    /*
     * Frame gradient view.
     */
    
    w = self.xMargin;
    x = self.iconControlPosition == HeaderViewIconControlPositionLeft ? CGRectGetMaxX(self.iconControl.frame)
        : (CGRectGetMaxX(self.scrollView.frame) - self.xMargin);
    self.gradientLayer.frame = CGRectMake(x, y, w, h);
    
    /*
     * Layout views.
     */
    
    [self layoutScrollView];
    [self layoutTitleView];
    
}

- (void)animateTitleView:(BOOL)animate {
    if (animate && !self.titleViewIsAnimating) {
        self.titleViewIsAnimating = YES;
        [self.titleRadarView.layer removeAllAnimations];
        [self.titleImageView.layer removeAllAnimations];
        self.titleRadarView.alpha = 0.5f;
        [UIView animateKeyframesWithDuration:1.0f
                                       delay:0.0f
                                     options:UIViewKeyframeAnimationOptionRepeat
                                  animations:^{
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0
                                                              relativeDuration:0.5
                                                                    animations:^{
                                                                        self.titleRadarView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.25f, 1.25f);
                                                                        self.titleRadarView.alpha = 1.0f;
                                                                    }];
                                      [UIView addKeyframeWithRelativeStartTime:0.5
                                                              relativeDuration:0.5
                                                                    animations:^{
                                                                        self.titleRadarView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
                                                                        self.titleRadarView.alpha = 0.5f;
                                                                    }];
                                      
                                  } completion:nil];
        [UIView animateWithDuration:0.25f animations:^{
            self.titleImageView.alpha = 0.0f;
        }];
        
    } else if (!animate && self.titleViewIsAnimating) {
        self.titleViewIsAnimating = NO;
        [self.titleRadarView.layer removeAllAnimations];
        [self.titleImageView.layer removeAllAnimations];
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.titleRadarView.alpha = 0.0f;
                             self.titleRadarView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
                             self.titleImageView.alpha = 1.0f;
                         }];
    }
}

- (void)selectControlAtIndex:(NSInteger)index {
    NSArray *controls = self.controls;
    UIButton *button = controls[index];
    UIButton *b;
    for (NSInteger i=0; i<controls.count; i++) {
        b = controls[i];
        if (b == button) {
            b.selected = YES;
            self.selectedIndex = index;
            if ([self.delegate respondsToSelector:@selector(locationHeaderView:didSelectControlAtIndex:)]) {
                [self.delegate locationHeaderView:self didSelectControlAtIndex:i];
            }
        } else {
            b.selected = NO;
        }
    }
}

#pragma mark - Button handlers

- (void)handleButtonTouchDown:(UIButton *)button {
    NSInteger index = [self.controls indexOfObject:button];
    [self selectControlAtIndex:index];
}

#pragma mark - Dynamic getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
    }
    return _titleView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont list_headerViewFont];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIView *)titleRadarView {
    if (!_titleRadarView) {
        CGFloat size = [UIFont list_headerViewFont].pointSize;
        _titleRadarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
        _titleRadarView.backgroundColor = [UIColor clearColor];
        _titleRadarView.layer.borderColor = [UIColor whiteColor].CGColor;
        _titleRadarView.layer.borderWidth = 1.0f;
        _titleRadarView.layer.cornerRadius = size / 2;
    }
    return _titleRadarView;
}

- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        CGFloat size = [UIFont list_headerViewFont].pointSize;
        _titleImageView = [[UIImageView alloc] initWithImage:[UIImage list_locationIconImageColor:[UIColor whiteColor] size:size]];
        [_titleImageView sizeToFit];
    }
    return _titleImageView;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.startPoint = CGPointMake(1, 0);
        _gradientLayer.endPoint = CGPointZero;
        _gradientLayer.locations = @[@0, @0.5, @1];
        _gradientLayer.colors = @[(id)[UIColor list_blueColorAlpha:1].CGColor,
                                  (id)[UIColor list_blueColorAlpha:0.5].CGColor,
                                  (id)[UIColor list_blueColorAlpha:0].CGColor];
    }
    return _gradientLayer;
}




#pragma mark - Dynamic setters

- (void)setIconControlPosition:(HeaderViewIconControlPosition)iconControlPosition {
    [super setIconControlPosition:iconControlPosition];
    if (iconControlPosition == HeaderViewIconControlPositionLeft) {
        self.gradientLayer.startPoint = CGPointZero;
        self.gradientLayer.endPoint = CGPointMake(1, 0);
    } else {
        self.gradientLayer.startPoint = CGPointMake(1, 0);
        self.gradientLayer.endPoint = CGPointZero;
    }
}

@end
