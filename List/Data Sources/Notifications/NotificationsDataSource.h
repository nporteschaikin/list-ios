//
//  NotificationsDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationsController.h"
#import "NotificationsTableViewCell.h"

@interface NotificationsDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic, readonly) NotificationsController *notificationsController;

- (instancetype)initWithNotificationsController:(NotificationsController *)notificationsController NS_DESIGNATED_INITIALIZER;
- (void)registerReuseIdentifiersForTableView:(UITableView *)tableView;
- (NSAttributedString *)attributedStringForNotificationAtIndexPath:(NSIndexPath *)indexPath;

@end
