//
//  PostViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostViewController.h"
#import "UserViewController.h"
#import "PostEditorViewController.h"
#import "ThreadViewController.h"
#import "PostDataSource.h"
#import "PostController.h"
#import "LIconControl.h"
#import "ThreadsFormView.h"
#import "APIRequest.h"
#import "Constants.h"
#import "ActivityIndicatorView.h"
#import "UIColor+List.h"

@interface PostViewController () <PostControllerDelegate, UITableViewDelegate, ListTableViewCellDelegate>

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) PostDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) LIconControl *closeControl;
@property (strong, nonatomic) ThreadsFormView *threadsFormView;
@property (strong, nonatomic) UIView *activityOverlay;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) PostController *postController;

@end

@implementation PostViewController

static CGFloat const PostViewControllerCloseControlSize = 40.f;
static CGFloat const PostViewControllerCloseControlMargin = 12.f;

- (id)initWithPost:(Post *)post
           session:(Session *)session {
    if (self = [super init]) {
        self.session = session;
        
        /*
         * Create post controller.
         */

        self.postController = [[PostController alloc] initWithPost:post session:session];
        self.postController.delegate = self;
        
        /*
         * Create data source.
         */
        
        self.dataSource = [[PostDataSource alloc] initWithPostController:self.postController];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set background.
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.threadsFormView];
    [self.view insertSubview:self.activityOverlay
                aboveSubview:self.tableView];
    [self.activityOverlay addSubview:self.activityIndicatorView];
    [self.view insertSubview:self.closeControl
                aboveSubview:self.activityOverlay];
    
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
     * Handle threads post view save button.
     */
    
    ThreadsFormView *threadsFormView = self.threadsFormView;
    UIButton *saveButton = threadsFormView.saveButton;
    [saveButton addTarget:self
                   action:@selector(handleThreadsFormViewSaveButtonTouchDown:)
         forControlEvents:UIControlEventTouchDown];
    
    /*
     * Register keyboard notifications.
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillBeShown:)
                          name:UIKeyboardWillShowNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(keyboardWillBeHidden:)
                          name:UIKeyboardWillHideNotification
                        object:nil];
    
    /*
     * Register tap notification
     */
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleTableViewTapGestureRecognizer:)];
    
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Perform request.
     */
    
    [self.postController requestPost];
    
}

- (void)dealloc {
    
    /*
     * Remove keyboard notifications
     */
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.activityOverlay.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
    
    x = ( CGRectGetMidX( self.activityOverlay.bounds ) - ( ActivityIndicatorViewDefaultSize / 2 ) );
    y = ( CGRectGetMidY( self.activityOverlay.bounds ) - ( ActivityIndicatorViewDefaultSize / 2 ) );
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMaxX(self.view.bounds) - PostViewControllerCloseControlSize - PostViewControllerCloseControlMargin;
    y = CGRectGetMinY( [UIScreen mainScreen].applicationFrame ) + PostViewControllerCloseControlMargin;
    w = PostViewControllerCloseControlSize;
    h = PostViewControllerCloseControlSize;
    self.closeControl.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = [self.threadsFormView sizeThatFits:CGSizeMake(w, 0.0f)].height;
    y = CGRectGetMaxY(self.view.bounds) - h;
    self.threadsFormView.frame = CGRectMake(x, y, w, h);
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom = h;
    self.tableView.contentInset = contentInset;
    
    contentInset = self.tableView.scrollIndicatorInsets;
    contentInset.bottom = h;
    self.tableView.scrollIndicatorInsets = contentInset;
}

- (void)presentOptionsAlertController {
    UIAlertController *alertController = [[UIAlertController alloc] init];
    PostController *postController = self.postController;
    Post *post = postController.post;
    User *user = post.user;
    User *currentUser = self.session.user;
    
    if ([currentUser isEqual:user]) {
        
        /*
         * Add edit post action.
         */
        
        UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            PostEditorViewController *viewController = [[PostEditorViewController alloc] initWithPost:post session:self.session];
            [self presentViewController:viewController animated:YES completion:nil];
        }];
        [alertController addAction:editAction];
        
        /*
         * Add delete post action.
         */
        
        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [self.postController deletePost];
        }];
        [alertController addAction:deleteAction];
        
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - PostControllerDelegate

- (void)postControllerDidFetchPost:(PostController *)postController {
    
    /*
     * Reload table.
     */
    
    [self.tableView reloadData];
    
    /*
     * Animate table view.
     */
    
    [UIView animateWithDuration:0.25f animations:^{
        self.tableView.alpha = 1.0f;
    }];
}

- (void)postController:(PostController *)postController didAddThread:(Thread *)thread toPostAtIndex:(NSInteger)index {
    
    /*
     * Stop animating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
    /*
     * Add thread.
     */
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:PostDataSourceSectionThreads];
    [self.tableView insertRowsAtIndexPaths:@[ indexPath ]
                          withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionBottom
                                  animated:YES];
}

- (void)postController:(PostController *)postController failedToAddThread:(Thread *)thread toPostWithError:(NSError *)error {
    
    /*
     * Stop animating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
}

- (void)postController:(PostController *)postController failedToAddThread:(Thread *)thread toPostWithResponse:(id<NSObject>)response {
    
    /*
     * Stop animating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
}

- (void)postControllerDidDeletePost:(PostController *)postController {
    
    /*
     * Stop animating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
    /*
     * Dismiss this.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - Dynamic getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (ThreadsFormView *)threadsFormView {
    if (!_threadsFormView) {
        _threadsFormView = [[ThreadsFormView alloc] init];
    }
    return _threadsFormView;
}

- (LIconControl *)closeControl {
    if (!_closeControl) {
        _closeControl = [[LIconControl alloc] initWithStyle:LIconControlStyleRemove];
        _closeControl.lineColor = [UIColor whiteColor];
    }
    return _closeControl;
}

- (UIView *)activityOverlay {
    if (!_activityOverlay) {
        _activityOverlay = [[UIView alloc] init];
        _activityOverlay.hidden = YES;
        _activityOverlay.backgroundColor = [UIColor clearColor];
    }
    return _activityOverlay;
}

- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleBlue];
    }
    return _activityIndicatorView;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    switch (section) {
        case PostDataSourceSectionDetails: {
            CGFloat width = CGRectGetWidth(tableView.frame);
            static PostViewDetailsCell *sizingPostViewDetailsCell;
            if (!sizingPostViewDetailsCell) {
                sizingPostViewDetailsCell = (PostViewDetailsCell *)[self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
            }
            sizingPostViewDetailsCell.frame = CGRectMake(0, 0, width, 0);
            Post *post = self.postController.post;
            sizingPostViewDetailsCell.titleLabel.text = post.title;
            sizingPostViewDetailsCell.contentLabel.text = post.content;
            sizingPostViewDetailsCell.hasCoverPhoto = !!post.coverPhotoURL;
            [sizingPostViewDetailsCell setNeedsLayout];
            [sizingPostViewDetailsCell layoutIfNeeded];
            CGSize size = [sizingPostViewDetailsCell sizeThatFits:CGSizeMake(width, 0)];
            return size.height;
        }
        case PostDataSourceSectionThreads: {
            CGFloat width = CGRectGetWidth(tableView.frame);
            static ThreadsTableViewCell *sizingThreadsTableViewCell;
            if (!sizingThreadsTableViewCell) {
                sizingThreadsTableViewCell = (ThreadsTableViewCell *)[self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
            }
            sizingThreadsTableViewCell.frame = CGRectMake(0, 0, width, 0);
            Thread *thread = self.postController.post.threads[indexPath.row];
            User *user = thread.user;
            sizingThreadsTableViewCell.userNameString = user.displayName;
            sizingThreadsTableViewCell.contentString = thread.content;
            [sizingThreadsTableViewCell setNeedsLayout];
            [sizingThreadsTableViewCell layoutIfNeeded];
            CGSize size = [sizingThreadsTableViewCell sizeThatFits:CGSizeMake(width, 0)];
            return size.height + 1.0f;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    /*
     * Temporary: only show list image view
     * if post user is session user.
     */
    
    PostController *postController = self.postController;
    Post *post = postController.post;
    User *user = post.user;
    if (indexPath.section == PostDataSourceSectionDetails) ((PostViewDetailsCell *)cell).listImageView.hidden = !(indexPath.section == PostDataSourceSectionDetails && [user isEqual:self.session.user]);
        
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

#pragma mark - ListTableViewCellDelegate

- (void)listTableViewCell:(ListTableViewCell *)cell viewTapped:(UIView *)view {
    NSIndexPath *indexPath = cell.indexPath;
    UIViewController *viewController;
    switch (indexPath.section) {
        case PostDataSourceSectionDetails: {
            Post *post = self.postController.post;
            if (view == ((PostViewDetailsCell *)cell).userNameLabel || view == ((PostViewDetailsCell *)cell).avatarImageView) {
                User *user = post.user;
                viewController = [[UserViewController alloc] initWithUser:user session:self.session];
            } else if (view == ((PostViewDetailsCell *)cell).listImageView) {
                [self presentOptionsAlertController];
            }
            break;
        }
        case PostDataSourceSectionThreads: {
            Post *post = self.postController.post;
            Thread *thread = post.threads[indexPath.row];
            if (view == ((ThreadsTableViewCell *)cell).avatarImageView) {
                User *user = thread.user;
                viewController = [[UserViewController alloc] initWithUser:user session:self.session];
            } else {
                ThreadViewController *threadViewController = [[ThreadViewController alloc] initWithThread:thread inPost:post session:self.session];
                viewController = [[UINavigationController alloc] initWithRootViewController:threadViewController];
            }
            break;
        }
    }
    if (viewController) {
        [self presentViewController:viewController
                           animated:YES
                         completion:nil];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat Y = contentOffset.y;
    if (Y < 0) {
        PostViewDetailsCell *cell = (PostViewDetailsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                                                                    inSection:0]];
        UIImageView *coverPhotoView = cell.coverPhotoView;
        CGRect frame = coverPhotoView.frame;
        frame.origin.y = Y;
        frame.size.height = (frame.size.width * (cell.hasCoverPhoto ? 1 : 0.5625)) + fabs(Y);
        coverPhotoView.frame = frame;
    }
    
    LIconControl *closeControl = self.closeControl;
    CGRect frame = closeControl.frame;
    frame.origin.y = (CGRectGetMinY( [UIScreen mainScreen].applicationFrame ) + PostViewControllerCloseControlMargin) - (Y > 0 ? Y : 0);
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

#pragma mark - Thread form view handlers

- (void)handleThreadsFormViewSaveButtonTouchDown:(UIButton *)saveButton {
    
    /*
     * Create thread
     */
    
    ThreadsFormView *threadsFormView = self.threadsFormView;
    LTextView *textView = threadsFormView.textView;
    UIButton *privacyButton = threadsFormView.privacyButton;
    
    Thread *thread = [[Thread alloc] init];
    thread.content = textView.text;
    thread.isPrivate = privacyButton.isSelected;
    
    /*
     * Clear and end editing
     */
    
    textView.text = nil;
    [textView endEditing:YES];
    
    /*
     * Start animating.
     */
    
    self.activityOverlay.hidden = NO;
    [self.activityIndicatorView startAnimating];
    
    /*
     * Send to post controller.
     */
    
    [self.postController addThreadToPost:thread];
    
}

#pragma mark - Gesture recognizers

- (void)handleTableViewTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
    
    /*
     * Dismiss keyboard.
     */
    
    [self.view endEditing:YES];
        
}

#pragma mark - Keyboard observers

- (void)keyboardWillBeShown:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.view.frame;
    frame.origin.y -= kbSize.height;
    self.view.frame = frame;
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.view.frame;
    frame.origin.y += kbSize.height;
    self.view.frame = frame;
}

@end
