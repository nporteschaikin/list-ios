//
//  ListUITabBarController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <objc/runtime.h>
#import "ListUITabBarController.h"

/*
 * @class ListUITabBarControllerTransitionContext
 */

@interface ListUITabBarControllerTransitionContext : NSObject <UIViewControllerContextTransitioning>

@property (strong, nonatomic) NSDictionary *viewControllers;
@property (nonatomic) UIModalPresentationStyle presentationStyle;
@property (nonatomic, getter=isAnimated) BOOL animated;
@property (nonatomic, getter=isInteractive) BOOL interactive;
@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete);

- (instancetype)initWithFromViewController:(ListUIViewController *)fromViewController
                          toViewController:(ListUIViewController *)toViewController;

@end

@implementation ListUITabBarControllerTransitionContext

- (instancetype)initWithFromViewController:(ListUIViewController *)fromViewController
                          toViewController:(ListUIViewController *)toViewController {
    if (self = [super init]) {
        self.viewControllers = @{UITransitionContextFromViewControllerKey: fromViewController,
                                 UITransitionContextToViewControllerKey: toViewController};
    }
    return self;
}

- (CGRect)initialFrameForViewController:(UIViewController *)vc {
    UIView *view = self.containerView;
    return view.bounds;
}

- (CGRect)finalFrameForViewController:(UIViewController *)vc {
    UIView *view = self.containerView;
    return view.bounds;
}

- (UIViewController *)viewControllerForKey:(NSString *)key {
    return self.viewControllers[key];
}

- (UIView *)containerView {
    UIViewController *fromViewController = self.viewControllers[UITransitionContextFromViewControllerKey];
    return fromViewController.view.superview;
}

- (void)completeTransition:(BOOL)didComplete {
    if (self.completionBlock) {
        self.completionBlock(didComplete);
    }
}

- (CGAffineTransform)targetTransform { return CGAffineTransformIdentity; }
- (UIView *)viewForKey:(NSString *)key { return nil; }
- (BOOL)transitionWasCancelled { return NO; }
- (void)updateInteractiveTransition:(CGFloat)percentComplete { return; }
- (void)finishInteractiveTransition { return; }
- (void)cancelInteractiveTransition { return; }

@end

/*
 * @class ListUITabBarController
 */

@interface ListUITabBarController ()

@property (strong, nonatomic) ListUIViewController *selectedViewController;
@property (strong, nonatomic) ListUITabBar *tabBar;
@property (strong, nonatomic) UIView *containerView;

@end

@implementation ListUITabBarController

- (void)loadView {
    [super loadView];

    /*
     * Setup parent view.
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     * Add container view to super view.
     */
    
    [self.view addSubview:self.containerView];
    
    /*
     * Add tab bar to superview.
     */
    
    [self.view addSubview:self.tabBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Go to first controller.
     */
    
    self.selectedViewController = (self.selectedViewController ?: self.viewControllers[0]);
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    CGSize size;
    
    /*
     * Lay out tab bar.
     */
    
    x = 0;
    w = CGRectGetWidth(self.view.bounds);
    size = [self.tabBar sizeThatFits:CGSizeMake(w, CGFLOAT_MAX)];
    y = CGRectGetHeight(self.view.bounds) - size.height;
    h = size.height;
    self.tabBar.frame = CGRectMake(x, y, w, h);
    
    /*
     * Lay out container view.
     */
    
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds) - h;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - Private methods

- (void)transitionToChildViewController:(ListUIViewController *)toViewController {
    
    /*
     * Determine previous controller.
     */
    
    ListUIViewController *fromViewController = ([self.childViewControllers count] > 0 ? self.childViewControllers[0] : nil);
    
    /*
     * Return if previous == next
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
    
    if (!fromViewController) {
        [self.containerView addSubview:toView];
        [toViewController didMoveToParentViewController:self];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBarController:animationControllerForTransitionFromViewController:toViewController:)]) {
        
        /*
         * If we have an animator, use it.
         */
        
        id<UIViewControllerAnimatedTransitioning> animator = [self.delegate tabBarController:self animationControllerForTransitionFromViewController:fromViewController toViewController:toViewController];
        ListUITabBarControllerTransitionContext *context = [[ListUITabBarControllerTransitionContext alloc] initWithFromViewController:fromViewController toViewController:toViewController];
        context.completionBlock = ^(BOOL didComplete) {
            [fromViewController.view removeFromSuperview];
            [fromViewController removeFromParentViewController];
            [toViewController didMoveToParentViewController:self];
            if ([animator respondsToSelector:@selector(animationEnded:)]) {
                [animator animationEnded:didComplete];
            }
            self.tabBar.userInteractionEnabled = YES;
        };
        
        self.tabBar.userInteractionEnabled = NO;
        [animator animateTransition:context];
        return;
        
    }
    
    /*
     * Otherwise, just add to view.
     */
    
    [self.containerView addSubview:toView];
    [fromViewController.view removeFromSuperview];
    [fromViewController removeFromParentViewController];
    [toViewController didMoveToParentViewController:self];
    
}

#pragma mark - Dynamic getters

- (ListUITabBar *)tabBar {
    
    /*
     * Set tan bar bar dynamically, because we don't
     * know exactly when we'll first need it.
     */
    
    if (!_tabBar) {
        _tabBar = [[ListUITabBar alloc] init];
        _tabBar.delegate = self;
    }
    return _tabBar;
    
}

- (UIView *)containerView {
    
    /*
     * Set container bar dynamically, because we don't
     * know exactly when we'll first need it.
     */
    
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
    }
    return _containerView;
    
}

#pragma mark - Dynamic setters

- (void)setSelectedViewController:(ListUIViewController *)selectedViewController {
    
    /*
     * Transition to controller.
     */
    
    [self transitionToChildViewController:selectedViewController];
    
    /*
     * Set controller.
     */
    
    _selectedViewController = selectedViewController;
    
    /*
     * Select correct tab bar item.
     */
    
    ListUITabBar *tabBar = self.tabBar;
    tabBar.selectedItem = selectedViewController.listTabBarItem;
    
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    /*
     * Remove all child view controllers.
     */
    
    for (UIViewController *viewController in self.childViewControllers) {
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
        [viewController didMoveToParentViewController:self];
    }
    
    /*
     * Set controllers.
     */
    
    _viewControllers = viewControllers;
    
    /*
     * Create view controller tab bar items.
     */
    
    NSMutableArray *tabBarItems = [NSMutableArray array];
    ListUITabBarItem *tabBarItem;
    for (ListUIViewController *viewController in self.viewControllers) {
        tabBarItem = viewController.listTabBarItem;
        [tabBarItems addObject:tabBarItem];
    }
    
    /*
     * Set to tab bar.
     */
    
    self.tabBar.items = [NSArray arrayWithArray:tabBarItems];
    
    /*
     * Go to first controller.
     */
    
    self.selectedViewController = (self.selectedViewController ?: viewControllers[0]);
    
}

#pragma mark - ListUITabBarDelegate

- (void)tabBar:(ListUITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [tabBar.items indexOfObject:item];
    
    /*
     * Go to controller at item index.
     */
    
    if (self.viewControllers.count > index) {
        ListUIViewController *viewController = self.viewControllers[index];
        self.selectedViewController = viewController;
    }
    
}

@end

@implementation UIViewController (ListUITabBarControllerItem)

- (ListUITabBarItem *)listTabBarItem {
    
    /*
     * Use or create list tab bar item.
     */
    
    ListUITabBarItem *tabBarItem = objc_getAssociatedObject(self, @selector(tabBarItem));
    if (!tabBarItem) {
        tabBarItem = [[ListUITabBarItem alloc] init];
        objc_setAssociatedObject(self, @selector(tabBarItem), tabBarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tabBarItem;
    
}

@end