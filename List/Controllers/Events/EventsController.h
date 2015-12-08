//
//  EventsController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "Paging.h"
#import "Tag.h"
#import "Session.h"
#import "MapCircle.h"

@class EventsController;

@protocol EventsControllerDelegate <NSObject>

@optional
- (void)eventsControllerDidFetchEvents:(EventsController *)eventsController;
- (void)eventsController:(EventsController *)eventsController didInsertEvents:(NSArray *)events intoEvents:(NSArray *)prevEvents;
- (void)eventsController:(EventsController *)eventsController failedToFetchEventsWithError:(NSError *)error;
- (void)eventsController:(EventsController *)eventsController failedToFetchEventsWithResponse:(id<NSObject>)response;

@end;

@interface EventsController : NSObject

@property (weak, nonatomic) id<EventsControllerDelegate> delegate;

#pragma mark - Result properties
@property (copy, nonatomic, readonly) NSArray *events;
@property (copy, nonatomic, readonly) NSArray *tags;
@property (strong, nonatomic, readonly) Paging *paging;
@property (strong, nonatomic, readonly) Placemark *placemark;

#pragma mark - Query properties
@property (strong, nonatomic) MapCircle *mapCircle;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSDate *afterDate;
@property (strong, nonatomic) Event *start;

- (id)initWithSession:(Session *)session;
- (void)requestEvents;
- (void)insertEvents;

@end
