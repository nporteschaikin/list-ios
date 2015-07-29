//
//  NotificationsTableViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NotificationsTableViewController.h"
#import "PostViewController.h"
#import "UserViewController.h"
#import "UIColor+List.h"

@interface NotificationsTableViewController () <NotificationsControllerDelegate>

@property (strong, nonatomic) NotificationsController *notificationsController;
@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) NotificationsDataSource *dataSource;

@end

@implementation NotificationsTableViewController

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
     * Set up table view.
     */
    
    [self.dataSource registerReuseIdentifiersForTableView:self.tableView];
    self.tableView.dataSource = self.dataSource;
    self.tableView.separatorColor = [UIColor list_lightGrayColorAlpha:1];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        self.tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    /*
     * Request notifications.
     */
    
    [self.notificationsController requestNotifications];
    
}

#pragma mark - NotificationsControllerDelegate

- (void)notificationsControllerDidFetchNotifications:(NotificationsController *)notificationsController {
    
    /*
     * Reload table.
     */
    
    [self.tableView reloadData];
    
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

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     * Style cell.
     */
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    
}

@end
