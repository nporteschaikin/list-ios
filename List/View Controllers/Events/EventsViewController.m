//
//  EventsViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/13/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "EventsViewController.h"
#import "EventViewController.h"
#import "ListConstants.h"
#import "EventsDataSource.h"
#import "EventsLayout.h"
#import "ZoomAnimator.h"

@interface EventsViewController ()

@property (strong, nonatomic) Session *session;
@property (strong, nonatomic) ListCollectionView *collectionView;
@property (strong, nonatomic) EventsController *eventsController;
@property (strong, nonatomic) EventsDataSource *dataSource;
@property (strong, nonatomic) EventsLayout *layout;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) ZoomTransitioningDelegate *zoomTransitioningDelegate;
@property (nonatomic, getter=isInsertingMore) BOOL insertingMore;

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
        
        /*
         * Create transitioning delegate.
         */
        
        self.zoomTransitioningDelegate = [[ZoomTransitioningDelegate alloc] init];
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    /*
     * Create default layout.
     */
    
    EventsLayout *layout = self.layout = [[EventsLayout alloc] initWithEventsController:self.eventsController];
    
    /*
     * Create collection view.
     */
    
    ListCollectionView *collectionView = self.collectionView = [[ListCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.dataSource = self.dataSource;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    /*
     * Create refresh control.
     */
    
    UIRefreshControl *refreshControl = self.refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefreshControl:) forControlEvents:UIControlEventValueChanged];
    [collectionView addSubview:refreshControl];
    
}

- (void)viewDidLoad {
    
    /*
     * Register class for reuse identifier.
     */
    
    ListCollectionView *collectionView = self.collectionView;
    [self.dataSource registerReuseIdentifiersForCollectionView:collectionView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     * Perform request.
     */
    
    [self requestEvents];
    
}

- (void)requestEvents {
    
    /*
     * Reset start.
     */
    
    EventsController *controller = self.eventsController;
    controller.start = nil;
    
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

- (void)eventsController:(EventsController *)eventsController didInsertEvents:(NSArray *)events intoEvents:(NSArray *)prevEvents {
    
    /*
     * Insert into collection view.
     */
    
    [self.collectionView reloadData];
    
    /*
     * Note that we're no longer
     * inserting more.
     */
    
    self.insertingMore = NO;
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    /*
     * Set up transitioning delegate
     */
    
    UICollectionViewLayoutAttributes *attributes = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect startFrame = attributes.frame;
    UIView *view = self.view;
    ZoomTransitioningDelegate *zoomTransitioningDelegate = self.zoomTransitioningDelegate;
    zoomTransitioningDelegate.startFrame = [collectionView convertRect:startFrame toView:view];
    
    /*
     * Transition.
     */
    
    NSInteger item = indexPath.item;
    EventsController *controller = self.eventsController;
    NSArray *events = controller.events;
    Event *event = events[item];
    Session *session = self.session;
    EventViewController *viewController = [[EventViewController alloc] initWithEvent:event session:session];
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    navigationController.viewControllers = @[ viewController ];
    navigationController.modalPresentationStyle = UIModalPresentationCustom;
    navigationController.transitioningDelegate = zoomTransitioningDelegate;
    [self presentViewController:navigationController animated:YES completion:nil];
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    /*
     * Determine if scrolled past delta.
     */
    
    CGPoint offset = scrollView.contentOffset;
    CGSize size = scrollView.contentSize;
    CGRect frame = scrollView.frame;
    if (offset.y + frame.size.height >= size.height - 30) {
        
        /*
         * If is inserting more or ineligible,
         * skip.
         */
        
        EventsController *controller = self.eventsController;
        Paging *paging = controller.paging;
        if (self.isInsertingMore || paging.limit >= paging.count) return;
        
        /*
         * Note that we're inserting more.
         */
        
        self.insertingMore = YES;
        
        /*
         * Fetch additional events.
         */
        
        NSArray *events = controller.events;
        Event *start = [events lastObject];
        controller.start = start;
        [controller insertEvents];
        
    }
    
}

#pragma mark - Refresh control handler

- (void)handleRefreshControl:(UIRefreshControl *)refreshControl {
    
    /*
     * Request!
     */
    
    [self requestEvents];
    
}

@end
