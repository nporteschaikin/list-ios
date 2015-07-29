//
//  Notification.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "Notification.h"
#import "NSDate+ISO8601.h"

@implementation Notification

- (void)applyJSON:(NSDictionary *)JSON {
    NSString *type = JSON[@"type"];
    if ([type isEqualToString:@"ThreadNotification"]) {
        self.type = NotificationTypeThread;
    } else if ([type isEqualToString:@"PostNotification"]) {
        self.type = NotificationTypePost;
    } else if ([type isEqualToString:@"UserNotification"]) {
        self.type = NotificationTypeUser;
    }
    
    NSString *action = JSON[@"action"];
    if ([action isEqualToString:@"create"]) {
        self.action = NotificationActionCreate;
    }
    
    self.createdAtDate = [NSDate dateWithISO8601:JSON[@"createdAt"]];
    if ([JSON[@"actor"] isKindOfClass:[NSDictionary class]]) self.actor = [User fromJSONDict:JSON[@"actor"]];
    if ([JSON[@"post"] isKindOfClass:[NSDictionary class]]) self.post = [Post fromJSONDict:JSON[@"post"]];
    if ([JSON[@"user"] isKindOfClass:[NSDictionary class]]) self.user = [User fromJSONDict:JSON[@"user"]];
    if ([JSON[@"thread"] isKindOfClass:[NSDictionary class]]) self.thread = [Thread fromJSONDict:JSON[@"thread"]];
}

@end
