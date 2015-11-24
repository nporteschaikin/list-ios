//
//  MyLocationPicturesViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MyLocationPicturesViewController.h"
#import "CreatePictureViewController.h"
#import "LocationTitleView.h"
#import "ClearNavigationBar.h"
#import "ListConstants.h"

@interface MyLocationPicturesViewController ()

@property (strong, nonatomic) LocationManager *locationManager;

@end

@implementation MyLocationPicturesViewController

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
    
    PicturesController *picturesController = self.picturesController;
    picturesController.mapCircle = mapCircle;
    
    /*
     * `super`!!!
     */
    
    [super viewWillAppear:animated];
    
}

#pragma mark - PicturesControllerDelegate

- (void)picturesControllerDidFetchPictures:(PicturesController *)picturesController {
    [super picturesControllerDidFetchPictures:picturesController];
    
    /*
     * Create title view.
     */
    
    LocationTitleView *titleView = [[LocationTitleView alloc] init];
    Placemark *placemark = picturesController.placemark;
    titleView.title = placemark.title;
    titleView.image = [UIImage listIcon:ListUIIconPictures size:kUINavigationBarDefaultImageSize];
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
    
    PicturesController *picturesController = self.picturesController;
    picturesController.mapCircle = mapCircle;
    
    /*
     * Reload.
     */
    
    [picturesController requestPictures];
    
}

#pragma mark - Button handler

- (void)handleBarButtonItem:(UIBarButtonItem *)item {
    
    /*
     * Create picture view controller.
     */
    
    Picture *picture = [[Picture alloc] init];
    Session *session = self.session;
    CreatePictureViewController *viewController = [[CreatePictureViewController alloc] initWithPicture:picture session:session];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[ClearNavigationBar class] toolbarClass:nil];
    navigationController.viewControllers = @[ viewController ];
    
    /*
     * Present.
     */
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

@end