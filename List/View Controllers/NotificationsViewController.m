//
//  NotificationsViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NotificationsViewController.h"
#import "PostViewController.h"
#import "UserViewController.h"
#import "ActivityIndicatorView.h"
#import "UIColor+List.h"
#import "Constants.h"

@interface NotificationsViewController () <NotificationsControllerDelegate, UITableViewDelegate>

@property (strong, nonatomic) NotificationsController *notificationsController;
@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NotificationsDataSource *dataSource;
@property (strong, nonatomic) ActivityIndicatorView *activityIndicatorView;

@end

@implementation NotificationsViewController

- (instancetype)initWithNotificationsController:(NotificationsController *)notificationsController
                                        session:(Session *)session {
    if (self = [super init]) {
        self.notificationsController = notificationsController;
        self.notificationsController.delegate = self;
        self.session = session;
        self.dataSource = [[NotificationsDataSource alloc] initWithNotificationsController:self.notificationsController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Set background color.
     */
    
    self.view.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    
    /*
     * Add subviews.
     */
    
    [self.view addSubview:self.tableView];
    [self.view insertSubview:self.activityIndicatorView
                belowSubview:self.tableView];
    
    /*
     * Set up table view.
     */
    
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor list_lightGrayColorAlpha:1];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    /*
     * Hide table view.
     */
    
    //self.tableView.hidden = YES;
    
    /*
     * Start animating.
     */
    
    [self.activityIndicatorView startAnimating];
    
    /*
     * Request notifications.
     */
    
    [self.notificationsController requestNotifications];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat x, y, w, h;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.tableView.frame = CGRectMake(x, y, w, h);
    
    x = CGRectGetMidX(self.view.bounds) - (ActivityIndicatorViewDefaultSize / 2);
    y = CGRectGetMidY(self.view.bounds) - (ActivityIndicatorViewDefaultSize / 2);
    w = ActivityIndicatorViewDefaultSize;
    h = ActivityIndicatorViewDefaultSize;
    self.activityIndicatorView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - NotificationsControllerDelegate

- (void)notificationsControllerDidFetchNotifications:(NotificationsController *)notificationsController {
    
    /*
     * Show table view.
     */
    
    self.tableView.hidden = NO;
    
    /*
     * Reload table.
     */
    
    [self.tableView reloadData];
    
}

- (void)notificationsController:(NotificationsController *)notificationsController failedToFetchNotificationsWithError:(NSError *)error {
    
    /*
     * Stop animating.
     */
    
    [self.activityIndicatorView stopAnimating];
    
}

- (void)notificationsController:(NotificationsController *)notificationsController failedToFetchNotificationsWithResponse:(id<NSObject>)response {
    
    /*
     * Stop animating.
     */
    
    [self.activityIndicatorView stopAnimating];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NotificationsTableViewCell *sizingCell;
    if (!sizingCell) {
        sizingCell = (NotificationsTableViewCell *)[self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    CGFloat width = CGRectGetWidth(tableView.bounds);
    sizingCell.frame = CGRectMake(0.0f, 0.0f, width, 0.0f);
    sizingCell.contentLabel.attributedText = [self.dataSource attributedStringForNotificationAtIndexPath:indexPath];
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell sizeThatFits:CGSizeMake(width, 0.0f)];
    return size.height + 1.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*
     * Display the right controller.
     */
    
    Notification *notification = self.notificationsController.notifications[indexPath.row];
    UIViewController *viewController;
    switch (notification.type) {
        case NotificationTypePost:
        case NotificationTypeThread: {
            Post *post = notification.post;
            viewController = [[PostViewController alloc] initWithPost:post
                                                              session:self.session];
            break;
        }
        case NotificationTypeUser: {
            User *user = notification.user;
            viewController = [[UserViewController alloc] initWithUser:user
                                                              session:self.session];
        }
    }
    if (viewController) {
        [self presentViewController:viewController
                           animated:YES
                         completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     * Style cell.
     */
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    
}

#pragma mark - Dynamic getters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor list_lightGrayColorAlpha:1];
    }
    return _tableView;
}

- (ActivityIndicatorView *)activityIndicatorView {
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[ActivityIndicatorView alloc] initWithStyle:ActivityIndicatorViewStyleBlue];
    }
    return _activityIndicatorView;
}

@end
