//
//  ZoomAnimator.h
//  List
//
//  Created by Noah Portes Chaikin on 12/7/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"

#pragma mark - ZoomAnimatorTransitioningDelegate

@interface ZoomAnimatorTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic) CGRect startFrame;

@end

#pragma mark - ZoomAnimator

@interface ZoomAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) CGRect startFrame;
@property (nonatomic, getter=isReverse) BOOL reverse;

@end
