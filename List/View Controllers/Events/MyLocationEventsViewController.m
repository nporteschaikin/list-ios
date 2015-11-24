//
//  MyLocationEventsViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MyLocationEventsViewController.h"
#import "LocationTitleView.h"
#import "ListConstants.h"
#import "EventEditorViewController.h"
#import "BlackNavigationBar.h"

@interface MyLocationEventsViewController () <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) LocationManager *locationManager;

@end

@implementation MyLocationEventsViewController

- (instancetype)initWithSession:(Session *)session {
    if (self = [super initWithSession:session]) {
        
        /*
         * Create location manager.
         */
        
        self.locationManager = [[LocationManager alloc] init];
        self.locationManager.delegate = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * Add button navigation item.
     */
    
    UINavigationItem *navigationItem = self.navigationItem;
    UIImage *buttonImage = [UIImage listIcon:ListUIIconPlus size:kUINavigationBarDefaultImageSize];
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:buttonImage style:UIBarButtonItemStylePlain target:self action:@selector(handleBarButtonItem:)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    /*
     * Create map circle.
     */
    
    LocationManager *locationManager = self.locationManager;
    CLLocation *location = locationManager.location;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat radius = [[userDefaults objectForKey:kDiscoveryRadiusInMilesUserDefaultsKey] floatValue];
    MapCircle *mapCircle = [[MapCircle alloc] init];
    mapCircle.location = location;
    mapCircle.radius = radius;
    
    /*
     * Set map circle to latest we've got.
     */
    
    EventsController *eventsController = self.eventsController;
    eventsController.mapCircle = mapCircle;
    
    /*
     * `super`!!!
     */
    
    [super viewWillAppear:animated];
    
}

#pragma mark - EventsControllerDelegate

- (void)eventsControllerDidFetchEvents:(EventsController *)eventsController {
    [super eventsControllerDidFetchEvents:eventsController];
    
    /*
     * Create title view.
     */
    
    LocationTitleView *titleView = [[LocationTitleView alloc] init];
    Placemark *placemark = eventsController.placemark;
    titleView.title = placemark.title;
    titleView.image = [UIImage listIcon:ListUIIconEvents size:kUINavigationBarDefaultImageSize];
    self.navigationItem.titleView = titleView;
    
}

#pragma mark - LocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    /*
     * Get location.
     */
    
    CLLocation *location = locations[0];
    
    /*
     * Create map circle.
     */
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    CGFloat radius = [[userDefaults objectForKey:kDiscoveryRadiusInMilesUserDefaultsKey] floatValue];
    MapCircle *mapCircle = [[MapCircle alloc] init];
    mapCircle.location = location;
    mapCircle.radius = radius;
    
    /*
     * Set map circle to latest we've got.
     */
    
    EventsController *eventsController = self.eventsController;
    eventsController.mapCircle = mapCircle;
    
    /*
     * Reload.
     */
    
    [eventsController requestEvents];
    
}

#pragma mark - Button handler

- (void)handleBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Create new event.
     */
    
    Event *event = [[Event alloc] init];
    
    /*
     * Create and present editor.
     */
    
    EventEditorViewController *viewController = [[EventEditorViewController alloc] initWithEvent:event session:self.session];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage listIcon:ListUIIconCross size:kUINavigationBarCrossImageSize] style:UIBarButtonItemStyleDone target:self action:@selector(handleEventEditorViewControllerBarButtonItem:)];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[BlackNavigationBar class] toolbarClass:nil];
    navigationController.viewControllers = @[ viewController ];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

- (void)handleEventEditorViewControllerBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Dismiss editor.
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end