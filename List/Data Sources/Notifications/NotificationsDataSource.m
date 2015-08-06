//
//  NotificationsDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NotificationsDataSource.h"
#import "UIFont+List.h"
#import "UIColor+List.h"
#import "NSDate+TimeAgo.h"
#import "UIImageView+WebCache.h"

@interface NotificationsDataSource ()

@property (strong, nonatomic) NotificationsController *notificationsController;

@end

@implementation NotificationsDataSource

static NSString * const NotificationsTableViewCellReuseIdentifier = @"NotificationsTableViewCellReuseIdentifier";

- (instancetype)initWithNotificationsController:(NotificationsController *)notificationsController {
    if (self = [super init]) {
        self.notificationsController = notificationsController;
    }
    return self;
}

- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView {
    [tableView registerClass:[NotificationsTableViewCell class]
      forCellReuseIdentifier:NotificationsTableViewCellReuseIdentifier];
}

- (NSAttributedString *)attributedStringForNotificationAtIndexPath:(NSIndexPath *)indexPath {
    Notification *notification = self.notificationsController.notifications[indexPath.row];
    User *actor = notification.actor;
    NSMutableAttributedString *attributedString;
    switch (notification.type) {
        case NotificationTypePost: {
            switch (notification.action) {
                case NotificationActionCreate: {
                    break;
                }
                default: {
                    break;
                }
            }
            break;
        }
        case NotificationTypeThread: {
            Post *post = notification.post;
            switch (notification.action) {
                case NotificationActionCreate: {
                    
                    /*
                     * New thread created.
                     */
                    
                    NSString *string = [NSString stringWithFormat:@"%@ created a thread in %@", actor.displayName, post.title];
                    attributedString = [[NSMutableAttributedString alloc] initWithString:string];
                    
                    [attributedString addAttribute:NSFontAttributeName
                                             value:[UIFont list_notificationsTableViewCellBoldFont]
                                             range:NSMakeRange(0, actor.displayName.length)];
                    [attributedString addAttribute:NSFontAttributeName
                                             value:[UIFont list_notificationsTableViewCellBoldFont]
                                             range:NSMakeRange(string.length - post.title.length, post.title.length)];
                    
                    break;
                }
                default: {
                    break;
                }
            }
            break;
        }
        case NotificationTypeUser: {
            switch (notification.action) {
                case NotificationActionCreate: {
                    break;
                }
                default: {
                    break;
                }
            }
            break;
        }
    }
    return attributedString;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NotificationsTableViewCellReuseIdentifier];
    Notification *notification = self.notificationsController.notifications[indexPath.row];
    cell.contentLabel.attributedText = [self attributedStringForNotificationAtIndexPath:indexPath];
    [cell.contentLabel sizeToFit];
    cell.dateLabel.text = [notification.createdAtDate timeAgo];
    if (notification.actor.profilePictureURL) {
        [cell.avatarImageView sd_setImageWithURL:notification.actor.profilePictureURL];
    }
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notificationsController.notifications.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
