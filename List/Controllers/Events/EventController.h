//
//  EventController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "Session.h"

@class EventController;

@protocol EventControllerDelegate <NSObject>

@optional;
- (void)eventControllerDidFetchEvent:(EventController *)eventController;
- (void)eventController:(EventController *)eventController failedToFetchEventWithError:(NSError *)error;
- (void)eventController:(EventController *)eventController failedToFetchEventWithResponse:(id<NSObject>)response;
- (void)eventControllerDidSaveEvent:(EventController *)eventController;
- (void)eventControllerIsSavingEvent:(EventController *)eventController bytesWritten:(NSInteger)bytesWritten bytesExpectedToWrite:(NSInteger)bytesExpectedToWrite;
- (void)eventController:(EventController *)eventController failedToSaveEventWithError:(NSError *)error;
- (void)eventController:(EventController *)eventController failedToSaveEventWithResponse:(id<NSObject>)response;

@end

@interface EventController : NSObject

@property (weak, nonatomic) id<EventControllerDelegate> delegate;
@property (strong, nonatomic, readonly) Event *event;
@property (strong, nonatomic, readonly) Session *session;

- (instancetype)initWithEvent:(Event *)event session:(Session *)session;
- (void)saveEvent;

@end
