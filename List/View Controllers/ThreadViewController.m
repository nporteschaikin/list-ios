//
//  ThreadViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ThreadViewController.h"
#import "PostController.h"
#import "ThreadDataSource.h"
#import "MessagesFormView.h"
#import "ActivityIndicatorView.h"
#import "Constants.h"
#import "UIColor+List.h"

@interface ThreadViewController () <PostControllerDelegate, UITableViewDelegate>

@property (strong, nonatomic) Thread *thread;
@property (strong, nonatomic) PostController *postController;
@property (strong, nonatomic) ThreadDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MessagesFormView *messagesFormView;
@property (strong, nonatomic) UIView *activityOverlay;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;

@end

@implementation ThreadViewController

- (instancetype)initWithThread:(Thread *)thread
                        inPost:(Post *)post
                       session:(Session *)session {
    if (self = [super init]) {
        self.thread = thread;
        self.postController = [[PostController alloc] initWithPost:post
                                                           session:session];
        self.postController.delegate = self;
        self.dataSource = [[ThreadDataSource alloc] initWithThread:thread];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.messagesFormView
                aboveSubview:self.tableView];
    [self.view insertSubview:self.activityOverlay
                aboveSubview:self.tableView];
    [self.activityOverlay addSubview:self.activityIndicatorView];
    
    /*
     * Set up table view.
     */
    
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    self.tableView.dataSource = self.dataSource;
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
     * Set background color.
     */
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     * Add navigation items.
     */
    
    PostController *postController = self.postController;
    Post *post = postController.post;
    self.navigationItem.title = post.title;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(handleDoneBarButtonItem:)];
    
    /*
     * Handle message view save.
     */
    
    MessagesFormView *messagesFormView = self.messagesFormView;
    UIButton *saveButton = messagesFormView.saveButton;
    [saveButton addTarget:self
                   action:@selector(handleMessagesFormViewSaveButtonTouchDown:)
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
    
    x = 0.0f;
    w = CGRectGetWidth(self.view.bounds);
    h = [self.messagesFormView sizeThatFits:CGSizeMake(w, 0.0f)].height;
    y = CGRectGetMaxY(self.view.bounds) - h;
    self.messagesFormView.frame = CGRectMake(x, y, w, h);
    
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.bottom = h;
    self.tableView.contentInset = contentInset;
    
    contentInset = self.tableView.scrollIndicatorInsets;
    contentInset.bottom = h;
    self.tableView.scrollIndicatorInsets = contentInset;
}

#pragma mark - PostControllerDelegate

- (void)postController:(PostController *)postController didAddMessage:(Message *)message toThread:(Thread *)thread atIndex:(NSInteger)index {
    
    /*
     * Stop animating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
    /*
     * Add message.
     */
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:ThreadDataSourceSectionsMessages];
    [self.tableView insertRowsAtIndexPaths:@[ indexPath ]
                          withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionBottom
                                  animated:YES];
}

- (void)postController:(PostController *)postController failedToAddMessage:(Message *)message toThread:(Thread *)thread withError:(NSError *)error {
    
    /*
     * Stop animating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
}

- (void)postController:(PostController *)postController failedToAddMessage:(Message *)message toThread:(Thread *)thread withResponse:(id<NSObject>)response {
    
    /*
     * Stop animating activity.
     */
    
    self.activityOverlay.hidden = YES;
    [self.activityIndicatorView stopAnimating];
    
}

#pragma mark - Messages form view save handler

- (void)handleMessagesFormViewSaveButtonTouchDown:(UIButton *)saveButton {
    
    /*
     * Create thread
     */
    
    MessagesFormView *messagesFormView = self.messagesFormView;
    LTextView *textView = messagesFormView.textView;
    
    Message *message = [[Message alloc] init];
    message.content = textView.text;
    
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
    
    [self.postController addMessage:message
                           toThread:self.thread];
    
}

#pragma mark - Bar button handler

- (void)handleDoneBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    /*
     * Dismiss.
     */
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    Thread *thread = self.thread;
    switch (section) {
        case ThreadDataSourceSectionsThread: {
            User *user = thread.user;
            CGFloat width = CGRectGetWidth(tableView.frame);
            static ThreadsTableViewCell *sizingThreadsTableViewCell;
            if (!sizingThreadsTableViewCell) {
                sizingThreadsTableViewCell = (ThreadsTableViewCell *)[self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
            }
            sizingThreadsTableViewCell.frame = CGRectMake(0, 0, width, 0);
            sizingThreadsTableViewCell.userNameString = user.displayName;
            sizingThreadsTableViewCell.contentString = thread.content;
            [sizingThreadsTableViewCell setNeedsLayout];
            [sizingThreadsTableViewCell layoutIfNeeded];
            CGSize size = [sizingThreadsTableViewCell sizeThatFits:CGSizeMake(width, 0)];
            return size.height + 1.0f;
        }
        case ThreadDataSourceSectionsMessages: {
            Message *message = thread.messages[row];
            User *user = message.user;
            CGFloat width = CGRectGetWidth(tableView.frame);
            static MessagesTableViewCell *sizingMessagesTableViewCell;
            if (!sizingMessagesTableViewCell) {
                sizingMessagesTableViewCell = (MessagesTableViewCell *)[self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
            }
            sizingMessagesTableViewCell.frame = CGRectMake(0, 0, width, 0);
            sizingMessagesTableViewCell.userNameString = user.displayName;
            sizingMessagesTableViewCell.contentString = thread.content;
            [sizingMessagesTableViewCell setNeedsLayout];
            [sizingMessagesTableViewCell layoutIfNeeded];
            CGSize size = [sizingMessagesTableViewCell sizeThatFits:CGSizeMake(width, 0)];
            return size.height + 1.0f;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
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

#pragma mark - Dynamic getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

- (MessagesFormView *)messagesFormView {
    if (!_messagesFormView) {
        _messagesFormView = [[MessagesFormView alloc] init];
    }
    return _messagesFormView;
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

@end
