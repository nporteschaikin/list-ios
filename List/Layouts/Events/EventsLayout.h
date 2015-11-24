//
//  EventsLayout.h
//  List
//
//  Created by Noah Portes Chaikin on 11/19/15.
//  Copyright © 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "EventsController.h"

@interface EventsLayout : UICollectionViewFlowLayout

- (instancetype)initWithEventsController:(EventsController *)eventsController;

@end
