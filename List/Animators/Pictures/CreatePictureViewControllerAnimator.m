//
//  CreatePictureViewControllerAnimator.m
//  List
//
//  Created by Noah Portes Chaikin on 8/19/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CreatePictureViewControllerAnimator.h"

@implementation CreatePictureViewControllerAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = toViewController.view;
    UIView *fromView = fromViewController.view;
    UIView *containerView = [transitionContext containerView];
    
    if (!self.reverse) {
        [containerView addSubview:toView];
    }
    
    /*
     * Create states.
     */
    
    void (^animationBlock)(void);
    if (self.reverse) {
        fromView.alpha = 1.0f;
        animationBlock = ^void(void) {
            toView.alpha = 1.0f;
            fromView.alpha = 0.0f;
        };
        
    } else {
        
        toView.alpha = 0.0f;
        fromView.alpha = 1.0f;
        animationBlock = ^void(void) {
            toView.alpha = 1.0f;
        };
    }
    
    /*
     * Animate.
     */
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:animationBlock
                     completion:^(BOOL finished) {
                         toView.transform = CGAffineTransformIdentity;
                         [transitionContext completeTransition:finished];
                     }];
}

@end
