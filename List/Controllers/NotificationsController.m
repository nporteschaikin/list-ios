//
//  NotificationsController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/24/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "NotificationsController.h"
#import "APIRequest.h"
#import "Constants.h"

@interface NotificationsController ()

@property (strong, nonatomic) Session *session;
@property (copy, nonatomic) NSArray *notifications;

@end

@implementation NotificationsController

- (id)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
    }
    return self;
}

- (void)requestNotifications {
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodGET;
    request.endpoint = APINotificationsEndpoint;
    request.session = self.session;
    
    /*
     * Send request.
     */
    
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update post.
         */
        
        self.notifications = [Notification fromJSONArray:(NSArray *)body];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(notificationsControllerDidFetchNotifications:)]) {
            [self.delegate notificationsControllerDidFetchNotifications:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(notificationsController:failedToFetchNotificationsWithError:)]) {
            [self.delegate notificationsController:self failedToFetchNotificationsWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(notificationsController:failedToFetchNotificationsWithResponse:)]) {
            [self.delegate notificationsController:self failedToFetchNotificationsWithResponse:body];
        }
        
    }];
}

@end
