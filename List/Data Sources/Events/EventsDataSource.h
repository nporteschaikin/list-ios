//
//  EventsDataSource.h
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "ListUIKit.h"
#import "EventsController.h"

@interface EventsDataSource : NSObject

- (instancetype)initWithEventsController:(EventsController *)eventsController;
- (void)registerReuseIdentifiersForCollectionView:(UICollectionView *)collectionView;

@end