//
//  LocationViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/29/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationController.h"
#import "CategoriesController.h"
#import "PostsController.h"
#import "Session.h"
#import "LocationHeaderView.h"

@interface LocationViewController : UIViewController

@property (strong, nonatomic, readonly) LocationController *locationController;
@property (strong, nonatomic, readonly) CategoriesController *categoriesController;
@property (strong, nonatomic, readonly) PostsController *postsController;
@property (strong, nonatomic, readonly) LocationHeaderView *headerView;
@property (strong, nonatomic, readonly) Session *session;

- (id)initWithLocationController:(LocationController *)locationController
            categoriesController:(CategoriesController *)categoriesController
                 postsController:(PostsController *)postsController
                         session:(Session *)session NS_DESIGNATED_INITIALIZER;

@end
