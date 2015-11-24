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

static NSString * const kEventsCollectionViewCellReuseIdentifier = @"kEventsCollectionViewCellReuseIdentifier";

- (instancetype)initWithEventsController:(EventsController *)eventsController {
    if (self = [super init]) {
        self.eventsController = eventsController;
    }
    return self;
}

- (void)registerReuseIdentifiersForCollectionView:(UICollectionView *)collectionView {
    [collectionView registerClass:[EventsCollectionViewCell class] forCellWithReuseIdentifier:kEventsCollectionViewCellReuseIdentifier];
}

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    EventsController *eventsController = self.eventsController;
    NSArray *events = eventsController.events;
    Event *event = events[row];
    EventsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEventsCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = event.title;
    cell.timeLabel.text = @"Today at 9pm";
    cell.descriptionLabel.text = event.text;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    EventsController *eventsController = self.eventsController;
    NSArray *events = eventsController.events;
    return events.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

@end
