//
//  EventController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventController.h"
#import "APIRequest.h"
#import "ListConstants.h"
#import "ListConstants.h"

@interface EventController ()

@property (strong, nonatomic) Event *event;
@property (strong, nonatomic) Session *session;

@end

@implementation EventController

- (instancetype)initWithEvent:(Event *)event session:(Session *)session {
    if (self = [super init]) {
        self.event = event;
        self.session = session;
    }
    return self;
}

- (void)saveEvent {
    
    /*
     * Create request.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.method = self.event.eventID ? APIRequestMethodPUT : APIRequestMethodPOST;
    request.endpoint = self.event.eventID ? [NSString stringWithFormat:kAPIEventEndpoint, self.event.eventID] : kAPIEventsEndpoint;
    request.session = self.session;
    request.body = [self.event toJSON];
    
    /*
     * Send request.
     */
    
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Update event.
         */
        
        [self.event applyJSONDict:(NSDictionary *)body[kAPIEventKey]];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(eventControllerDidSaveEvent:)]) {
            [self.delegate eventControllerDidSaveEvent:self];
        }
        
    } onProgress:^(NSInteger bytesWritten, NSInteger bytesExpectedToWrite) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(eventControllerIsSavingEvent:bytesWritten:bytesExpectedToWrite:)]) {
            [self.delegate eventControllerIsSavingEvent:self bytesWritten:bytesWritten bytesExpectedToWrite:bytesExpectedToWrite];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(eventController:failedToSaveEventWithError:)]) {
            [self.delegate eventController:self failedToSaveEventWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(eventController:failedToSaveEventWithError:)]) {
            [self.delegate eventController:self failedToSaveEventWithResponse:body];
        }
        
    }];
    
}

@end
