//
//  LocationManager.h
//  List
//
//  Created by Noah Portes Chaikin on 8/14/15.
//  Copyright (c) 2015 Noah Portes Chaikin. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@class LocationManager;

@protocol LocationManagerDelegate <CLLocationManagerDelegate>
@end

@interface LocationManager : CLLocationManager
@end