//
//  ThreadViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/28/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ThreadViewController.h"
#import "UserViewController.h"
#import "PostController.h"
#import "ThreadDataSource.h"
#import "MessagesFormView.h"
#import "ActivityIndicatorOverlay.h"
#import "Constants.h"
#import "UIColor+List.h"
#import "UIFont+List.h"
#import "NSDate+TimeAgo.h"

@interface ThreadViewController () <PostControllerDelegate, UITableViewDelegate, ListTableViewCellDelegate>

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) Thread *thread;
@property (strong, nonatomic) PostController *postController;
@property (strong, nonatomic) ThreadDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) MessagesFormView *messagesFormView;
@property (strong, nonatomic) ActivityIndicatorOverlay *activityIndicatorOverlay;

@end

@implementation ThreadViewController

- (instancetype)initWithThread:(Thread *)thread inPost:(Post *)post session:(Session *)session {
    if (self = [super init]) {
        self.session = session;
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
    [self.view insertSubview:self.activityIndicatorOverlay
                aboveSubview:self.tableView];
    
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
    self.activityIndicatorOverlay.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
    
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
    
    self.activityIndicatorOverlay.hidden = YES;
    
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
    
    self.activityIndicatorOverlay.hidden = YES;
    
}

- (void)postController:(PostController *)postController failedToAddMessage:(Message *)message toThread:(Thread *)thread withResponse:(id<NSObject>)response {
    
    /*
     * Stop animating activity.
     */
    
    self.activityIndicatorOverlay.hidden = YES;
    
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
    
    self.activityIndicatorOverlay.hidden = NO;
    
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
    Thread *thread = self.thread;
    NSArray *messages = thread.messages;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    CGFloat width = CGRectGetWidth(tableView.bounds);
    CGFloat height = 0.0f;
    CGFloat w;
    CGFloat h;
    CGSize size;
    CGRect rect;
    NSString *string;
    UIFont *font;
    
    switch (section) {
        case ThreadDataSourceSectionsThread: {
            
            /*
             * Threads cell.
             */
            
            User *user = thread.user;
            height = ThreadsTableViewCellPadding;
            string = [NSString stringWithFormat:@"%@ %@", user.displayName, thread.content];
            w = width - ((ThreadsTableViewCellPadding * 3) + ThreadsTableViewCellAvatarImageViewSize);
            size = CGSizeMake(w, CGFLOAT_MAX);
            font = [UIFont list_threadsTableViewCellUserNameFont];
            rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
            h = rect.size.height;
            height += fmaxf(h + [UIFont list_threadsTableViewCellDateFont].lineHeight + 2.0f, ThreadsTableViewCellAvatarImageViewSize);
            height += ThreadsTableViewCellPadding;
            return height;
            
        }
        case ThreadDataSourceSectionsMessages: {
            
            /*
             * Messages cell.
             */
            
            Message *message = messages[row];
            User *user = message.user;
            height = MessagesTableViewCellPadding;
            string = [NSString stringWithFormat:@"%@ %@", user.displayName, message.content];
            w = width - (MessagesTableViewCellPadding * 3) + MessagesTableViewCellAvatarImageViewSize;
            size = CGSizeMake(w, CGFLOAT_MAX);
            font = [UIFont list_messagesTableViewCellUserNameFont];
            rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
            h = rect.size.height;
            height += fmaxf(h + [UIFont list_messagesTableViewCellDateFont].lineHeight + 2.0f, MessagesTableViewCellAvatarImageViewSize);
            height += MessagesTableViewCellPadding;
            return height;
            
        }
    }
    
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

#pragma mark - ListTableViewCellDelegate

- (void)listTableViewCell:(ListTableViewCell *)cell viewTapped:(UIView *)view point:(CGPoint)point {
    Thread *thread = self.thread;
    NSArray *messages = thread.messages;
    NSIndexPath *indexPath = cell.indexPath;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    UIViewController *viewController;
    
    switch (section) {
        case ThreadDataSourceSectionsThread: {
            
            /*
             * Threads cell.
             */
            
            ThreadsTableViewCell *threadsCell = (ThreadsTableViewCell *)cell;
            
            if (view == threadsCell.avatarImageView) {
                
                // User
                User *user = thread.user;
                viewController = [[UserViewController alloc] initWithUser:user session:self.session];
                
            } else if (view == threadsCell.contentLabel) {
                
                UILabel *contentLabel = threadsCell.contentLabel;
                CGPoint labelPoint = [contentLabel convertPoint:point fromView:cell];
                
                // layout manager
                NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:contentLabel.attributedText];
                NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
                [textStorage addLayoutManager:layoutManager];
                
                // text container
                NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:contentLabel.frame.size];
                textContainer.lineFragmentPadding = 0;
                textContainer.maximumNumberOfLines = 0;
                textContainer.lineBreakMode = contentLabel.lineBreakMode;
                [layoutManager addTextContainer:textContainer];
                
                // character index
                NSUInteger characterIndex = [layoutManager characterIndexForPoint:labelPoint inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
                if (characterIndex < thread.user.displayName.length) {
                    
                    // user
                    User *user = thread.user;
                    viewController = [[UserViewController alloc] initWithUser:user session:self.session];
                    
                }
                
            }
            
            break;
        }
            
        case ThreadDataSourceSectionsMessages: {
            
            /*
             * Messages cell.
             */
            
            MessagesTableViewCell *messagesCell = (MessagesTableViewCell *)cell;
            Message *message = messages[row];
            
            if (view == messagesCell.avatarImageView) {
                
                // User
                User *user = message.user;
                viewController = [[UserViewController alloc] initWithUser:user session:self.session];
                
            } else if (view == messagesCell.contentLabel) {
                
                UILabel *contentLabel = messagesCell.contentLabel;
                CGPoint labelPoint = [contentLabel convertPoint:point fromView:cell];
                
                // layout manager
                NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:contentLabel.attributedText];
                NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
                [textStorage addLayoutManager:layoutManager];
                
                // text container
                NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:contentLabel.frame.size];
                textContainer.lineFragmentPadding = 0;
                textContainer.maximumNumberOfLines = 0;
                textContainer.lineBreakMode = contentLabel.lineBreakMode;
                [layoutManager addTextContainer:textContainer];
                
                // character index
                NSUInteger characterIndex = [layoutManager characterIndexForPoint:labelPoint inTextContainer:textContainer fractionOfDistanceBetweenInsertionPoints:NULL];
                if (characterIndex < thread.user.displayName.length) {
                    
                    // user
                    User *user = message.user;
                    viewController = [[UserViewController alloc] initWithUser:user session:self.session];
                    
                }
                
            }
            
            break;
            
        }
    }
    
    /*
     * Push view controller if one exists.
     */
    
    if (viewController) {
        [self presentViewController:viewController animated:YES completion:nil];
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

- (ActivityIndicatorOverlay *)activityIndicatorOverlay {
    if (!_activityIndicatorOverlay) {
        _activityIndicatorOverlay = [[ActivityIndicatorOverlay alloc] init];
        _activityIndicatorOverlay.hidden = YES;
    }
    return _activityIndicatorOverlay;
}

@end
