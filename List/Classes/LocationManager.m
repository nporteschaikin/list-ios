//
//  LocationManager.m
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import "LocationManager.h"
#import "ListConstants.h"

@implementation LocationManager

- (instancetype)init {
    if (self = [super init]) {
        
        /*
         * Set defaults.
         */
        
        self.desiredAccuracy = kCLLocationAccuracyBest;
        self.distanceFilter = kLocationManagerDistanceMinimum;
        self.activityType = CLActivityTypeOtherNavigation;
        self.pausesLocationUpdatesAutomatically = YES;
        
    }
    return self;
}

@end
