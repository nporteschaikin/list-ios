//
//  ListUILocationViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/15/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIViewController.h"
#import "ListUILocationBar.h"

@class ListUILocationViewController;

@interface ListUILocationViewController : ListUIViewController

@property (strong, nonatomic, readonly) ListUIViewController *viewController;
@property (strong, nonatomic, readonly) ListUILocationBar *locationBar;

- (instancetype)initWithViewController:(ListUIViewController *)rootViewController NS_DESIGNATED_INITIALIZER;

@end

@interface UIViewController (ListUILocationViewControllerItem)

@property (strong, nonatomic, readonly) ListUILocationBarItem *locationBarItem;

@end
