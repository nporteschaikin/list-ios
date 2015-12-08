//
//  ZoomAnimator.m
//  List
//
//  Created by Noah Portes Chaikin on 12/7/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ZoomAnimator.h"

#pragma mark - ZoomTransitioningDelegate

@implementation ZoomTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    ZoomAnimator *animator = [[ZoomAnimator alloc] init];
    CGRect startFrame = self.startFrame;
    animator.startFrame = startFrame;
    animator.reverse = NO;
    return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    ZoomAnimator *animator = [[ZoomAnimator alloc] init];
    CGRect startFrame = self.startFrame;
    animator.startFrame = startFrame;
    animator.reverse = YES;
    return animator;
}

@end

#pragma mark - ZoomAnimator

@implementation ZoomAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    /*
     * Get components from contenxt.
     */
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    UIView *containerView = [transitionContext containerView];
    
    /*
     * Build snapshot.
     */
    
    BOOL isReverse = self.isReverse;
    UIViewController *snapshotViewController;
    UIView *snapshotView;
    UIView *snapshotFromView;
    CGRect snapshotMaxFrame;
    CGRect snapshotStartFrame;
    CGRect snapshotEndFrame;
    CGFloat snapshotStartAlpha;
    CGFloat snapshotEndAlpha;
    if (isReverse) {
        snapshotViewController = fromViewController;
        snapshotStartFrame = fromView.frame;
        snapshotEndFrame = self.startFrame;
        snapshotStartAlpha = 1.0f;
        snapshotEndAlpha = 0.0f;
    } else {
        snapshotViewController = toViewController;
        snapshotStartFrame = self.startFrame;
        snapshotEndFrame = toView.frame;
        snapshotStartAlpha = 0.0f;
        snapshotEndAlpha = 1.0f;
    }
    snapshotFromView = snapshotViewController.view;
    snapshotMaxFrame = snapshotFromView.frame;
    snapshotView = [snapshotFromView resizableSnapshotViewFromRect:snapshotMaxFrame afterScreenUpdates:YES withCapInsets:UIEdgeInsetsZero];
    snapshotView.frame = snapshotStartFrame;
    snapshotView.alpha = snapshotStartAlpha;
    
    /*
     * Animate.
     */
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [containerView addSubview:snapshotView];
    if (isReverse) {
        [fromView removeFromSuperview];
    }
    [UIView animateWithDuration:duration animations:^{
        snapshotView.frame = snapshotEndFrame;
        snapshotView.alpha = snapshotEndAlpha;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
        if (finished) {
            if (!isReverse) {
                [containerView addSubview:toView];
            }
            [snapshotView removeFromSuperview];
        }
    }];
    
}

@end