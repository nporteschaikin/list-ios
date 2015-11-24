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
#import "EventsLayout.h"

@interface EventsViewController ()

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) EventsController *eventsController;
@property (strong, nonatomic) EventsDataSource *dataSource;
@property (strong, nonatomic) EventsLayout *layout;

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

- (void)loadView {
    [super loadView];
    
    /*
     * Set view background.
     */
    
    self.view.backgroundColor = [UIColor listBlackColorAlpha:1];
    
    /*
     * Create default layout.
     */
    
    EventsLayout *layout = self.layout = [[EventsLayout alloc] initWithEventsController:self.eventsController];
    
    /*
     * Create collection view.
     */
    
    UICollectionView *collectionView = self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.dataSource = self.dataSource;
    collectionView.backgroundColor = [UIColor listLightGrayColorAlpha:1];
    [self.view addSubview:collectionView];
    
}

- (void)viewDidLoad {
    
    /*
     * Register class for reuse identifier.
     */
    
    UICollectionView *collectionView = self.collectionView;
    [self.dataSource registerReuseIdentifiersForCollectionView:collectionView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Perform request.
     */
    
    [self.eventsController requestEvents];
    
}

- (void)viewWillLayoutSubviews {
    
    /*
     * Lay out photo view.
     */
    
    CGFloat x, y, w, h;
    x = 0.0f;
    y = 0.0f;
    w = CGRectGetWidth(self.view.bounds);
    h = CGRectGetHeight(self.view.bounds);
    self.collectionView.frame = CGRectMake(x, y, w, h);
    
}

#pragma mark - EventsControllerDelegate

- (void)eventsControllerDidFetchEvents:(EventsController *)eventsController {
    
    /*
     * Reload data.
     */
    
    [self.collectionView reloadData];
    
}

@end
