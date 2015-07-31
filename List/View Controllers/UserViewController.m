//
//  UserViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/21/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "UserViewController.h"
#import "PostViewController.h"
#import "UserDataSource.h"
#import "LIconControl.h"
#import "Constants.h"
#import "UserViewController.h"
#import "UserController.h"
#import "UserEditorViewController.h"
#import "UIColor+List.h"

@interface UserViewController () <UITableViewDelegate, UserControllerDelegate, PostsControllerDelegate, ListTableViewCellDelegate>

@property (strong, nonatomic) UserController *userController;
@property (strong, nonatomic) PostsController *postsController;
@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) UserDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) LIconControl *closeControl;

@end

@implementation UserViewController

static CGFloat const UserViewControllerCloseControlSize = 40.f;
static CGFloat const UserViewControllerCloseControlMargin = 12.f;

- (id)initWithUser:(User *)user
           session:(Session *)session {
    if (self = [super init]) {
        
        /*
         * Set session.
         */
        
        self.session = session;
        
        /*
         * Create user controller.
         */
        
        self.userController = [[UserController alloc] initWithUser:user
                                                           session:session];
        self.userController.delegate = self;
        
        /*
         * Create post controller.
         */
        
        self.postsController = [[PostsController alloc] initWithSession:session];
        self.postsController.user = user;
        self.postsController.delegate = self;
        
        /*
         * Create data source.
         */
        
        self.dataSource = [[UserDataSource alloc] initWithUserController:self.userController
                                                         postsController:self.postsController];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * White background.
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.closeControl
                aboveSubview:self.tableView];
    
    /*
     * Add data source to table view.
     */
    
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    
    /*
     * Setup table view.
     */
    
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor list_grayColorAlpha:1];
    self.tableView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    self.tableView.backgroundView = nil;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    /*
     * Handle close control.
     */
    
    [self.closeControl addTarget:self
                          action:@selector(handleCloseControlTouchDown:)
                forControlEvents:UIControlEventTouchDown];
    
    /*
     * Perform request.
     */
    
    [self performRequest];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Reload.
     */
    
    [self.tableView reloadData];
    
}

- (void)performRequest {

    /*
     * Perform request with data source.
     */
    
    [self.postsController requestPosts];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.view.bounds) - UserViewControllerCloseControlSize - UserViewControllerCloseControlMargin;
    y = CGRectGetMinY( [UIScreen mainScreen].applicationFrame ) + UserViewControllerCloseControlMargin;
    w = UserViewControllerCloseControlSize;
    h = UserViewControllerCloseControlSize;
    self.closeControl.frame = CGRectMake(x, y, w, h);
}

#pragma mark - UserControllerDelegate

- (void)userControllerDidFetchUser:(UserController *)userController {
    
    /*
     * Refresh user.
     */
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:UserDataSourceSectionDetails]
                  withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark - PostControllerDelegate

- (void)postsControllerDidFetchPosts:(PostsController *)postController {
    
    /*
     * Refresh posts.
     */
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:UserDataSourceSectionPosts]
                  withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(tableView.bounds);
    switch (indexPath.section) {
        case UserDataSourceSectionDetails: {
            static UserViewDetailsCell *sizingUserViewDetailsCell;
            if (!sizingUserViewDetailsCell) {
                sizingUserViewDetailsCell = (UserViewDetailsCell *)[self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
            }
            User *user = self.userController.user;
            sizingUserViewDetailsCell.frame = CGRectMake(0, 0, width, 0);
            sizingUserViewDetailsCell.nameLabel.text = user.displayName;
            sizingUserViewDetailsCell.bioLabel.text = user.bio;
            [sizingUserViewDetailsCell setNeedsLayout];
            [sizingUserViewDetailsCell layoutIfNeeded];
            CGSize size = [sizingUserViewDetailsCell sizeThatFits:CGSizeMake(width, 0)];
            return size.height;
        }
        case UserDataSourceSectionPosts: {
            static PostsTableViewCell *sizingPostsTableViewCell;
            if (!sizingPostsTableViewCell) {
                sizingPostsTableViewCell = (PostsTableViewCell *)[self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
            }
            sizingPostsTableViewCell.frame = CGRectMake(0, 0, width, 0);
            Post *post = self.postsController.posts[indexPath.row];
            User *user = post.user;
            sizingPostsTableViewCell.coverPhotoImageView.hidden = !post.coverPhotoURL;
            sizingPostsTableViewCell.titleLabel.text = post.title;
            sizingPostsTableViewCell.contentLabel.text = post.content;
            sizingPostsTableViewCell.userNameLabel.text = user.displayName;
            [sizingPostsTableViewCell setNeedsLayout];
            [sizingPostsTableViewCell layoutIfNeeded];
            CGSize size = [sizingPostsTableViewCell sizeThatFits:CGSizeMake(width, 0)];
            return size.height + 1.0f;
        }
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

#pragma mark - ListTableViewCellDelegate

- (void)listTableViewCell:(ListTableViewCell *)cell viewTapped:(UIView *)view {
    NSIndexPath *indexPath = cell.indexPath;
    User *user = self.userController.user;
    UIViewController *viewController;
    switch (indexPath.section) {
        case UserDataSourceSectionDetails: {
            if (view == ((UserViewDetailsCell *)cell).button) {
                UserEditorViewController *userEditorViewController = [[UserEditorViewController alloc] initWithUser:user session:self.session];
                viewController = [[UINavigationController alloc] initWithRootViewController:userEditorViewController];
            }
            break;
        }
        case UserDataSourceSectionPosts: {
            Post *post = self.postsController.posts[indexPath.row];
            viewController = [[PostViewController alloc] initWithPost:post session:self.session];
            break;
        }
    }
    if (viewController) {
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat Y = contentOffset.y;
    if (Y < 0) {
        UserViewDetailsCell *cell = (UserViewDetailsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UIImageView *coverPhotoView = cell.coverPhotoView;
        CGRect frame = coverPhotoView.frame;
        frame.origin.y = Y;
        frame.size.height = (frame.size.width * 0.5625) + fabs(Y);
        coverPhotoView.frame = frame;
    }
    LIconControl *closeControl = self.closeControl;
    CGRect frame = closeControl.frame;
    frame.origin.y = (CGRectGetMinY( [UIScreen mainScreen].applicationFrame ) + UserViewControllerCloseControlMargin) - (Y > 0 ? Y : 0);
    closeControl.frame = frame;
}

#pragma mark - Close control handler

- (void)handleCloseControlTouchDown:(LIconControl *)closeControl {
    
    /*
     * Dismiss.
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

#pragma mark - Dynamic getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (LIconControl *)closeControl {
    if (!_closeControl) {
        _closeControl = [[LIconControl alloc] initWithStyle:LIconControlStyleRemove];
        _closeControl.lineColor = [UIColor whiteColor];
    }
    return _closeControl;
}

@end
