//
//  Notification.h
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LModel.h"
#import "User.h"
#import "Thread.h"
#import "Post.h"

typedef NS_ENUM(NSUInteger, NotificationType) {
    NotificationTypeThread = 0,
    NotificationTypePost,
    NotificationTypeUser
};

typedef NS_ENUM(NSUInteger, NotificationAction) {
    NotificationActionCreate = 0
};

@interface Notification : LModel

@property (nonatomic) NotificationType type;
@property (nonatomic) NotificationAction action;
@property (strong, nonatomic) User *actor;
@property (strong, nonatomic) Thread *thread;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) NSDate *createdAtDate;

@end
