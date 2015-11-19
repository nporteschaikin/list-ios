//
//  EventsDataSource.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventsDataSource.h"

@interface EventsDataSource ()

@property (strong, nonatomic) EventsController *eventsController;

@end

@implementation EventsDataSource

- (instancetype)initWithEventsController:(EventsController *)eventsController {
    if (self = [super init]) {
        self.eventsController = eventsController;
    }
    return self;
}

- (void)registerReuseIdentifiersForCollectionView:(UICollectionView *)collectionView {
    //[collectionView registerClass:[EventsCollectionViewCell class] forCellWithReuseIdentifier:kEventsCollectionViewCellReuseIdentifier];
}

@end
