//
//  MainViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MainViewController.h"
#import "LocationController.h"
#import "CategoriesController.h"
#import "PostsController.h"
#import "LLocationManager.h"
#import "HomeLocationViewController.h"
#import "MenuViewController.h"
#import "ActivityIndicatorView.h"
#import "Constants.h"
#import "UIColor+List.h"

@interface MainViewController () <LLocationManagerListener>

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) LocationController *locationController;
@property (strong, nonatomic) HomeLocationViewController *locationViewController;
@property (strong, nonatomic) MenuViewController *menuViewController;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;

@end

@implementation MainViewController

- (id)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set background.
     */
    
    self.view.backgroundColor = [UIColor list_blueColorAlpha:1];
    
    /*
     * Create menu view controller.
     */
    
    self.menuViewController = [[MenuViewController alloc] initWithSession:self.session];
    self.menuViewController.view.hidden = YES;
    self.menuViewController.view.alpha = 0.0f;
    self.menuViewController.view.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    [self addChildViewController:self.menuViewController];
    [self.view addSubview:self.menuViewController.view];
    [self.menuViewController didMoveToParentViewController:self];
    
    /*
     * Listen to close control
     */
    
    LIconControl *closeControl = self.menuViewController.closeControl;
    [closeControl addTarget:self
                     action:@selector(handleMenuViewControllerCloseControlTouchDown:)
           forControlEvents:UIControlEventTouchDown];
    
    /*
     * Add activity indicator view.
     */
    
    [self.view addSubview:self.activityIndicatorView];
    
    /*
     * Listen to location manager.
     */
    
    LLocationManager *locationManager = [LLocationManager sharedManager];
    [locationManager addListener:self];
    
    /*
     * Create location controller.
     */
    
    self.locationController = [[LocationController alloc] initWithLocation:locationManager.location];
    
    /*
     * If we have a location, present location view controller.
     * Otherwise, start animating.
     */
    
    if (locationManager.location) {
        [self createLocationViewController];
    } else {
        self.activityIndicatorView.hidden = NO;
    }
    
}

- (void)createLocationViewController {
    
    /*
     * Create location view controller.
     */
    
    CategoriesController *categoriesController = [[CategoriesController alloc] init];
    PostsController *postsController = [[PostsController alloc] initWithSession:self.session];
    self.locationViewController = [[HomeLocationViewController alloc] initWithLocationController:self.locationController
                                                                            categoriesController:categoriesController
                                                                                 postsController:postsController
                                                                                         session:self.session];
    
    /*
     * Customize header view.
     */
    
    LocationHeaderView *locationHeaderView = self.locationViewController.headerView;
    locationHeaderView.iconControlPosition = HeaderViewIconControlPositionLeft;
    LIconControl *iconControl = locationHeaderView.iconControl;
    iconControl.style = LIconControlStyleMenu;
    [iconControl addTarget:self
                    action:@selector(handleLocationViewControllerHeaderViewIconControlTouchDown:)
          forControlEvents:UIControlEventTouchDown];
    
    /*
     * Add to this controller.
     */
    
    [self.view addSubview:self.locationViewController.view];
    [self addChildViewController:self.locationViewController];
    [self.locationViewController didMoveToParentViewController:self];
}

- (void)openMenuView:(BOOL)open
            animated:(BOOL)animated {
    MenuViewController *menuViewController = self.menuViewController;
    LocationViewController *locationViewController = self.locationViewController;
    UIView *menuView = menuViewController.view;
    UIView *categoriesView = locationViewController.view;
    
    if (open) {
        menuView.hidden = NO;
        [menuViewController viewWillAppear:YES];
        [locationViewController viewWillDisappear:YES];
    } else {
        [menuViewController viewWillDisappear:YES];
        [locationViewController viewWillAppear:YES];
    }
    
    void (^animationBlock)(void) = ^void(void) {
        if (open) {
            categoriesView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
            categoriesView.alpha = 0.0f;
            menuView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            menuView.alpha = 1.0f;
        } else {
            categoriesView.transform = CGAffineTransformMakeTranslation(0, 0);
            categoriesView.alpha = 1.0f;
            menuView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
            menuView.alpha = 0.0f;
        }
    };
    void (^completionBlock)(BOOL) = ^void(BOOL finished) {
        if (!open) menuView.hidden = YES;
    };
    if (animated) {
        [UIView animateWithDuration:0.25f
                         animations:animationBlock
                         completion:completionBlock];
    } else {
        completionBlock(YES);
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = (CGRectGetWidth(self.view.bounds) - ActivityIndicatorViewDefaultSize) / 2;
    y = (CGRectGetHeight(self.view.bounds) - ActivityIndicatorViewDefaultSize) / 2;
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);

}

- (void)dealloc {
    LLocationManager *locationManager = [LLocationManager sharedManager];
    [locationManager removeListener:self];
}

#pragma mark - LLocationManagerListener

- (void)locationManager:(LLocationManager *)manager event:(LLocationManagerEvent)event {
    switch (event) {
        case LLocationManagerEventUpdateLocation: {
            
            /*
             * Set location.
             */
            
            self.locationController.location = manager.location;
            
            /*
             * If posts controller doesn't exist, create it.
             */
            
            if (!self.locationViewController) {
                [self createLocationViewController];
            }
            
        }
        default: {
            break;
        }
    }
}

#pragma mark - Location view controller button handler.

- (void)handleLocationViewControllerHeaderViewIconControlTouchDown:(LIconControl *)control {
    
    /*
     * Show menu.
     */
    
    [self openMenuView:YES animated:YES];
    
}

- (void)handleMenuViewControllerCloseControlTouchDown:(LIconControl *)control {
    
    /*
     * Hide menu.
     */
    
    [self openMenuView:NO animated:YES];
    
}

#pragma mark - Dynamic getters

- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleWhite];
        _activityIndicatorView.hidden = YES;
    }
    return _activityIndicatorView;
}

@end
