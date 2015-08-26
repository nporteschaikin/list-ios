//
//  MyLocationPicturesViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "MyLocationPicturesViewController.h"
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

@end
