//
//  PostViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/16/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "PostViewController.h"
#import "PostDataSource.h"
#import "PostController.h"
#import "UserViewController.h"
#import "ThreadViewController.h"
#import "LIconControl.h"
#import "ThreadsFormView.h"
#import "APIRequest.h"
#import "Constants.h"
#import "ActivityIndicatorOverlay.h"
#import "UIColor+List.h"
#import "UIFont+List.h"
#import "NSDate+TimeAgo.h"
#import "NSDateFormatter+List.h"

@interface PostViewController () <PostControllerDelegate, UITableViewDelegate, ListTableViewCellDelegate>

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) PostDataSource *dataSource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) LIconControl *closeControl;
@property (strong, nonatomic) ThreadsFormView *threadsFormView;
@property (strong, nonatomic) ActivityIndicatorOverlay *activityIndicatorOverlay;
@property (strong, nonatomic) PostController *postController;

@end

@implementation PostViewController

static CGFloat const PostViewControllerCloseControlSize = 40.f;
static CGFloat const PostViewControllerCloseControlMargin = 12.f;

- (id)initWithPost:(Post *)post session:(Session *)session {
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
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.threadsFormView];
    [self.view insertSubview:self.activityIndicatorOverlay
                aboveSubview:self.tableView];
    [self.view addSubview:self.closeControl];
    
    /*
     * Add data source to table view.
     */
    
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    
    /*
     * Setup table view.
     */
    
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor list_grayColorAlpha:0.4];
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
    self.activityIndicatorOverlay.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMinX(self.view.bounds);
    y = CGRectGetMinY(self.view.bounds);
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
    
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

//- (void)presentOptionsAlertController {
//    UIAlertController *alertController = [[UIAlertController alloc] init];
//    PostController *postController = self.postController;
//    Post *post = postController.post;
//    User *user = post.user;
//    User *currentUser = self.session.user;
//    
//    if ([currentUser isEqual:user]) {
//        
//        /*
//         * Add edit post action.
//         */
//        
//        UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            PostEditorViewController *viewController = [[PostEditorViewController alloc] initWithPost:post session:self.session];
//            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
//            [self presentViewController:navigationController animated:YES completion:nil];
//        }];
//        [alertController addAction:editAction];
//        
//        /*
//         * Add delete post action.
//         */
//        
//        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//            [self.postController deletePost];
//        }];
//        [alertController addAction:deleteAction];
//        
//    }
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        [alertController dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [alertController addAction:cancelAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//}

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
    
    self.activityIndicatorOverlay.hidden = YES;
    
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
    
    self.activityIndicatorOverlay.hidden = YES;
    
}

- (void)postController:(PostController *)postController failedToAddThread:(Thread *)thread toPostWithResponse:(id<NSObject>)response {
    
    /*
     * Stop animating activity.
     */
    
    self.activityIndicatorOverlay.hidden = YES;
    
}

- (void)postControllerDidDeletePost:(PostController *)postController {
    
    /*
     * Stop animating activity.
     */
    
    self.activityIndicatorOverlay.hidden = YES;
    
    /*
     * Dismiss this.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = self.postController.post;
    PostType type = post.type;
    NSArray *threads = post.threads;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    CGFloat width = CGRectGetWidth(tableView.bounds);
    CGFloat height = 0.0f;
    CGFloat w;
    CGFloat h;
    CGSize size;
    CGRect rect;
    NSString *string;
    UIFont *font;
    switch (section) {
        case PostDataSourceSectionDetails: {
            switch (row) {
                case PostDataSourceRowCoverPhoto: {
                    
                    /*
                     * Cover cell.
                     */
                    
                    return width * CoverPhotoHeightMultiplier;
                    
                }
                case PostDataSourceRowHeader: {
                    
                    /*
                     * Header cell.
                     */
                    
                    height = PostViewHeaderCellPadding;
                    height += PostHeaderViewAvatarImageViewSize;
                    height += PostViewHeaderCellPadding;
                    return height;
                    
                }
            }
            switch (type) {
                case PostTypeEvent: {
                    Event *event = post.event;
                    w = width - (ListIconTableViewIconViewSize + (ListIconTableViewCellPaddingX * 2));
                    size = CGSizeMake(w, CGFLOAT_MAX);
                    height += ListIconTableViewCellPaddingY;
                    switch (row) {
                        case PostDataSourceRowEventTime:  {
                            string = [[NSDateFormatter list_defaultDateFormatter] stringFromDate:event.startTime];
                            font = [UIFont list_listIconTableViewCellFont];
                            rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
                            height += fmaxf(ListIconTableViewIconViewSize, rect.size.height);
                            height += ListIconTableViewCellPaddingY;
                            return height;
                        }
                        case PostDataSourceRowEventPlace: {
                            string = event.place;
                            font = [UIFont list_listIconTableViewCellFont];
                            rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
                            height += fmaxf(ListIconTableViewIconViewSize, rect.size.height);
                            height += ListIconTableViewCellPaddingY;
                            return height;
                        }
                            
                    }
                }
                default: {
                    break;
                }
            }
            break;
        }
        case PostDataSourceSectionContent: {
            
            /*
             * Content cell.
             */
            
            height += PostViewContentCellPadding;
            string = post.content;
            w = width - (PostViewContentCellPadding * 2);
            size = CGSizeMake(w, CGFLOAT_MAX);
            font = [UIFont list_postContentFont];
            rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: font } context:nil];
            height += rect.size.height;
            height += PostViewContentCellPadding;
            return height;
            
        }
        case PostDataSourceSectionThreads: {
            
            /*
             * Threads cell.
             */
            
            Thread *thread = threads[row];
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
    }
    return 1.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ListTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    Post *post = self.postController.post;
    PostType type = post.type;
    switch (section) {
        case PostDataSourceSectionContent:
        case PostDataSourceSectionThreads: {
            if (type == PostTypePost) {
                return 0.f;
            }
            return 20.0f;
        }
        default: {
            return 0.0f;
        }
    }
}

#pragma mark - ListTableViewCellDelegate

- (void)listTableViewCell:(ListTableViewCell *)cell viewTapped:(UIView *)view point:(CGPoint)point {
    Post *post = self.postController.post;
    NSArray *threads = post.threads;
    NSIndexPath *indexPath = cell.indexPath;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    UIViewController *viewController;
    
    switch (section) {
        case PostDataSourceSectionDetails: {
            switch (row) {
                case PostDataSourceRowHeader: {
                    
                    /*
                     * Header row.
                     */
                    
                    PostViewHeaderCell *headerCell = (PostViewHeaderCell *)cell;
                    PostHeaderView *headerView = headerCell.headerView;
                    
                    if (view == headerView.avatarImageView || view == headerView.userNameLabel) {
                        
                        // User
                        User *user = post.user;
                        viewController = [[UserViewController alloc] initWithUser:user session:self.session];
                        
                    }
                    
                    break;
                }
                default: {
                    break;
                }
            }
            break;
        }
        case PostDataSourceSectionThreads: {
            
            /*
             * Threads cell.
             */
            
            ThreadsTableViewCell *threadsCell = (ThreadsTableViewCell *)cell;
            Thread *thread = threads[row];
            
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
                    
                } else {
                    
                    // thread
                    ThreadViewController *threadViewController = [[ThreadViewController alloc] initWithThread:thread inPost:post session:self.session];
                    viewController = [[UINavigationController alloc] initWithRootViewController:threadViewController];
                    
                }
                
            } else {
                
                // thread
                ThreadViewController *threadViewController = [[ThreadViewController alloc] initWithThread:thread inPost:post session:self.session];
                viewController = [[UINavigationController alloc] initWithRootViewController:threadViewController];
                
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = scrollView.contentOffset;
    CGFloat Y = contentOffset.y;
    
    if (Y < 0) {
        
        /*
         * Stretch cover photo.
         */
        
        ListCoverPhotoCell *cell = (ListCoverPhotoCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UIImageView *photoView = cell.photoView;
        CGRect frame = photoView.frame;
        frame.origin.y = Y;
        frame.size.height = (frame.size.width * CoverPhotoHeightMultiplier) + fabs(Y);
        photoView.frame = frame;
    }
    
    /*
     * Move close control
     */
    
    LIconControl *closeControl = self.closeControl;
    CGRect frame = closeControl.frame;
    frame.origin.y = (CGRectGetMinY( [UIScreen mainScreen].applicationFrame ) + PostViewControllerCloseControlMargin) - (Y > 0 ? Y : 0);
    closeControl.frame = frame;
    
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

- (ActivityIndicatorOverlay *)activityIndicatorOverlay {
    if (!_activityIndicatorOverlay) {
        _activityIndicatorOverlay = [[ActivityIndicatorOverlay alloc] init];;
        _activityIndicatorOverlay.hidden = YES;
    }
    return _activityIndicatorOverlay;
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
    
    self.activityIndicatorOverlay.hidden = NO;
    
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
