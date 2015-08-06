//
//  LViewControllerAnimator.m
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LViewControllerAnimator.h"

@implementation LViewControllerAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    /*
     * Add subview.
     */
    
    if (!self.reverse) {
        [containerView addSubview:toViewController.view];
    }
    
    /*
     * Set start criteria.
     */
    
    UIView *moveView;
    moveView = self.reverse ? fromViewController.view : toViewController.view;
    moveView.transform = CGAffineTransformMakeTranslation(0.0f, self.reverse ? 0.0f : (CGRectGetHeight(moveView.frame) / 2));
    moveView.alpha = self.reverse ? 1.0f : 0.0f;
    
    /*
     * Animate.
     */
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                        moveView.transform = CGAffineTransformMakeTranslation(0.0f, self.reverse ? (CGRectGetHeight(moveView.frame) / 2) : 0.0f);
                        moveView.alpha = self.reverse ? 0.0f : 1.0f;
                     }
                     completion:^(BOOL finished) {
                         moveView.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:finished];
                     }];
}

@end
