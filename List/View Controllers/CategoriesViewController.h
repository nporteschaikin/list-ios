//
//  CategoriesViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoriesController.h"
#import "Session.h"

@class CategoriesViewController;

@protocol CategoriesViewControllerDelegate <NSObject>

@optional;
- (void)categoriesViewControllerHeaderViewMenuControlTouchDown:(CategoriesViewController *)viewController;

@end

@interface CategoriesViewController : UIViewController

@property (weak, nonatomic) id<CategoriesViewControllerDelegate> delegate;

- (id)initWithCategoriesController:(CategoriesController *)categoriesController
                           session:(Session *)session;

@end
