//
//  NotificationsController.h
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"
#import "Session.h"

@class NotificationsController;

@protocol NotificationsControllerDelegate <NSObject>

@optional
- (void)notificationsControllerDidFetchNotifications:(NotificationsController *)notificationsController;
- (void)notificationsController:(NotificationsController *)notificationsController failedToFetchNotificationsWithError:(NSError *)error;
- (void)notificationsController:(NotificationsController *)notificationsController failedToFetchNotificationsWithResponse:(id<NSObject>)response;

@end

@interface NotificationsController : NSObject

@property (weak, nonatomic) id<NotificationsControllerDelegate> delegate;
@property (strong, nonatomic, readonly) Session *session;
@property (copy, nonatomic, readonly) NSArray *notifications;

- (id)initWithSession:(Session *)session NS_DESIGNATED_INITIALIZER;
- (void)requestNotifications;

@end
