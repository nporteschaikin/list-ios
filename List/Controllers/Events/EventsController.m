//
//  EventsController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventsController.h"
#import "APIRequest.h"
#import "ListConstants.h"
#import "NSDateFormatter+ListAdditions.h"

@interface EventsController ()

@property (strong, nonatomic) Session *session;
@property (copy, nonatomic) NSArray *events;
@property (copy, nonatomic) NSArray *tags;
@property (copy, nonatomic) NSArray *dates;
@property (strong, nonatomic) Placemark *placemark;

@end

@implementation EventsController

- (id)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
    }
    return self;
}

- (void)requestEvents {
    
    /*
     * Create request.
     */
    
    APIRequest *request = [[APIRequest alloc] init];
    request.method = APIRequestMethodGET;
    request.endpoint = kAPIEventsEndpoint;
    request.session = self.session;
    
    /*
     * Build query.
     */
    
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    
    // User
    if (self.user) {
        query[@"user"] = self.user.userID;
    }
    
    // Map circle
    if (self.mapCircle) {
        MapCircle *mapCircle = self.mapCircle;
        CLLocation *location = mapCircle.location;
        float radius = mapCircle.radius;
        if (location) {
            CLLocationCoordinate2D coordinate = location.coordinate;
            query[@"latitude"] = [[NSNumber numberWithDouble:coordinate.latitude] stringValue];
            query[@"longitude"] = [[NSNumber numberWithDouble:coordinate.longitude] stringValue];
        }
        if (radius) {
            query[@"radius"] = [NSString stringWithFormat:@"%f", radius];
        }
    }
    
    // After date
    if (self.afterDate) {
        NSDate *afterDate = self.afterDate;
        NSDateFormatter *formatter = [NSDateFormatter list_ISO8601formatter];
        query[@"after"] = [formatter stringFromDate:afterDate];
    }
    
    /*
     * Set query.
     */
    
    request.query = query;
    [request sendRequest:^(id<NSObject> body) {
        
        /*
         * Add events, tags, and placemark.
         */
        
        self.events = [Event fromJSONArray:(NSArray *)body[kAPIEventsKey]];
        self.tags = [Tag fromJSONArray:(NSArray *)body[kAPITagsKey]];
        self.placemark = [Placemark fromJSONDict:(NSDictionary *)body[kAPIPlacemarkKey]];
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(eventsControllerDidFetchEvents:)]) {
            [self.delegate eventsControllerDidFetchEvents:self];
        }
        
    } onError:^(NSError *error) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(eventsController:failedToFetchEventsWithError:)]) {
            [self.delegate eventsController:self failedToFetchEventsWithError:error];
        }
        
    } onFail:^(id<NSObject> body) {
        
        /*
         * Send delegate message.
         */
        
        if ([self.delegate respondsToSelector:@selector(eventsController:failedToFetchEventsWithError:)]) {
            [self.delegate eventsController:self failedToFetchEventsWithResponse:body];
        }
        
    }];
    
}

@end
