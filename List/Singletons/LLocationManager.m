//
//  LLocationManager.m
//  List
//
//  Created by Noah Portes Chaikin on 7/7/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LLocationManager.h"
#import "LReachabilityManager.h"

@interface LLocationManager () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) NSMutableArray *listeners;

@end

@implementation LLocationManager

static double const LLocationManagerDistanceMinimum = 804.67; // half a mile

+ (instancetype)sharedManager {
    static LLocationManager *sharedManager;
    if (!sharedManager) {
        sharedManager = [[LLocationManager alloc] init];
    }
    return sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Create location manager.
         */
        
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.distanceFilter = LLocationManagerDistanceMinimum;
        self.manager.activityType = CLActivityTypeOtherNavigation;
        self.manager.pausesLocationUpdatesAutomatically = YES;
        
        /*
         * Create emitter arrays.
         */
        
        self.listeners = [NSMutableArray array];
        
    }
    return self;
}

- (void)start {
    [self.manager requestWhenInUseAuthorization];
}

- (void)stop {
    [self.manager stopUpdatingLocation];
}

#pragma mark - Proxy methods

- (CLLocation *)location {
    return self.manager.location;
}

- (CLAuthorizationStatus)authorizationStatus {
    return [CLLocationManager authorizationStatus];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    [self emit:LLocationManagerEventUpdateLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    [self emit:LLocationManagerEventFailed];
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.manager startUpdatingLocation];
    }
    [self emit:LLocationManagerEventChangedAuthorizationStatus];
}


#pragma mark - An ugly event emitter.

- (void)addListener:(id<LLocationManagerListener>)listener {
    NSValue *value = [NSValue valueWithNonretainedObject:listener];
    [self.listeners addObject:value];
}

- (void)removeListener:(id<LLocationManagerListener>)listener {
    NSValue *value = [NSValue valueWithNonretainedObject:listener];
    [self.listeners removeObject:value];
}

- (void)emit:(LLocationManagerEvent)event {
    id<LLocationManagerListener> listener;
    for (NSValue *value in self.listeners) {
        listener = value.nonretainedObjectValue;
        if (listener) {
            [listener locationManager:self
                                event:event];
        }
    }
}

@end
