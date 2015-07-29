//
//  CategoriesHeaderView.m
//  List
//
//  Created by Noah Portes Chaikin on 7/2/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CategoriesHeaderView.h"
#import "UIFont+List.h"
#import "UIColor+List.h"

@interface CategoriesHeaderView ()

@property (strong, nonatomic) CAGradientLayer *leftGradientLayer;
@property (strong, nonatomic) CAGradientLayer *rightGradientLayer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *categoryLabel;
@property (strong, nonatomic) LIconControl *menuControl;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation CategoriesHeaderView

static CGFloat const CategoriesHeaderViewMenuControlSize = 25.f;
static CGFloat const CategoriesHeaderViewMenuControlMarginLeft = 12.0f;
static CGFloat const CategoriesHeaderViewButtonMarginX = 12.0f;
static CGFloat const CategoriesHeaderViewHeight = 50.0f;
static CGFloat const CategoriesHeaderViewButtonDefaultAlpha = 0.5f;
static CGFloat const CategoriesHeaderViewScrollViewInset = CategoriesHeaderViewButtonMarginX;

- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.scrollView];
    [self addSubview:self.menuControl];
    
    [self reloadData];
    
    /*
     * Add background.
     */
    
    self.backgroundColor = [UIColor list_blueColorAlpha:1];
    
    /*
     * Add gradients.
     */
    
    [self.layer addSublayer:self.leftGradientLayer];
    [self.layer addSublayer:self.rightGradientLayer];
    
}

- (void)reloadData {
    
    /*
     * Remove all existing labels from view.
     */
    
    NSArray *subViews = self.scrollView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
    /*
     * Create new views for each label specified in data source.
     */
    
    NSInteger num = [self.dataSource numberOfButtonsInCategoriesHeaderView:self];
    NSString *text;
    UILabel *label;
    UIView *containingView;
    UITapGestureRecognizer *gestureRecognizer;
    CGFloat x, y, w, h;
    for (NSInteger i=0; i<num; i++) {
        
        /*
         * Find text.
         */
        
        text = [self.dataSource categoriesHeaderView:self
                                          textForButtonAtIndex:i];
        label = [[UILabel alloc] init];
        
        /*
         * Style label.
         */
        
        label.text = text;
        label.font = [UIFont list_categoriesHeaderViewFont];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 1;
        [label sizeToFit];
        
        /*
         * Add label to containing view.
         */
        
        containingView = [[UIView alloc] init];
        containingView.alpha = CategoriesHeaderViewButtonDefaultAlpha;
        x = 0.0f;
        y = 0.0f;
        w = CGRectGetWidth(label.bounds);
        h = CategoriesHeaderViewHeight;
        containingView.frame = CGRectMake(x, y, w, h);
        [containingView addSubview:label];
        label.frame = CGRectMake(0.0f,
                                 (CategoriesHeaderViewHeight - CGRectGetHeight(label.frame)) / 2,
                                 CGRectGetWidth(label.frame),
                                 CGRectGetHeight(label.frame));
        
        /*
         * Add gesture recognizer to container view.
         */
        
        gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handleButtonTapGestureRecognizer:)];
        [containingView addGestureRecognizer:gestureRecognizer];
        
        /*
         * Add containing view.
         */
        
        [self.scrollView addSubview:containingView];
    }
    
    [self layoutScrollView];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x, y, w, h;
    x = CategoriesHeaderViewMenuControlMarginLeft;
    y = CGRectGetMidY(self.bounds) - (CategoriesHeaderViewMenuControlSize / 2);
    w = CategoriesHeaderViewMenuControlSize;
    h = CategoriesHeaderViewMenuControlSize;
    self.menuControl.frame = CGRectMake(x, y, w, h);
    
    x = x + w;
    y = CGRectGetMinY(self.bounds);
    w = CGRectGetWidth(self.bounds) - x;
    h = CGRectGetHeight(self.bounds);
    self.scrollView.frame = CGRectMake(x, y, w, h);
    
    w = CategoriesHeaderViewScrollViewInset;
    self.leftGradientLayer.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetWidth(self.bounds) - w;
    self.rightGradientLayer.frame = CGRectMake(x, y, w, h);
}

- (void)layoutScrollView {
    NSArray *subViews = self.scrollView.subviews;
    CGFloat x, y, w, h;
    UIView *view;
    x = 0.0f;
    y = 0.0f;
    w = 0.0f;
    h = 0.0f;
    for (NSInteger i=0; i<subViews.count; i++) {
        view = subViews[i];
        w = CGRectGetWidth(view.frame);
        h = CGRectGetHeight(view.frame);
        view.frame = CGRectMake(x, y, w, h);
        x += w + CategoriesHeaderViewButtonMarginX;
    }
    self.scrollView.contentSize = CGSizeMake(x, CategoriesHeaderViewHeight);
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(size.width, CategoriesHeaderViewHeight);
}

- (void)selectButtonAtIndex:(NSInteger)index {
    NSArray *subViews = self.scrollView.subviews;
    UIView *selectingView = [subViews objectAtIndex:index];
    
    if (self.selectedIndex < subViews.count) {
        /*
         * Fade out selected view.
         */
        
        UIView *selectedView = [subViews objectAtIndex:self.selectedIndex];
        selectedView.alpha = 1.0f;
        [UIView animateWithDuration:0.25f
                         animations:^{
                             selectedView.alpha = CategoriesHeaderViewButtonDefaultAlpha;
                         }];
    }
    
    self.selectedIndex = index;
    [UIView animateWithDuration:0.25f
                     animations:^{
                         selectingView.alpha = 1.0f;
                     } completion:nil];
}

- (void)handleButtonTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(categoriesHeaderView:buttonTappedAtIndex:)]) {
        UIView *view = gestureRecognizer.view;
        NSArray *subViews = self.scrollView.subviews;
        NSInteger i = [subViews indexOfObject:view];
        [self.delegate categoriesHeaderView:self
                        buttonTappedAtIndex:i];
    }
}

#pragma mark - Dynamic getters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentInset = UIEdgeInsetsMake(0, CategoriesHeaderViewScrollViewInset, 0, CategoriesHeaderViewScrollViewInset);
    }
    return _scrollView;
}

- (LIconControl *)menuControl {
    if (!_menuControl) {
        _menuControl = [[LIconControl alloc] initWithStyle:LIconControlStyleMenu];
        _menuControl.lineColor = [UIColor whiteColor];
    }
    return _menuControl;
}

- (CAGradientLayer *)leftGradientLayer {
    if (!_leftGradientLayer) {
        _leftGradientLayer = [CAGradientLayer layer];
        _leftGradientLayer.locations = @[@0, @0.5, @1];
        _leftGradientLayer.startPoint = CGPointZero;
        _leftGradientLayer.endPoint = CGPointMake(1, 0);
        _leftGradientLayer.colors = @[(id)[UIColor list_blueColorAlpha:1].CGColor,
                                      (id)[UIColor list_blueColorAlpha:0.5].CGColor,
                                      (id)[UIColor list_blueColorAlpha:0].CGColor];
    }
    return _leftGradientLayer;
}

- (CAGradientLayer *)rightGradientLayer {
    if (!_rightGradientLayer) {
        _rightGradientLayer = [CAGradientLayer layer];
        _rightGradientLayer.locations = @[@0, @0.5, @1];
        _rightGradientLayer.startPoint = CGPointMake(1, 0);
        _rightGradientLayer.endPoint = CGPointZero;
        _rightGradientLayer.colors = @[(id)[UIColor list_blueColorAlpha:1].CGColor,
                                       (id)[UIColor list_blueColorAlpha:0.5].CGColor,
                                       (id)[UIColor list_blueColorAlpha:0].CGColor];
    }
    return _rightGradientLayer;
}

@end
