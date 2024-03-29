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
#import "ListConstants.h"

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

@interface CreatePictureViewController () <ListUICameraViewControllerDelegate>

@property (strong, nonatomic) Picture *picture;
@property (strong, nonatomic) CreatePictureCameraViewController *cameraViewController;
@property (strong, nonatomic) CreatePictureEditorViewController *editorViewController;

@end

@implementation CreatePictureViewController

- (instancetype)initWithPicture:(Picture *)picture session:(Session *)session {
    if (self = [super init]) {
        self.picture = picture;
        
        /*
         * Create camera view controller.
         */
        
        self.cameraViewController = [[CreatePictureCameraViewController alloc] initWithPicture:picture];
        self.cameraViewController.delegate = self;
        
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
    
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage listUI_icon:ListUIIconCross size:kUINavigationBarCrossImageSize] style:UIBarButtonItemStyleDone target:self action:@selector(handleRightBarButtonItem:)];
    ListUIViewController *toViewController;
    switch (action) {
        case CreatePictureViewControllerActionEdit: {
            toViewController = self.editorViewController;
            navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage listUI_icon:ListUIIconReturn size:kUINavigationBarDefaultImageSize] style:UIBarButtonItemStyleDone target:self action:@selector(handleLeftBarButtonItem:)];
            break;
        }
        case CreatePictureViewControllerActionCamera: {
            toViewController = self.cameraViewController;
            navigationItem.leftBarButtonItem = nil;
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

#pragma mark - ListUICameraViewControllerDelegate

- (void)cameraViewController:(CreatePictureCameraViewController *)controller didCaptureStillImage:(UIImage *)image {
    
    /*
     * If we have a location, use it.
     */
    
    LocationManager *locationManager = controller.locationManager;
    CLLocation *location = locationManager.location;
    if (locationManager.location) {
        
        /*
         * Create picture.
         */
        
        Picture *picture = self.picture;
        Photo *asset = [[Photo alloc] init];
        asset.image = image;
        picture.asset = asset;
        picture.location = location;
        
        /*
         * Transition to edit action.
         */
        
        [self transition:CreatePictureViewControllerActionEdit animated:YES];
        
    }
    
}

#pragma mark - Bar button handlers

- (void)handleLeftBarButtonItem:(UIBarButtonItem *)item {
    if (!self.childViewControllers.count) return;
    
    UIViewController *controller = self.childViewControllers[0];
    if ([controller isKindOfClass:[CreatePictureEditorViewController class]]) {
        
        /*
         * If on editor, transition back to camera.
         */
        
        [self transition:CreatePictureViewControllerActionCamera animated:YES];
        
    }
    
}

- (void)handleRightBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Close view controller.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
