//
//  GeoPostsTableViewController.m
//  List
//
//  Created by Noah Portes Chaikin on 7/6/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "GeoPostsTableViewController.h"
#import "LLocationManager.h"
#import "Constants.h"

@interface GeoPostsTableViewController () <LLocationManagerListener>

@end

@implementation GeoPostsTableViewController


- (void)viewDidLoad {
    
    /*
     * Listen to LLocationManager.
     */
    
    LLocationManager *manager = [LLocationManager sharedManager];
    [manager addListener:self];
    
    /*
     * `super`
     */
    
    [super viewDidLoad];
    
}

- (void)performRequest {
    
    /*
     * Update query
     */
    
    [self updateRequestQuery];
    
    /*
     * Update memory location.
     */
    
    LLocationManager *locationManager = [LLocationManager sharedManager];
    CLLocation *location = locationManager.location;
    
    if (location) {
        
        /*
         * `super`
         */
        
        [super performRequest];
        
    } else {
        
        /*
         * Handle no location.
         */
        
        if (locationManager.authorizationStatus != kCLAuthorizationStatusAuthorizedWhenInUse) {
            self.statusView.state = PostsTableViewStatusViewStateLocationManagerFailed;
            [self.refreshControl endRefreshing];
        }
        
    }
    
}

- (void)updateRequestQuery {
    LLocationManager *locationManager = [LLocationManager sharedManager];
    CLLocation *location = locationManager.location;
    
    /*
     * Set query.
     */
    
    self.postsController.location = location;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *radius = [userDefaults objectForKey:DiscoveryRadiusInMilesUserDefaultsKey];
    self.postsController.radius = [radius floatValue];
    
}

- (void)dealloc {
    LLocationManager *manager = [LLocationManager sharedManager];
    [manager removeListener:self];
}

#pragma mark - LLocationManagerListener

- (void)locationManager:(LLocationManager *)manager
                  event:(LLocationManagerEvent)event {
    
    switch (event) {
        case LLocationManagerEventUpdateLocation: {
            
            /*
             * If we have no location, perform request.
             */
            
            [self performRequest];
            break;
        }
        default: {
            break;
        }
    }
}

@end
