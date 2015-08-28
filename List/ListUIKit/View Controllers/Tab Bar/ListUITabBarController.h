//
//  ListUITabBarController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIViewController.h"
#import "ListUITabBar.h"

@class ListUITabBarController;

@protocol ListUITabBarControllerDelegate <NSObject>

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(ListUITabBarController *)controller animationControllerForTransitionFromViewController:(ListUIViewController *)fromViewController toViewController:(ListUIViewController *)toViewController;

@end

@interface ListUITabBarController : UIViewController <ListUITabBarDelegate>

@property (weak, nonatomic) id<ListUITabBarControllerDelegate> delegate;
@property (strong, nonatomic) NSArray *viewControllers;
@property (strong, nonatomic, readonly) ListUIViewController *selectedViewController;
@property (strong, nonatomic, readonly) ListUITabBar *tabBar;

@end

@interface UIViewController (ListUITabBarControllerItem)

@property (strong, nonatomic, readonly) ListUITabBarItem *listTabBarItem;

@end