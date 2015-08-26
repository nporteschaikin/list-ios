//
//  ListUILocationViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <objc/runtime.h>
#import "ListUILocationViewController.h"
#import "UIColor+ListUI.h"

@interface ListUILocationViewController ()

@property (strong, nonatomic) ListUIViewController *viewController;
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) ListUILocationBar *locationBar;

@end

@implementation ListUILocationViewController

- (instancetype)initWithViewController:(ListUIViewController *)viewController {
    if (self = [super init]) {
        self.viewController = viewController;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    /*
     * Add container bar to view.
     */
    
    [self.view addSubview:self.containerView];
    
    /*
     * Add location bar to view.
     */
    
    [self.view addSubview:self.locationBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Transition to view controller.
     */
    
    [self transitionToViewController:self.viewController];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    /*
     * Set background based on current item.
     */
    
    ListUIViewController *viewController = self.viewController;
    ListUILocationBarItem *item = viewController.locationBarItem;
    self.view.backgroundColor = item.barTintColor;
    
    /*
     * Lay out location bar.
     */
    
    x = 0;
    y = self.topLayoutGuide.length;
    w = CGRectGetWidth(self.view.bounds);
    size = [self.locationBar sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    h = size.height;
    self.locationBar.frame = CGRectMake(x, y, w, h);
    
    /*
     * Lay out container view.
     */
    
    x = 0.0f;
    y = y + h;
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds) - y;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Private methods

- (void)transitionToViewController:(ListUIViewController *)toViewController {
    
    /*
     * Determine previous controller.
     */
    
    ListUIViewController *fromViewController = ([self.childViewControllers count] > 0 ? self.childViewControllers[0] : nil);
    
    /*
     * Return if previous == next or view isn't loaded.
     */
    
    if (toViewController == fromViewController || !self.isViewLoaded) {
        return;
    }
    
    /*
     * Use auto-layout on to view.
     */
    
    UIView *toView = toViewController.view;
    toView.translatesAutoresizingMaskIntoConstraints = YES;
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame = self.containerView.bounds;
    
    /*
     * Send message to from view controller about departure.
     */
    
    [fromViewController willMoveToParentViewController:nil];
    
    /*
     * Add the new controller.
     */
    
    [self addChildViewController:toViewController];
    
    /*
     * Add view with no animation if this is the first.
     */
    
    [self.containerView addSubview:toView];
    [fromViewController.view removeFromSuperview];
    [fromViewController removeFromParentViewController];
    [toViewController didMoveToParentViewController:self];
    
}

#pragma mark - Dynamic getters

- (ListUILocationBar *)locationBar {
    
    /*
     * Set location bar dynamically, because we don't
     * know exactly when we'll first need it.
     */
    
    if (!_locationBar) {
        _locationBar = [[ListUILocationBar alloc] init];
    }
    return _locationBar;
    
}

- (UIView *)containerView {
    
    /*
     * Set container bar dynamically, because we don't
     * know exactly when we'll first need it.
     */
    
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
    
}

#pragma mark - Dynamic setters

- (void)setViewController:(ListUIViewController *)viewController {
    
    /*
     * Transition to view controller.
     */
    
    [self transitionToViewController:viewController];
    
    /*
     * Set view controller.
     */
    
    _viewController = viewController;
    
    /*
     * Set location bar item.
     */
    
    self.locationBar.item = viewController.locationBarItem;
    
}

@end

@implementation UIViewController (ListUILocationViewControllerItem)

- (ListUILocationBarItem *)locationBarItem {
    
    /*
     * Use or create location bar item.
     */
    
    ListUILocationBarItem *locationBarItem = objc_getAssociatedObject(self, @selector(locationBarItem));
    if (!locationBarItem) {
        locationBarItem = [[ListUILocationBarItem alloc] init];
        objc_setAssociatedObject(self, @selector(locationBarItem), locationBarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return locationBarItem;
    
}

@end

