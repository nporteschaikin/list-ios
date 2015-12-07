//
//  EventsController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "Tag.h"
#import "Session.h"
#import "MapCircle.h"

@class EventsController;

@protocol EventsControllerDelegate <NSObject>

@optional
- (void)eventsControllerDidFetchEvents:(EventsController *)eventsController;
- (void)eventsController:(EventsController *)eventsController failedToFetchEventsWithError:(NSError *)error;
- (void)eventsController:(EventsController *)eventsController failedToFetchEventsWithResponse:(id<NSObject>)response;

@end;

@interface EventsController : NSObject

@property (weak, nonatomic) id<EventsControllerDelegate> delegate;
@property (copy, nonatomic, readonly) NSArray *events;
@property (copy, nonatomic, readonly) NSArray *tags;
@property (strong, nonatomic, readonly) Placemark *placemark;
@property (strong, nonatomic) MapCircle *mapCircle;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSDate *afterDate;

- (id)initWithSession:(Session *)session;
- (void)requestEvents;

@end
