//
//  PostsTableViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsTableViewController.h"
#import "CoverPostsTableViewCell.h"
#import "PostsTableViewDelegate.h"
#import "UIColor+List.h"
#import "LReachabilityManager.h"
#import "PostsSearchBar.h"

@interface PostsTableViewController () <PostsControllerDelegate, PostsSearchBarDelegate, ListTableViewCellDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) PostsTableViewDelegate *delegate;
@property (strong, nonatomic) PostsController *postsController;
@property (strong, nonatomic) PostsDataSource *dataSource;
@property (strong, nonatomic) PostsSearchBar *searchBar;
@property (strong, nonatomic) Session *session;

@end

@implementation PostsTableViewController

static CGFloat const PostsTableViewControllerSearchBarHeight = 40.f;

- (id)initWithPostsController:(PostsController *)postsController
                      session:(Session *)session {
    if (self = [super init]) {
        self.session = session;
        self.postsController = postsController;
        self.postsController.delegate = self;
        
        /*
         * Create data source.
         */
        
        self.dataSource = [[PostsDataSource alloc] initWithPostsController:self.postsController];
        
        /*
         * Create delegate.
         */
        
        self.delegate = [[PostsTableViewDelegate alloc] initWithPostsController:postsController];
        self.delegate.viewController = self;
        self.delegate.session = session;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Add refresh control.
     */
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(handleRefreshControl)
                  forControlEvents:UIControlEventValueChanged];
    
    /*
     * Set up data source.
     */
    
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    
    /*
     * Set up table view.
     */
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.delegate;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollsToTop = YES;
    self.tableView.separatorColor = [UIColor list_grayColorAlpha:1];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsMake(PostsTableViewCellPadding, 0, PostsTableViewCellPadding, 0);
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsMake(PostsTableViewCellPadding, 0, PostsTableViewCellPadding, 0);
    }
    
    CGRect frame = self.searchBar.frame;
    frame.size.height = PostsTableViewControllerSearchBarHeight;
    self.searchBar.frame = frame;
    self.tableView.tableHeaderView = self.searchBar;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * If internet is available,
     * perform request.
     */
    
    LReachabilityManager *reachabilityManager = [LReachabilityManager sharedManager];
    if (reachabilityManager.isReachable) {
        [self.postsController requestPosts];
    }
    
}

- (void)handleRefreshControl {
    
    /*
     * Refresh posts.
     */
    
    [self.postsController requestPosts];
    
}

#pragma mark - PostsDataSourceDelegate

- (void)postsControllerDidRequestPosts:(PostsController *)postController {
    
    /*
     * Show status view animation
     * if needed.
     */
    
//    if (!self.refreshControl.isRefreshing && !self.searchBar.isFirstResponder) {
//        self.statusView.state = PostsTableViewStatusViewStateLoading;
//    }
    
}

- (void)postsControllerDidFetchPosts:(PostsController *)postController {
    
    /*
     * Reload data.
     */
    
    [self.tableView reloadData];
    
    /*
     * Stop animating.
     */
    
    [self.refreshControl endRefreshing];
}

- (void)postsController:(PostsController *)postController failedToFetchPostsWithError:(NSError *)error {
    
    /*
     * Stop animating.
     */
    
    [self.refreshControl endRefreshing];
    
}

- (void)postsController:(PostsController *)postController failedToFetchPostsWithResponse:(id<NSObject>)response {
    
    /*
     * Stop animating.
     */
    
    [self.refreshControl endRefreshing];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    /*
     * End editing.
     */
    
    [self.view endEditing:YES];
    
}

#pragma mark - PostsSearchBarDelegate

- (void)postsSearchBarDidChange:(PostsSearchBar *)searchBar {
    
    /*
     * Edit query.
     */
    
    self.postsController.query = searchBar.text;
    
    /*
     * Send request.
     */
    
    [self.postsController requestPosts];
    
}

#pragma mark - Dynamic getters

- (PostsSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[PostsSearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end
