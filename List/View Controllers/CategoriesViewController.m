//
//  CategoriesViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/3/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "CategoriesViewController.h"
#import "GeoPostsTableViewController.h"
#import "PostEditorViewController.h"
#import "Post.h"
#import "PostCategory.h"
#import "UIColor+List.h"
#import "Constants.h"
#import "PostCategory.h"
#import "ActivityIndicatorView.h"
#import "CategoriesHeaderView.h"
#import "CategoriesDataSource.h"
#import "LIconControl.h"

@interface CategoriesViewController () <CategoriesControllerDelegate, CategoriesHeaderViewDelegate, PostEditorViewControllerDelegate>

@property (strong, nonatomic) CategoriesController *categoriesController;
@property (strong, nonatomic) CategoriesDataSource *dataSource;
@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) CategoriesHeaderView *headerView;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) GeoPostsTableViewController *postsTableViewController;
@property (strong, nonatomic) PostEditorViewController *postEditorViewController;
@property (strong, nonatomic) LIconControl *addIconControl;

@end

@implementation CategoriesViewController

static CGFloat const CategoriesViewControllerAddIconControlSize = 50.f;
static CGFloat const CategoriesViewControllerAddIconControlMargin = 12.f;

- (id)initWithCategoriesController:(CategoriesController *)categoriesController
              session:(Session *)session {
    if (self = [super init]) {
        self.session = session;
        self.categoriesController = categoriesController;
        self.categoriesController.delegate = self;
        
        self.dataSource = [[CategoriesDataSource alloc] initWithCategoriesController:self.categoriesController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set background to white.
     */
    
    self.view.backgroundColor = [UIColor list_blueColorAlpha:1];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.activityIndicatorView];
    [self.view addSubview:self.addIconControl];
    
    /*
     * Set up header view.
     */
    
    self.headerView.dataSource = self.dataSource;
    
    /*
     * Listen to header view menu button.
     */
    
    LIconControl *menuControl = self.headerView.menuControl;
    [menuControl addTarget:self action:@selector(handleMenuControlTouchDown:)
          forControlEvents:UIControlEventTouchDown];
    
    /*
     * Perform first data source request.
     */
    
    [self.activityIndicatorView startAnimating];
    [self.categoriesController requestCategories];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX( [UIScreen mainScreen].applicationFrame );
    y = CGRectGetMinY( [UIScreen mainScreen].applicationFrame );
    w = CGRectGetWidth( [UIScreen mainScreen].applicationFrame );
    self.headerView.frame = CGRectMake(x, y, w, 0.0f);
    [self.headerView sizeToFit];
    
    y = CGRectGetMaxY(self.headerView.frame);
    h = CGRectGetMaxY( [UIScreen mainScreen].applicationFrame ) - y;
    self.postsTableViewController.view.frame = CGRectMake(x, y, w, h);
    
    x = (CGRectGetWidth(self.view.bounds) - ActivityIndicatorViewDefaultSize) / 2;
    y = (CGRectGetHeight(self.view.bounds) - ActivityIndicatorViewDefaultSize) / 2;
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.view.bounds) - CategoriesViewControllerAddIconControlSize - CategoriesViewControllerAddIconControlMargin;
    y = CGRectGetMaxY(self.view.bounds) - CategoriesViewControllerAddIconControlSize - CategoriesViewControllerAddIconControlMargin;
    w = CategoriesViewControllerAddIconControlSize;
    h = CategoriesViewControllerAddIconControlSize;
    self.addIconControl.frame = CGRectMake(x, y, w, h);
    
    if (self.postEditorViewController) {
        y = CGRectGetMaxY(self.headerView.frame);
        x = CGRectGetMinX(self.view.bounds);
        w = CGRectGetWidth(self.view.bounds);
        h = CGRectGetMaxY( [UIScreen mainScreen].applicationFrame ) - y;
        self.postEditorViewController.view.frame = CGRectMake(x, y, w, h);
    }
    
}

- (void)pushPostsTableViewControllerForCategory:(PostCategory *)category {
    
    /*
     * Dismiss current post editor view controller.
     */
    
    [self dismissPostEditorViewController];
    
    /*
     * Create table view controller for posts.
     */
    
    PostsController *postsController = [[PostsController alloc] initWithSession:self.session];
    postsController.category = category;
    GeoPostsTableViewController *geoPostsTableViewController = [[GeoPostsTableViewController alloc] initWithPostsController:postsController
                                                                                                                    session:self.session];

    
    /*
     * Push the table view controller.
     */
    
    [self.view insertSubview:geoPostsTableViewController.view
                aboveSubview:self.postsTableViewController ? self.postsTableViewController.view : self.activityIndicatorView];
    [self.postsTableViewController.view removeFromSuperview];
    [self.postsTableViewController removeFromParentViewController];
    [self addChildViewController:geoPostsTableViewController];
    [geoPostsTableViewController didMoveToParentViewController:self];
    self.postsTableViewController = geoPostsTableViewController;
    
    /*
     * Select on header view.
     */
    
    NSArray *categories = self.categoriesController.categories;
    NSInteger index = [categories indexOfObject:category];
    [self.headerView selectButtonAtIndex:index];
    
}

- (void)handleAddIconControlTouchDown:(LIconControl *)addIconControl {
    
    /*
     * Display post editor view controller.
     */
    
    [self presentPostEditorViewController];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Trigger view will appear on post view controller if one exists.
     */
    
    if (self.postsTableViewController) {
        [self.postsTableViewController viewWillAppear:animated];
    }
}

- (void)presentPostEditorViewController {
    
    /*
     * Get current category.
     */
    
    NSInteger index = self.headerView.selectedIndex;
    NSArray *categories = self.categoriesController.categories;
    if (index < categories.count) {
        PostCategory *category = [categories objectAtIndex:index];
        
        /*
         * Dismiss current post editor view controller.
         */
        
        [self dismissPostEditorViewController];
        
        /*
         * Create new post.
         */
        
        Post *post = [[Post alloc] init];
        post.category = category;
        
        /*
         * Create new view controller.
         */
        
        PostEditorViewController *postEditorViewController = [[PostEditorViewController alloc] initWithPost:post
                                                                                                    session:self.session];
        postEditorViewController.delegate = self;
        
        /*
         * Set up view outside of viewport.
         */
        
        CGFloat x, y, w, h;
        
        x = CGRectGetMinX([UIScreen mainScreen].applicationFrame);
        y = CGRectGetMaxY(self.view.frame);
        w = CGRectGetWidth(self.view.frame);
        h = CGRectGetMaxY([UIScreen mainScreen].applicationFrame) - y;
        postEditorViewController.view.frame = CGRectMake(x, y, w, h);
        [self.view insertSubview:postEditorViewController.view
                    aboveSubview:self.addIconControl];
        self.postEditorViewController = postEditorViewController;
        
        /*
         * Animate view in.
         */
        
        [UIView animateWithDuration:0.25f
                         animations:^{
                             CGFloat x, y, w, h;
                             x = CGRectGetMinX([UIScreen mainScreen].applicationFrame);
                             y = CGRectGetMinY([UIScreen mainScreen].applicationFrame) + CGRectGetMaxY(self.headerView.bounds);
                             w = CGRectGetWidth(self.view.bounds);
                             h = CGRectGetMaxY([UIScreen mainScreen].applicationFrame) - y;
                             postEditorViewController.view.frame = CGRectMake(x, y, w, h);
                         } completion:^(BOOL finished) {
                             [self addChildViewController:postEditorViewController];
                             [postEditorViewController didMoveToParentViewController:self];
                         }];
    }
    
}

- (void)dismissPostEditorViewController {
    
    /*
     * Animate view out.
     */
    
    
    PostEditorViewController *viewController = self.postEditorViewController;
    [viewController removeFromParentViewController];
    [viewController didMoveToParentViewController:nil];
    self.postEditorViewController = nil;
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         CGFloat x, y, w, h;
                         x = CGRectGetMinX(viewController.view.frame);
                         y = CGRectGetMaxY(self.view.frame);
                         w = CGRectGetWidth(viewController.view.frame);
                         h = CGRectGetHeight(viewController.view.frame);
                         viewController.view.frame = CGRectMake(x, y, w, h);
                     } completion:^(BOOL finished) {
                         [viewController.view removeFromSuperview];
                     }];
    
}



#pragma mark - CategoriesControllerDelegate

- (void)categoriesControllerDidFetchCategories:(CategoriesController *)categoriesController {
    
    /*
     * Reload header view.
     */
    
    [self.headerView reloadData];
    
    /*
     * If no view controller exists, push first.
     */
    
    if (!self.postsTableViewController && categoriesController.categories.count) {
        PostCategory *category = [categoriesController.categories objectAtIndex:0];
        [self pushPostsTableViewControllerForCategory:category];
    }
    
}

#pragma mark - Dynamic getters

- (CategoriesHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[CategoriesHeaderView alloc] init];
        _headerView.delegate = self;
    }
    return _headerView;
}
     
- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleWhite];
    }
    return _activityIndicatorView;
}

- (LIconControl *)addIconControl {
    if (!_addIconControl) {
        _addIconControl = [[LIconControl alloc] initWithStyle:LIconControlStyleAdd];
        _addIconControl.lineColor = [UIColor list_blueColorAlpha:0.85];
        [_addIconControl addTarget:self
                            action:@selector(handleAddIconControlTouchDown:)
                  forControlEvents:UIControlEventTouchDown];
    }
    return _addIconControl;
}

#pragma mark - CategoriesHeaderViewDelegate

- (void)categoriesHeaderView:(CategoriesHeaderView *)headerView
         buttonTappedAtIndex:(NSInteger)index {
    PostCategory *category = [self.categoriesController.categories objectAtIndex:index];
    [self pushPostsTableViewControllerForCategory:category];
}

#pragma mark - PostEditorViewControllerDelegate

- (void)postEditorViewControllerDidSavePost:(PostEditorViewController *)viewController {
    
    /*
     * Dismiss post editor view controller
     */
    
    [self dismissPostEditorViewController];
    
    /*
     * Refresh current post table view controller.
     */
    
    [self.postsTableViewController performRequest];
    
}

- (void)postEditorViewControllerDidAskToClose:(PostEditorViewController *)viewController {
    
    /*
     * Dismiss post editor view controller
     */
    
    [self dismissPostEditorViewController];
    
}

#pragma mark - Header view menu control handler

- (void)handleMenuControlTouchDown:(LIconControl *)menuControl {
    [self.view endEditing:YES];
    if ([self.delegate respondsToSelector:@selector(categoriesViewControllerHeaderViewMenuControlTouchDown:)]) {
        [self.delegate categoriesViewControllerHeaderViewMenuControlTouchDown:self];
    }
}

@end
