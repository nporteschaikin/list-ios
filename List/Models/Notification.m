//
//  Notification.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Notification.h"

@implementation Notification

- (void)applyDict:(NSDictionary *)dict {
    
    NSString *type = dict[@"type"];
    if ([type isEqualToString:@"ThreadNotification"]) {
        self.type = NotificationTypeThread;
    } else if ([type isEqualToString:@"PostNotification"]) {
        self.type = NotificationTypePost;
    } else if ([type isEqualToString:@"UserNotification"]) {
        self.type = NotificationTypeUser;
    }
    
    NSString *action = dict[@"action"];
    if ([action isEqualToString:@"create"]) {
        self.action = NotificationActionCreate;
    }
    
    if (dict[@"createdAt"]) {
        NSDateFormatter *dateFormatter = [NSDateFormatter ISO8601formatter];
        NSDate *createdAtDate = [dateFormatter dateFromString:[dict[@"createdAt"] ISO8601FormattedString]];
        self.createdAtDate = createdAtDate;
    }
    
    /*
     * Create nested user.
     */
    
    if ([dict[@"user"] isKindOfClass:[NSDictionary class]]) {
        self.user = [User fromDict:dict[@"user"]];
    }
    
    /*
     * Create nested actor.
     */
    
    if ([dict[@"actor"] isKindOfClass:[NSDictionary class]]) {
        self.actor = [User fromDict:dict[@"actor"]];
    }
    
    /*
     * Create nested post.
     */
    
    if ([dict[@"post"] isKindOfClass:[NSDictionary class]]) {
        self.post = [Post fromDict:dict[@"post"]];
    }
    
    /*
     * Create nested thread.
     */
    
    if ([dict[@"thread"] isKindOfClass:[NSDictionary class]]) {
        self.thread = [Thread fromDict:dict[@"thread"]];
    }
    
}

@end
