//
//  MenuViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"

@class MenuViewController;

@protocol MenuViewControllerDelegate <NSObject>

@optional;
- (void)menuViewControllerCloseControlTouchDown:(MenuViewController *)viewController;
- (void)menuViewControllerSignOutButtonTouchDown:(MenuViewController *)viewController;

@end

@interface MenuViewController : UIViewController

@property (weak, nonatomic) id<MenuViewControllerDelegate> delegate;

- (instancetype)initWithSession:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
