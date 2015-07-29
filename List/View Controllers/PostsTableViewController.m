//
//  PostsTableViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/1/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostsTableViewController.h"
#import "PostsTableViewCell.h"
#import "PostViewController.h"
#import "Constants.h"
#import "UIColor+List.h"
#import "LReachabilityManager.h"
#import "PostsSearchBar.h"
#import "UserViewController.h"

@interface PostsTableViewController () <PostsControllerDelegate, PostsSearchBarDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) PostsController *postsController;
@property (strong, nonatomic) PostsDataSource *dataSource;
@property (strong, nonatomic) PostsTableViewStatusView *statusView;
@property (strong, nonatomic) PostsSearchBar *searchBar;
@property (strong, nonatomic) Session *session;

@end

@implementation PostsTableViewController

static CGFloat const PostsTableViewControllerSearchBarHeight = 50.f;

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
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollsToTop = YES;
    self.tableView.separatorColor = [UIColor list_lightGrayColorAlpha:1];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    CGRect frame = self.searchBar.frame;
    frame.size.height = PostsTableViewControllerSearchBarHeight;
    self.searchBar.frame = frame;
    self.tableView.tableHeaderView = self.searchBar;
    
    /*
     * Register tap notification
     */
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleTableViewTapGestureRecognizer:)];
    
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.statusView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * If internet is available,
     * perform request.
     */
    
    LReachabilityManager *reachabilityManager = [LReachabilityManager sharedManager];
    if (reachabilityManager.isReachable) {
        self.statusView.state = PostsTableViewStatusViewStateLoading;
        [self performRequest];
    } else {
        self.statusView.state = PostsTableViewStatusViewStateAPIRequestFailed;
    }
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.statusView.frame = CGRectMake(x, y, w, h);
}

- (void)performRequest {
    
    /*
     * Proxy for controller perform request.
     */
    
    [self.postsController requestPosts];
}

- (void)handleRefreshControl {
    
    /*
     * Don't run `performRequest`
     * to avoid loader.
     */
    
    [self performRequest];
    
}

#pragma mark - PostsDataSourceDelegate

- (void)postsControllerDidFetchPosts:(PostsController *)postController {
    
    /*
     * Reload data.
     */
    
    [self.tableView reloadData];
    
    /*
     
     * Stop animating.
     */
    
    self.statusView.state = PostsTableViewStatusViewStateLoaded;
    [self.refreshControl endRefreshing];
}

- (void)postsController:(PostsController *)postController failedToFetchPostsWithError:(NSError *)error {
    
    /*
     * Stop animating.
     */
    
    self.statusView.state = PostsTableViewStatusViewStateAPIRequestFailed;
    [self.refreshControl endRefreshing];
    
}

- (void)postsController:(PostsController *)postController failedToFetchPostsWithResponse:(id<NSObject>)response {
    
    /*
     * Stop animating.
     */
    
    self.statusView.state = PostsTableViewStatusViewStateAPIRequestFailed;
    [self.refreshControl endRefreshing];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(tableView.bounds);
    static PostsTableViewCell *sizingCell;
    if (!sizingCell) {
        sizingCell = (PostsTableViewCell *)[self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    sizingCell.frame = CGRectMake(0, 0, width, 0);
    Post *post = self.postsController.posts[indexPath.row];
    User *user = post.user;
    sizingCell.coverPhotoImageView.hidden = !post.coverPhotoURL;
    sizingCell.titleLabel.text = post.title;
    sizingCell.contentLabel.text = post.content;
    sizingCell.userNameLabel.text = user.displayName;
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell sizeThatFits:CGSizeMake(width, 0)];
    return size.height + 1.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PostsTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     * Style cell.
     */
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
}

#pragma mark - Gesture recognizer handler

- (void)handleTableViewTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    if (indexPath) {
        Post *post = self.postsController.posts[indexPath.row];
        PostsTableViewCell *cell = (PostsTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        CGPoint cellPoint = [gestureRecognizer locationInView:cell];
        if ( CGRectContainsPoint(cell.avatarImageView.frame, cellPoint) || CGRectContainsPoint(cell.userNameLabel.frame, cellPoint) ) {
            User *user = post.user;
            UserViewController *viewController = [[UserViewController alloc] initWithUser:user session:self.session];
            [self presentViewController:viewController animated:YES completion:nil];
        } else {
            PostViewController *viewController = [[PostViewController alloc] initWithPost:post session:self.session];
            [self presentViewController:viewController animated:YES completion:nil];
        }
    }
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
    
    [self performRequest];
    
}

#pragma mark - Dynamic getters

- (PostsTableViewStatusView *)statusView {
    if (!_statusView) {
        _statusView = [[PostsTableViewStatusView alloc] init];
    }
    return _statusView;
}

- (PostsSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[PostsSearchBar alloc] init];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end
