//
//  EventsViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventsViewController.h"
#import "ListConstants.h"
#import "EventsDataSource.h"

@interface EventsViewController ()

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) EventsController *eventsController;
@property (strong, nonatomic) EventsDataSource *dataSource;

@end

@implementation EventsViewController

- (instancetype)initWithSession:(Session *)session {
    if (self = [super init]) {
        self.session = session;
        
        /*
         * Create events controller.
         */
        
        self.eventsController = [[EventsController alloc] init];
        self.eventsController.delegate = self;
        
        /*
         * Create data source.
         */
        
        self.dataSource = [[EventsDataSource alloc] initWithEventsController:self.eventsController];
        
    }
    return self;
}

@end
