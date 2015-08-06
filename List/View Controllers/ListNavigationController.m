//
//  ListNavigationController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/4/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListNavigationController.h"
#import "LViewControllerAnimator.h"

@interface ListNavigationController () <UIViewControllerTransitioningDelegate>

@end

@implementation ListNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set transition delegate to self.
     */
    
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    LViewControllerAnimator *animation = [[LViewControllerAnimator alloc] init];
    return animation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    LViewControllerAnimator *animation = [[LViewControllerAnimator alloc] init];
    animation.reverse = YES;
    return animation;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return nil;
}

@end
