//
//  LocationViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/29/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationDataSource.h"
#import "CategoriesController.h"
#import "PostsController.h"
#import "PostsTableViewController.h"
#import "ActivityIndicatorView.h"
#import "Constants.h"

@interface LocationViewController () <LocationControllerDelegate, CategoriesControllerDelegate, LocationHeaderViewDelegate>

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) LocationDataSource *dataSource;
@property (strong, nonatomic) LocationController *locationController;
@property (strong, nonatomic) CategoriesController *categoriesController;
@property (strong, nonatomic) PostsController *postsController;
@property (strong, nonatomic) PostsTableViewController *postsTableViewController;
@property (strong, nonatomic) LocationHeaderView *headerView;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;

@end

@implementation LocationViewController

- (id)initWithLocationController:(LocationController *)locationController
            categoriesController:(CategoriesController *)categoriesController
                 postsController:(PostsController *)postsController
                         session:(Session *)session {
    if (self = [super init]) {
        self.session = session;
        self.locationController = locationController;
        self.locationController.delegate = self;
        self.categoriesController = categoriesController;
        self.categoriesController.delegate = self;
        self.postsController = postsController;
        self.dataSource = [[LocationDataSource alloc] initWithLocationController:locationController
                                                            categoriesController:categoriesController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * If location controller has location, set placemark and request categories..
     */
    
    if (self.locationController.location) {
        [self.locationController requestPlacemark];
    }
    
    /*
     * Set initial location and radius.
     */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat radius = [[userDefaults objectForKey:DiscoveryRadiusInMilesUserDefaultsKey] floatValue];
    self.postsController.location = self.locationController.location;
    self.postsController.radius = radius;
    
    /*
     * Add subviews
     */
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.activityIndicatorView];
    
    /*
     * Add data source to header.
     */
    
    self.headerView.dataSource = self.dataSource;
    self.headerView.delegate = self;
    
    /*
     * Request categories.
     */
    
    [self.categoriesController requestCategories];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    /*
     * Update radius if necessary.
     */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat radius = [[userDefaults objectForKey:DiscoveryRadiusInMilesUserDefaultsKey] floatValue];
    if (radius != self.postsController.radius) {
        self.postsController.radius = radius;
        [self.postsController requestPosts];
    }
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = 0.0f;
    y = CGRectGetMinY([UIScreen mainScreen].applicationFrame);
    w = CGRectGetWidth(self.view.bounds);
    h = [self.headerView sizeThatFits:CGSizeZero].height;
    self.headerView.frame = CGRectMake(x, y, w, h);
    
    y = y + h;
    h = CGRectGetHeight(self.view.bounds) - y;
    self.postsTableViewController.view.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMidX( self.view.bounds ) - (ActivityIndicatorViewDefaultSize / 2);
    y = CGRectGetMidY( self.view.bounds ) - (ActivityIndicatorViewDefaultSize / 2);
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - LocationControllerDelegate

- (void)locationControllerDidSetLocation:(LocationController *)locationController {
    
    /*
     * Set new location.
     */
    
    self.postsController.location = locationController.location;
    [self.postsController requestPosts];
    
    /*
     * Update placemark.
     */
    
    [self.locationController requestPlacemark];
    
}

- (void)locationControllerDidRequestPlacemark:(LocationController *)locationController {
    
    /*
     * Animate header view title.
     */
    
    [self.headerView animateTitleView:YES];
    
}

- (void)locationControllerDidFetchPlacemark:(LocationController *)locationController {
    
    /*
     * Update header view.
     */
    
    [self.headerView reloadTitle];
    
    /*
     * Stop animating header view title.
     */
    
    [self.headerView animateTitleView:NO];
    
}

#pragma mark - CategoriesControllerDelegate

- (void)categoriesControllerDidRequestCategories:(CategoriesController *)categoriesController {
    
    /*
     * Start animation.
     */
    
    [self.activityIndicatorView startAnimating];
    
}

- (void)categoriesControllerDidFetchCategories:(CategoriesController *)categoriesController {
    
    /*
     * Reload header view.
     */
    
    [self.headerView reloadControls];
    
    /*
     * If no view controller exists, push first.
     */
    
    if (!self.postsTableViewController && self.categoriesController.categories.count) {
        self.postsController.category = self.categoriesController.categories[0];
        self.postsTableViewController = [[PostsTableViewController alloc] initWithPostsController:self.postsController
                                                                                          session:nil];
        [self.view insertSubview:self.postsTableViewController.view atIndex:0];
        [self addChildViewController:self.postsTableViewController];
        [self.postsTableViewController didMoveToParentViewController:self];
    }
    
    /*
     * Stop animation.
     */
    
    [self.activityIndicatorView stopAnimating];
    
}

#pragma mark - CategoriesHeaderViewDelegate

- (void)locationHeaderView:(LocationHeaderView *)locationHeaderView didSelectControlAtIndex:(NSInteger)index {

    /*
     * Move to category at index.
     */
    
    CategoriesController *categoriesController = self.categoriesController;
    PostCategory *category = categoriesController.categories[index];
    self.postsController.category = category;
    
    /*
     * Reload data.
     */
    
    [self.postsController requestPosts];
    
}

#pragma mark - Dynamic getters

- (LocationHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LocationHeaderView alloc] init];
        _headerView.iconControlPosition = HeaderViewIconControlPositionRight;
        _headerView.iconControl.style = LIconControlStyleRemove;
    }
    return _headerView;
}

- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}

@end
