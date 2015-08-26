//
//  CreatePictureViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePictureViewController.h"
#import "CreatePictureCameraViewController.h"
#import "CreatePictureEditorViewController.h"
#import "CreatePictureViewControllerAnimator.h"

/*
 * @class CreatePictureViewControllerTransitionContext
 */

@interface CreatePictureViewControllerTransitionContext : NSObject <UIViewControllerContextTransitioning>

@property (strong, nonatomic) NSDictionary *viewControllers;
@property (nonatomic) UIModalPresentationStyle presentationStyle;
@property (nonatomic, getter=isAnimated) BOOL animated;
@property (nonatomic, getter=isInteractive) BOOL interactive;
@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete);

- (instancetype)initWithFromViewController:(ListUIViewController *)fromViewController
                          toViewController:(ListUIViewController *)toViewController;

@end

@implementation CreatePictureViewControllerTransitionContext

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
 * @class CreatePictureViewController
 */

@interface CreatePictureViewController ()

@property (strong, nonatomic) CreatePictureCameraViewController *cameraViewController;
@property (strong, nonatomic) CreatePictureEditorViewController *editorViewController;

@end

@implementation CreatePictureViewController

- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session {
    if (self = [super init]) {
        
        /*
         * Create camera view controller.
         */
        
        self.cameraViewController = [[CreatePictureCameraViewController alloc] initWithPicture:picture];
        
        /*
         * Create editor view controller.
         */
        
        self.editorViewController = [[CreatePictureEditorViewController alloc] initWithPicture:picture session:session];
        self.definesPresentationContext = YES;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Start at camera.
     */
    
    [self transition:CreatePictureViewControllerActionCamera animated:NO];
    
}

- (void)transition:(CreatePictureViewControllerAction)action animated:(BOOL)animated {
    
    /*
     * Set from view controller.
     */
    
    ListUIViewController *fromViewController = self.childViewControllers.count ? self.childViewControllers[0] : nil;
    
    /*
     * Set to view controllers
     * based on action.
     */
    
    ListUIViewController *toViewController;
    switch (action) {
        case CreatePictureViewControllerActionEdit: {
            toViewController = self.editorViewController;
            break;
        }
        case CreatePictureViewControllerActionCamera: {
            toViewController = self.cameraViewController;
            break;
        }
    }
    
    /*
     * Return if previous == next
     */
    
    if (toViewController == fromViewController || !self.isViewLoaded) {
        return;
    }
    
    /*
     * Set up destination view.
     */
    
    UIView *toView = toViewController.view;
    toView.translatesAutoresizingMaskIntoConstraints = YES;
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame = self.view.bounds;
    
    /*
     * Send message to from view controller about departure.
     */
    
    [fromViewController willMoveToParentViewController:nil];
    
    /*
     * Add the new controller.
     */
    
    [self addChildViewController:toViewController];
    
    if (!fromViewController) {
        [self.view addSubview:toView];
        [toViewController didMoveToParentViewController:self];
        return;
    }
    
    /*
     * Handle animator if we want to.
     */
    
    if (animated) {
        id<UIViewControllerAnimatedTransitioning> animator;
        if ([self.delegate respondsToSelector:@selector(createPictureViewController:animationControllerForTransitionFromViewController:toViewController:)]) {
            animator = [self.delegate createPictureViewController:self animationControllerForTransitionFromViewController:toViewController toViewController:fromViewController];
        } else {
            animator = [[CreatePictureViewControllerAnimator alloc] init];
        }
        CreatePictureViewControllerTransitionContext *context = [[CreatePictureViewControllerTransitionContext alloc] initWithFromViewController:fromViewController toViewController:toViewController];
        context.completionBlock = ^(BOOL didComplete) {
            [fromViewController removeFromParentViewController];
            [toViewController didMoveToParentViewController:self];
            if ([animator respondsToSelector:@selector(animationEnded:)]) {
                [animator animationEnded:didComplete];
            }
        };
        [animator animateTransition:context];
        return;
    }
    
    /*
     * Otherwise, just add to view.
     */
    
    [self.view addSubview:toView];
    [fromViewController.view removeFromSuperview];
    [fromViewController removeFromParentViewController];
    [toViewController didMoveToParentViewController:self];
    
}

- (BOOL)prefersStatusBarHidden {
    
    /*
     * Hide status bar.
     */
    
    return YES;
    
}

@end
