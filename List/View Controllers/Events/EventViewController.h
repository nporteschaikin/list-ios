//
//  EventViewController.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "EventController.h"

@interface EventViewController : ListUIViewController <EventControllerDelegate>

@property (strong, nonatomic, readonly) EventController *eventController;

- (instancetype)initWithEvent:(Event *)event session:(Session *)session;

@end
